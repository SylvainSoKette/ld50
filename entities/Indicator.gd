extends Area2D

onready var indicator = $Indicator
onready var planet = $".."

var player

func _process(delta):
	var player_close := false
	for body in self.get_overlapping_bodies():
		if body is Player:
			player_close = true
			player = body
			break

	indicator.visible = !player_close
	if !player_close and player:
		var distance:Vector2 = self.planet.position - player.position
		var direction:Vector2 = distance.normalized()
		var display_ditance = min(get_viewport().size.x/6, get_viewport().size.y/6) - 8
		indicator.global_position = player.position + direction * display_ditance
