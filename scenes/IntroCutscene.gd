extends Control


onready var asteroid := $Asteroid


func _ready() -> void:
	randomize()


func _process(delta) -> void:
	if Input.is_action_pressed("ui_accept"):
		_go_to_main_menu()


	var max_size := get_viewport_rect().size
	if asteroid.position.x > max_size.x:
		asteroid.translate(Vector2.LEFT * (max_size.x + 32))
		asteroid.position.y = randi() % int(max_size.y)
	asteroid.translate(Vector2.RIGHT)


func _input(event):
	if event is InputEventKey:
		_go_to_main_menu()


func _go_to_main_menu() -> void:
	get_tree().change_scene("res://scenes/MainMenu.tscn")
