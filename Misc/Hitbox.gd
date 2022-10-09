extends Area2D


func _process(delta):
	for body in get_overlapping_bodies():
		if body is Jugador:
			if body.state != body.DEAD:
				body.take_damage(global_position, get_parent().player_damage)
			
	for area in get_overlapping_areas():
		if area is Torreta:
			area.take_damage(get_parent().turret_damage)

