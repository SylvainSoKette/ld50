extends Node

enum GamePhase {
	PREPARE,
	FIGHT
}

export (int) var starting_money := 10
export (int) var starting_wave := 1
export (int) var starting_prepare_time := 0
export (int) var max_prepare_time := 10
export (NodePath) var target_planet_path
export (int) var asteroid_min_distance := 1000
export (int) var asteroid_max_distance := 1500
export (float) var asteroid_min_velocity := 36.0
export (float) var asteroid_max_velocity := 96.0
export (PackedScene) var asteroid

onready var hud := $CanvasLayer/HUD
onready var planets_layer := $Space/Planets
onready var asteroids_layer := $Space/Asteroids
onready var turrets_layer := $Space/Turrets
onready var projectiles_layer := $Space/Projectiles
onready var player := $Space/Player

onready var music_player = $AudioStreamPlayer

var wave setget _set_wave
var money setget _set_money
var current_gamephase setget _set_current_gamephase
var prepare_time setget _set_prepare_time

var target_planet

# DEFAULT FUNCTIONS
func _ready():
	self.target_planet = self.get_node(target_planet_path)
	self.wave = starting_wave
	self.money = starting_money
	self._start_prepare_phase()

func _process(delta) -> void:
	if Input.is_action_just_released("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")
	_check_current_wave()

# MY FUNCTIONS
func _start_prepare_phase():
	self.current_gamephase = GamePhase.PREPARE
	self.prepare_time = 0
	hud.set_phase_max_progress(max_prepare_time)

func _start_fight_phase():
	self.current_gamephase = GamePhase.FIGHT
	# some curve for progression
	var asteroid_number := int((self.wave + 3) * 1.4523)
	for i in range(asteroid_number):
		_spawn_asteroid()

func _spawn_asteroid():
	if asteroid:
		var a = asteroid.instance()

		var random_radian = randf() * 2 * PI
		var direction = Vector2.UP
		direction = direction.rotated(random_radian)
		var random_distance = lerp(
			asteroid_min_distance,
			asteroid_max_distance,
			randf()
		)
		a.global_position = (
			target_planet.global_position 
			+ direction
			* random_distance
		)

		var random_speed = lerp(
			asteroid_min_velocity,
			asteroid_max_velocity,
			randf()
		)
		a.linear_velocity = -direction * random_speed

		a.connect("destroy_ze_planet", self, "_on_Asteroid_hit_earth")
		a.connect("i_die_free", self, "_on_Asteroid_die")
		self.asteroids_layer.add_child(a)
		a.set_player_warning(player)

func _check_current_wave():
	if current_gamephase != GamePhase.FIGHT:
		return
	if asteroids_layer.get_child_count() == 0:
		self.wave += 1
		self.money += 10
		_start_prepare_phase()

# CALLBACKS
func _on_Player_fire_ze_missile(payload, position, target):
	var p = payload.instance()
	p.target = weakref(target)
	p.position = position
	self.projectiles_layer.add_child(p)

func _on_Player_drop_turret(turret, position):
	var t = turret.instance()
	if self.money < t.price:
		t.queue_free()
	else:
		t.position = position
		t.connect("fire_ze_missile", self, "_on_Player_fire_ze_missile")
		self.turrets_layer.add_child(t)
		self.money -= t.price

func _on_GameClock_timeout():
	if self.current_gamephase == GamePhase.PREPARE:
		self.prepare_time += 1
		if self.prepare_time == max_prepare_time:
			_start_fight_phase()

func _on_Asteroid_hit_earth():
	get_tree().change_scene("res://scenes/LostCutscene.tscn")

func _on_Asteroid_die():
	self.money += 1

# GETTERS AND SETTERS
func _set_money(value:int) -> void:
	money = value
	hud.set_money(value)

func _set_wave(value:int) -> void:
	wave = value
	hud.set_wave(value)

func _set_current_gamephase(phase:int) -> void:
	current_gamephase = phase
	hud.set_phase(GamePhase.keys()[phase])

func _set_prepare_time(value:int) -> void:
	prepare_time = value
	hud.set_phase_progress(value)
