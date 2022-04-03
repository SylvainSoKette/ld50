extends Area2D

class_name GravityWell

export (int) var mass
export (int) var well_radius

onready var parent = $".."
onready var collision_shape = $CollisionShape2D


func _physics_process(_delta) -> void:
	for body in self.get_overlapping_bodies():
		if body is Asteroid:
			var distance:Vector2 = parent.global_position - body.global_position 
			var direction:Vector2 = distance.normalized()
			var force:float = Globals.G * self.mass / distance.length_squared() 
			body.apply_central_impulse(direction * force)

func set_mass(value:int) -> void:
	self.mass = value

func set_well_radius(value:int) -> void:
	self.well_radius = value
	collision_shape.shape.radius = well_radius
