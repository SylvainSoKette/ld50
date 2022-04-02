extends Node

enum GamePhase {
	PREPARE,
	FIGHT
}

export (int) var starting_money := 10
export (int) var starting_wave := 1

onready var hud := $CanvasLayer/HUD

var current_gamephase = GamePhase.PREPARE


func _ready():
	hud.set_money_mount(starting_money)
	hud.set_starting_wave(starting_wave)


func _process(delta) -> void:
	if Input.is_action_just_released("ui_cancel"):
		get_tree().change_scene("res://scenes/MainMenu.tscn")
