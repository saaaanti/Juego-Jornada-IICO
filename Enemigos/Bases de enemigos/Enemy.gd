extends KinematicBody2D

class_name Enemy

export var max_speed = 40
export var life = 2
export var player_damage = 30
export var home_damage = 10
export var turret_damage = 40
export var value = 1



func die(loot = true):
	var e = load("res://Misc/Explosion.tscn").instance()
	get_parent().add_child(e)
	e.position = position
	
	if loot:
		for _i in range(value):
			var l = load("res://Misc/Monedita.tscn").instance()
			call_deferred("spawn_deferred", l)
	
	call_deferred("queue_free")
	
func spawn_deferred(l):
	get_parent().add_child(l)
	l.position = position
	
func take_damage(damage):
	life -= damage
	if life <= 0:
		die()
