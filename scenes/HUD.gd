extends Control


onready var wave_level_label = $Top/Wave/AmountLabel
onready var money_amount_label = $Top/Money/Label
onready var phase_label = $Top/Phase/PhaseLabel
onready var phase_progress_bar = $Top/Phase/PhaseProgress


func set_wave(wave:int):
	wave_level_label.text = str(wave)

func set_money(amount:int):
	money_amount_label.text = str(amount)

func set_phase(phase:String):
	phase_label.text = phase

func set_phase_progress(value:int):
	phase_progress_bar.value = value

func set_phase_max_progress(value:int):
	phase_progress_bar.max_value = value
