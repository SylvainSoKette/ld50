extends Control

func _process(delta):
	if Input.is_action_just_released("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_Back_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
