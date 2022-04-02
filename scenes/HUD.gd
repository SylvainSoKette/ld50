extends Control


onready var wave_level_label = $Top/Wave/AmountLabel
onready var money_amount_label = $Top/Money/Label

func set_money_mount(amount:int):
	money_amount_label.text = str(amount)

func set_starting_wave(wave:int):
	wave_level_label.text = str(wave)
