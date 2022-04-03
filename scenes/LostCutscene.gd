extends Control


func _process(delta):
	if Input.is_action_just_released("ui_cancel"):
		get_tree().quit()


func _on_ButtonRestart_pressed():
	get_tree().change_scene("res://scenes/MainGame.tscn")


func _on_ButtonMainMenu_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_ButtonQuit_pressed():
	get_tree().quit()
