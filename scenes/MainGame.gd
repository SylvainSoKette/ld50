extends Node


func _process(delta) -> void:
	if Input.is_action_just_released("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")
