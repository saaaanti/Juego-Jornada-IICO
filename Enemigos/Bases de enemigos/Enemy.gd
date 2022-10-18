extends KinematicBody2D

class_name Enemy

export var max_speed = 40
export var life = 2
export var player_damage = 30
export var home_damage = 10
export var turret_damage = 40
export var value = 1
export var size_range = 0.1
export var shiny_chance = 0.05
export var shiny_size = 1
export var shiny_value_multiplier = 3
var dropeo = false

var taking_damage = false

func _physics_process(_delta):
	taking_damage = false

func _ready():
	var s = rand_range(scale.x - size_range, scale.x + size_range)
	
	
	if randf() < shiny_chance:
		
		s += shiny_size
		value *= shiny_value_multiplier
		
		# TODO: shader shiny
		$AnimatedSprite.modulate.a = .2
	
	scale = Vector2(s,s)

func die(loot = true):
	var e = load("res://Misc/Explosion.tscn").instance()
	get_parent().add_child(e)
	e.position = position
	
	if loot and not dropeo:
		dropeo = true
		for _i in range(value):
			var l = load("res://Misc/Monedita.tscn").instance()
			call_deferred("spawn_deferred", l)
	
	call_deferred("queue_free")
	
func spawn_deferred(l):
	get_parent().add_child(l)
	l.position = position
	
func take_damage(damage):
	var s = load("res://Misc/Sangre.tscn").instance()
	get_parent().add_child(s)
	s.position = position
	
	taking_damage = true
	life -= damage
	if life <= 0:
		die()
