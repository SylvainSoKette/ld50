extends StaticBody2D

class_name Planet

export (int) var mass := 1000

onready var gravity_well = $GravityWell


func _physics_process(_delta) -> void:
	if gravity_well:
		for body in gravity_well.get_overlapping_bodies():
			if body is Asteroid:
				var distance:Vector2 = self.global_position - body.global_position 
				var direction:Vector2 = distance.normalized()
				var force:float = Globals.G * self.mass / distance.length_squared() 
				body.apply_central_impulse(direction * force)
