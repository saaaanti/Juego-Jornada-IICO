extends KinematicBody2D

var direction = Vector2.LEFT
var velocity = Vector2.ZERO

export var speed = 25

onready var bordeIzq = $bordeIzq
onready var bordeDer = $bordeDer

onready var sprite = $AnimatedSprite


func _physics_process(_delta):
	
	var on_wall = is_on_wall()
	var on_ledge = not bordeDer.is_colliding() or not bordeIzq.is_colliding()
	
	
	if on_wall or on_ledge:
		direction *= -1
	
		sprite.flip_h = not sprite.flip_h
	
	velocity = direction * speed
	
	velocity = move_and_slide(velocity, Vector2.UP)
