extends Area2D

class_name Hitbox

var hit = false

func _process(_delta):
	hit = false
	check_bodies()
				
			
	

func check_bodies():
	for body in get_overlapping_bodies():
		if body is Jugador:
			if body.state != body.DEAD and body.state != body.REVIVING:
				damage_player(body)
				
func damage_player(body):
	body.take_damage(global_position, get_parent().player_damage)
	
func check_areas():
	for area in get_overlapping_areas():
		if area is Torreta:
			damage_torretas(area)
			
func damage_torretas(area):
	area.take_damage(get_parent().turret_damage)
