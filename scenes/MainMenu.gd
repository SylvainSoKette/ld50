extends Control


func _process(delta):
	if Input.is_action_just_released("ui_cancel"):
		get_tree().quit()


func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/MainGame.tscn")


func _on_StoryButton_pressed():
	get_tree().change_scene("res://scenes/Story.tscn")


func _on_ControlsButton_pressed():
	get_tree().change_scene("res://scenes/Controls.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
