extends KinematicBody2D

class_name Player

signal fire_ze_missile(payload, position, target)
signal drop_turret(turret, position)

export (float) var move_speed := 160.0
export (PackedScene) var payload = preload("res://entities/Missile.tscn")
export (float) var reload_time := 0.7
export (PackedScene) var missile_turret = preload("res://entities/MissileTurret.gd")

onready var current_speed := move_speed

onready var sprite := $Sprite
onready var radar := $Radar

var can_fire := true

func _process(delta):
	_fire()
	_place_missile_turret()

func _physics_process(delta) -> void:
	_move()


func _move() -> void:
	var dir := Vector2.ZERO
	
	dir.x += Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	dir.y += Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	dir = dir.normalized()

	if dir.x != 0:
		sprite.flip_h = dir.x < 0

	var boost_speed = 1
	if Input.is_action_pressed("boost"):
		boost_speed = 3
	move_and_slide(dir * current_speed * boost_speed)

func _fire() -> void:
	if can_fire and Input.is_action_just_pressed("fire"):
		can_fire = false
		var target = radar.find_target()
		emit_signal("fire_ze_missile", payload, self.global_position, target)
		yield(get_tree().create_timer(reload_time), "timeout")
		can_fire = true

func _place_missile_turret() -> void:
	if Input.is_action_just_pressed("place_turret"):
		emit_signal("drop_turret", missile_turret, self.global_position)
