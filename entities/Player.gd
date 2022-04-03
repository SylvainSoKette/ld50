extends KinematicBody2D

class_name Player

signal fire_ze_missile(payload, position, target)

export (float) var move_speed := 160.0
export (PackedScene) var payload = preload("res://entities/Missile.tscn")

onready var current_speed := move_speed

onready var sprite := $Sprite
onready var radar := $Radar


func _process(delta):
	if Input.is_action_just_pressed("fire"):
		var target = radar.find_target()
		emit_signal("fire_ze_missile", payload, self.global_position, target)


func _physics_process(delta) -> void:
	_move()


func _move() -> void:
	var dir := Vector2.ZERO
	
	dir.x += Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	dir.y += Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	dir = dir.normalized()

	if dir.x != 0:
		sprite.flip_h = dir.x < 0

	move_and_slide(dir * current_speed)
