extends Control


export (float) var speed := 3.1415

onready var asteroid := $Asteroid


func _ready() -> void:
	randomize()


func _process(delta) -> void:
	if (Input.is_action_just_released("ui_accept")
		or Input.is_action_just_released("ui_cancel")):
		get_tree().change_scene("res://scenes/MainMenu.tscn")


	var max_size := get_viewport_rect().size
	if asteroid.position.x > max_size.x:
		asteroid.translate(Vector2.LEFT * (max_size.x + 32))
		asteroid.position.y = randi() % int(max_size.y)
	asteroid.translate(Vector2.RIGHT * speed)
