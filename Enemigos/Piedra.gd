extends KinematicBody2D

enum {HOVER, FALL, LAND, RISE}

var state = HOVER

onready var starting_position = global_position

onready var timer = $Timer
onready var sprite = $AnimatedSprite
onready var particles = $Particles2D

onready var hitbox = $Hitbox/CollisionShape2D

var velocity = Vector2.ZERO
export var speed = 3000

var was_on_floor

func _physics_process(delta):
	
	was_on_floor = is_on_floor()
	
	
	
	match state:
		HOVER:
			hover()
		FALL:
			fall(delta)
		LAND:
			land()
		RISE:
			rise(delta)

func hover():
	hitbox.disabled = true
	sprite.play("Rising")
	velocity.y = 0
	state = FALL
	
func fall(delta):
	hitbox.disabled = false
	sprite.play("Falling")
	velocity.y += speed * delta
	velocity.y = min(velocity.y, 250)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor() and not was_on_floor:
		state = LAND
		timer.start(1)
		
		# TODO: las particulas salen en cada choque, auqneu sea con le jugador
		particles.restart()
		particles.emitting = true
		
		

func land():
	hitbox.disabled = false
	sprite.play("Falling")
	velocity.x = 0
	if timer.time_left == 0:
		state = RISE
	
func rise(delta):
	hitbox.disabled = true
	
	# Si un jugador se para arriba lo tira con mas fuerza
	
	sprite.play("Rising")
	position = lerp(position, starting_position, 4 * delta)
	
	
	
	if position.y - starting_position.y < 0.1:
		state = HOVER
