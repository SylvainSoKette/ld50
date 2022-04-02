extends Node

var G := 9.81

func _ready():
	VisualServer.set_default_clear_color(Color(
		24.0 / 255.0,
		20.0 / 255.0,
		37.0 / 255.0,
		1.0
	))

func _process(delta) -> void:
	if Input.is_action_just_released("toggle_fullscreen"):
		OS.set_window_fullscreen(!OS.window_fullscreen)
