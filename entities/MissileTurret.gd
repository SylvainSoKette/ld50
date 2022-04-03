extends Node2D

class_name MissileTurret

signal fire_ze_missile(payload, position, target)

export (int) var price = 10
export (PackedScene) var payload = preload("res://entities/Missile.tscn")
export (float) var reload_time = 1

onready var radar = $Radar

var can_fire := true

func _process(delta) -> void:
	var target = radar.find_target()
	if can_fire and target:
		can_fire = false
		emit_signal("fire_ze_missile", payload, self.global_position, target)
		yield(get_tree().create_timer(reload_time), "timeout")
		can_fire = true
