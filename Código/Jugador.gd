extends KinematicBody2D

# Velocidad es la variable que vamos modificando con el input
# para despues aplicársela al KinematicBody
var velocity = Vector2.ZERO

onready var animatedSprite = $AnimatedSprite

# Variables de movimiento, modificables
# Distintas entre p1 y p2?
export var gravity = 7
export var max_fall_speed = 400
export var jump_force = -180
export var jump_release = 0.5
export var fall_speed = 14
export var friction = 5
export var acceleration = 10
export var max_speed = 70

# para cambiar la skin, se puede hacer mas mejor
export var skin_path = "res://Recursos/SkinAzulAnim.tres"

# Falso es flechitas, True es WASD
export(bool) var control1 = true

var up 
var down
var left 
var right 

func _ready():
	
	# Seteamos el esquema de controles que le corresponda
	if control1:
		up = "p1_up"
		down = "p1_down"
		left = "p1_left"
		right = "p1_right"
	else:
		up = "p2_up"
		down = "p2_down"
		left = "p2_left"
		right = "p2_right"
	
	# Cargamos la skin seleccionada al animated sprite
	animatedSprite.frames = load(skin_path)
	animatedSprite.play("Idle")
	
	

func _physics_process(delta):
	apply_gravity()
	
	# Input son dos valores X, Y, que van de -1 a 1, sirve como está para analógico
	var input = Vector2.ZERO
	input.x = Input.get_action_strength(right) - Input.get_action_strength(left)


	# Movimiento horizontal
	
	if input.x == 0: # Quieto
		apply_friction()
		animatedSprite.play("Idle")
		
	else: # En movimiento
		apply_acceleration(input.x)
		animatedSprite.play("Run")
		animatedSprite.flip_h = input.x > 0 # Que mire para el lado que quiera

	if is_on_floor():
		if Input.is_action_just_pressed(up):
			# Ahora salta solo cuando tocás, 
			#dando la senscación d que no salta cuando uno salta justo antes,
			# se puede sacar el "just" pero no está bueno
			velocity.y = jump_force
			
	else: # Estamos en el aire
		animatedSprite.play("Jump")
		
		if Input.is_action_just_released(up) and velocity.y < 0: # Si cortamos el salto antes del maximo
			velocity.y *= jump_release
			
		if velocity.y > 0: # Aplicamos una fuerza extra
			velocity.y += fall_speed
			

	var was_in_air = not is_on_floor() # Para acomodar la animaciónm del aterrizaje

	velocity = move_and_slide(velocity, Vector2.UP) # Aplicar el movimiento

	if is_on_floor() and was_in_air: # Acomodamos el aterrizaje
		animatedSprite.play("Run")
		animatedSprite.frame = 1
		

func apply_gravity():
	velocity.y += gravity
	velocity.y = max(velocity.y, max_fall_speed)

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, friction)

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, max_speed * amount, acceleration)
