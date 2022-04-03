extends Area2D

class_name Radar

func find_target():
	for body in self.get_overlapping_bodies():
		if body is Asteroid:
			return body
	return null
