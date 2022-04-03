extends RigidBody2D

class_name Asteroid

signal destroy_ze_planet

onready var player_detector = $PlayerDetector


func set_player_warning(player) -> void:
	self.player_detector.player = player


func _physics_process(delta):
	for body in self.get_colliding_bodies():
		if body is Planet and body.name == "Earth":
			emit_signal("destroy_ze_planet")
		explode()


func explode() -> void:
	queue_free()
