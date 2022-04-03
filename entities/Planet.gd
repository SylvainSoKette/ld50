tool
extends StaticBody2D

class_name Planet

export (int) var pixel_size
export (int) var mass
export (int) var well_radius
export (bool) var has_indicator = true

onready var collision_shape = $CollisionShape2D
onready var gravity_well = $GravityWell
onready var player_detector = $PlayerDetector

func _ready():
	collision_shape.shape.radius = pixel_size / 2

	if mass:
		gravity_well.mass = mass
	if well_radius:
		gravity_well.well_radius = well_radius

	if !has_indicator:
		player_detector.hide()
		player_detector.set_process(false)
