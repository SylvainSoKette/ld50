extends RigidBody2D

class_name Missile

export (float) var propulsion_force := 10
export (float) var propulsion_time := 100
export (float) var lifetime := 3000
export (Vector2) var direction := Vector2.RIGHT

onready var tip := $Tip

var target


func _process(delta):
	self.lifetime -= delta
	if self.lifetime == 0:
		self.self_destruct()


func _physics_process(delta):
	for body in tip.get_overlapping_bodies():
		if body is Asteroid:
			body.explode()
			self.self_destruct()
			break

	self.propulsion_time -= delta

	if target.get_ref():
		self.direction = self.global_position.direction_to(
			target.get_ref().global_position
		)

	self.rotation = direction.angle()

	if propulsion_time > 0:
		self.apply_central_impulse(direction * propulsion_force)


func self_destruct():
	self.queue_free()
