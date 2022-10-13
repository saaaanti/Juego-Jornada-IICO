extends "res://Misc/Hitbox.gd"

func damage_player(body):
	body.take_damage(global_position, get_parent().player_damage)
	$"..".die()
