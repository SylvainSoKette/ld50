extends Area2D

func find_target():
	for body in self.get_overlapping_bodies():
		if body is Asteroid:
			return body
