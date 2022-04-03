tool
extends StaticBody2D

class_name Planet

enum Planets {
	MERCURY,
	VENUS,
	EARTH,
	MARS,
	JUPITER,
	SATURN,
	URANUS,
	NEPTUNE
}

var sprites = {
	Planets.MERCURY: {
		'main': Rect2(0, 16, 16, 16),
		'indicator': Rect2(64, 144, 16, 16),
	},
	Planets.VENUS: {
		'main': Rect2(32, 32, 32, 32),
		'indicator': Rect2(80, 144, 16, 16),
	},
	Planets.EARTH: {
		'main': Rect2(0, 32, 32, 32),
		'indicator': Rect2(96, 144, 16, 16),
	},
	Planets.MARS: {
		'main': Rect2(0, 0, 16, 16),
		'indicator': Rect2(112, 144, 16, 16),
	},
	Planets.JUPITER: {
		'main': Rect2(64, 0, 128, 128),
		'indicator': Rect2(128, 144, 16, 16),
	},
	Planets.SATURN: {
		'main': Rect2(192, 0, 128, 128),
		'indicator': Rect2(144, 144, 16, 16),
	},
	Planets.URANUS: {
		'main': Rect2(0, 64, 64, 64),
		'indicator': Rect2(160, 144, 16, 16),
	},
	Planets.NEPTUNE: {
		'main': Rect2(0, 128, 64, 64),
		'indicator': Rect2(176, 144, 16, 16),
	},
}

export (Planets) var planet_type
export (int) var pixel_size
export (int) var mass
export (int) var well_radius
export (bool) var has_indicator = true

onready var collision_shape = $CollisionShape2D
onready var gravity_well = $GravityWell
onready var player_detector = $PlayerDetector
onready var sprite = $Sprite

var texture:Texture = preload("res://assets/sprites/spirtesheet.png")

func _ready():
	gravity_well.set_mass(self.mass)
	gravity_well.set_well_radius(self.well_radius)
#	collision_shape.shape.radius = int(pixel_size / 2)

	_set_texture(sprite, 'main')
	_set_texture(player_detector.indicator, 'indicator')

	if mass:
		gravity_well.mass = mass
	if well_radius:
		gravity_well.well_radius = well_radius

	if !has_indicator:
		player_detector.hide()
		player_detector.set_process(false)


func _set_texture(s, type):
	s.texture = texture
	s.region_enabled = true
	s.region_rect = sprites[self.planet_type][type]
