extends KinematicBody2D

class_name Player


export (float) var move_speed := 160.0

onready var current_speed := move_speed

onready var sprite := $Sprite


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
