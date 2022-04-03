extends Node

enum GamePhase {
	PREPARE,
	FIGHT
}

export (int) var starting_money := 10
export (int) var starting_wave := 1
export (int) var starting_prepare_time := 0
export (int) var max_prepare_time := 10
export (NodePath) var target_planet
export (int) var asteroid_min_distance := 10
export (int) var asteroid_max_distance := 100
export (PackedScene) var asteroid

onready var hud := $CanvasLayer/HUD
onready var planets_layer := $Space/Planets
onready var asteroids_layer := $Space/Asteroids
onready var turrets_layer := $Space/Turrets
onready var projectiles_layer := $Space/Projectiles
onready var player := $Space/Player

var wave setget _set_wave
var money setget _set_money
var current_gamephase setget _set_current_gamephase
var prepare_time setget _set_prepare_time

# DEFAULT FUNCTIONS
func _ready():
	self.wave = starting_wave
	self.money = starting_money
	self._start_prepare_phase()

func _start_prepare_phase():
	self.current_gamephase = GamePhase.PREPARE
	self.prepare_time = 0
	hud.set_phase_max_progress(max_prepare_time)

func _start_fight_phase():
	pass

func _process(delta) -> void:
	if Input.is_action_just_released("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")

# MY FUNCTIONS
func _spawn_asteroid():
	pass

# CALLBACKS
func _on_Player_fire_ze_missile(payload, position, target):
	if money > 0:
		var p = payload.instance()
		p.target = weakref(target)
		p.position = position
		self.projectiles_layer.add_child(p)
		self.money -= 1

func _on_GameClock_timeout():
	if self.current_gamephase == GamePhase.PREPARE:
		self.prepare_time += 1

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
