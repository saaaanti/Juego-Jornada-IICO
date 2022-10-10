extends KinematicBody2D

class_name Jugador


# State machine
enum {
	MOVE,
	CLIMB,
	DEAD,
	REVIVING,
	SHOP
}

var state = MOVE
var inmune = false


# Velocidad es la variable que vamos modificando con el input
# para despues aplicársela al KinematicBody
var velocity = Vector2.ZERO

onready var animatedSprite = $Mirror/AnimatedSprite
onready var mirror = $Mirror

onready var health = $UI/HealthBar
export var ataque = preload("res://Jugadores/BasicAttack.tscn")
onready var jumpBuffer: = $JumpBuffer
onready var coyoteTimer: = $Coyote
var bufferedJump = false
var coyote = false

onready var tienda = $Tienda

onready var acd = $attackCD

export var vida = 100

# Variables de movimiento, modificables
# Distintas entre p1 y p2?
# Ahora si con el Resource

export(Resource) var moveData

# para cambiar la skin, se puede hacer mas mejor
export var skin_path = "res://Recursos/SkinAzulAnim.tres"

# Falso es flechitas, True es WASD
export(bool) var control1 = true

var up 
var down
var left 
var right
var action

onready var ladderCheck = $LadderCheck

onready var reviveArea = $Revivir/CollisionShape2D

var double_jump = 0

var spawn_position

func _ready():
	Singleton.players.append(self)
	spawn_position = position
	
	# Seteamos el esquema de controles que le corresponda
	if control1:
		up = "p1_up"
		down = "p1_down"
		left = "p1_left"
		right = "p1_right"
		action = "p1_action"
	else:
		up = "p2_up"
		down = "p2_down"
		left = "p2_left"
		right = "p2_right"
		action = "p2_action"
	
	# Cargamos la skin seleccionada al animated sprite
	animatedSprite.frames = load(skin_path)
	animatedSprite.play("Idle")
	
	
func _physics_process(delta):

	if inmune:
		animatedSprite.scale = lerp(animatedSprite.scale, Vector2(0.5, 0.5), 0.1)
	else:
		animatedSprite.scale = lerp(animatedSprite.scale, Vector2(1, 1), 0.1)

	# Input son dos valores X, Y, que van de -1 a 1, sirve como está para analógico
	var input = Vector2.ZERO
	
	input.x = Input.get_axis(left, right)
	input.y =  Input.get_axis(up, down)
	
	if state != SHOP:
		tienda.hide()
	
	match state:
		MOVE: move_state(input, delta)
		CLIMB: climb_state(input)
		DEAD: dead_state( delta)
		REVIVING: reviving_state(delta)
		SHOP: shop_state()
		
	health.hp = vida
	
func dead_state(delta):
	reviveArea.disabled = false
	# Le bajamos el Z_index para que quede atrás
	# El tema es que la barra de vida queda por atrás pero capaz despues pongo un relojito arriba
	
	vida = lerp(vida, 0, 0.1)
	
	
	z_index = 5
	
	animatedSprite.play("Jump")
	
	
	
	mirror.rotation = lerp_angle(mirror.rotation, mirror.scale.x *- PI/2, 0.3)
	mirror.position.y = lerp(mirror.position.y, 5 , 0.5)
	
	for i in reviveArea.get_parent().get_overlapping_bodies():
		# No deberiía hacer falta el if
		#if i is Jugador:
		if i != self:
			state = REVIVING
		
	
	
	dead_slide(delta)
	
	
func shop_state():
	apply_friction()
	tienda.show()
	
	animatedSprite.play("Idle")
	
	# TODO: que cosas nos pueden cortar la tienda
	if Input.is_action_just_pressed(down):
		tienda.hide()
		state = MOVE
	
	if Input.is_action_just_pressed(left):
		tienda.left()
	elif Input.is_action_just_pressed(right):
		tienda.right()
	

func dead_slide(delta):
	apply_gravity(delta)
	
	velocity.x = move_toward(velocity.x, 0, 0.8) # TODO magic number, deslizamiento cuando muere
	# Se podría cambiar a que sea un rigid body y salga volando
	velocity = move_and_slide(velocity)
	# Está el riesgo de que se nos escape mientras lo revivimos,
	# La otra es qeu reviviendo se quede tieso, pero en el aire flota
	# Si no hacemos que revivir edsactive el movimiento en x


func reviving_state(delta):
	var f = false
	
	dead_slide(delta)
	
	for i in reviveArea.get_parent().get_overlapping_bodies():
		# No deberiía hacer falta el if
		#if i is Jugador:
		if i != self and i.state != DEAD and i.state != REVIVING:

			f = true
			break
			
	if f:
		vida += 1 # TODO: no me gusta que sean dos cosas distintas, 	
	 # Hacer una sola función acá qeu me llame la de la barra
		
		if vida >= 100:
			vida = 100
			
			mirror.rotation = 0
			mirror.position.y = 0 # TODO transición mejor
			state = MOVE
	
	else:
		state = DEAD
	
	
#	justDied = true

func attack():
	var a = ataque.instance()
	get_parent().add_child(a)
	a.global_position = global_position
	a.scale.x = mirror.scale.x
	acd.start()
	

func move_state(input, delta):
	if Input.is_action_pressed(action) and acd.time_left <= 0:
		attack()
	
	
	reviveArea.disabled = true
	z_index = 10
	# Se le puede poner un just pero no se como queda mejor
	if is_on_ladder() and Input.is_action_pressed(up): state = CLIMB
	
	if is_on_floor() and Input.is_action_just_pressed(down): state = SHOP
	
	apply_gravity(delta)
	# Movimiento horizontal
	
	if input.x == 0: # Quieto
		apply_friction()
		animatedSprite.play("Idle")
		
	else: # En movimiento
		apply_acceleration(input.x)
		animatedSprite.play("Run")
		mirror.scale = Vector2(input.x, 1)
		#animatedSprite.flip_h = input.x > 0 # Que mire para el lado que quiera
	
	
	 # Reseteamos los saltos dobles
	
	if coyote or is_on_floor():
		input_jump()
		
	
	if is_on_floor():
		double_jump = moveData.saltos_dobles
		
	else: # Estamos en el aire
		animatedSprite.play("Jump")
		#print("On air, coyote = ", coyote, " , dobles: ", double_jump)
		if Input.is_action_just_released(up) and velocity.y < 0: # Si cortamos el salto antes del maximo
			velocity.y *= moveData.jump_release
		
		if Input.is_action_just_pressed(up) :
			#print("Apretamos en el aire, coyote: ", coyote, ", doble: ", double_jump)
			
			if coyote:
				SoundPlayer.play_audio(SoundPlayer.SALTO)
				velocity.y = moveData.jump_force
				coyote = false
				
			elif double_jump > 0:
				SoundPlayer.play_audio(SoundPlayer.SALTO)
				velocity.y = moveData.jump_force
				double_jump -= 1
			else:
				bufferedJump = true
				jumpBuffer.start()
	
			
		
		if velocity.y > 0: # Aplicamos una fuerza extra
			velocity.y += moveData.fall_speed * delta
			

	var was_in_air = not is_on_floor() # Para acomodar la animaciónm del aterrizaje
	

	velocity = move_and_slide(velocity, Vector2.UP) # Aplicar el movimiento

	if is_on_floor() and was_in_air: # Acomodamos el aterrizaje
		animatedSprite.play("Run")
		animatedSprite.frame = 1
		SoundPlayer.play_audio(SoundPlayer.ATERRIZAJE)
		
	var just_left_ground = not was_in_air and not is_on_floor()
	
	if just_left_ground and velocity.y >= 0:
	
		
		coyote = true
		coyoteTimer.start()
	
func climb_state(input):
	reviveArea.disabled = true
	double_jump = moveData.saltos_dobles
	
	if not is_on_ladder(): state = MOVE
	
	if input.length() != 0:
		animatedSprite.play("Run")
	else:
		animatedSprite.play("Idle")
	
	velocity = input * moveData.climb_speed
	velocity = move_and_slide(velocity)

func is_on_ladder():
	if not ladderCheck.is_colliding() or not ladderCheck.get_collider():
		return false
	return true

func apply_gravity(delta):
	velocity.y += moveData.gravity * delta
	velocity.y = min(velocity.y, moveData.max_fall_speed)

func apply_friction():
	
	velocity.x = move_toward(velocity.x, 0, moveData.friction)
	

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, moveData.max_speed * amount, moveData.acceleration)

func take_damage(hit_position, damage):
	if inmune:
		return
	inmune = true
	$stasis.start()
	vida -= damage
	
	
	#print("La vida es, ", vida)
	var a = load("res://Misc/Explosion.tscn").instance()
	get_parent().add_child(a)
	a.position = hit_position
	SoundPlayer.play_audio(SoundPlayer.HURT)
	if vida <= 0:
		die()
	#queue_free()

func die():
	inmune = false
	state = DEAD

func input_jump():
	if Input.is_action_just_pressed(up) or bufferedJump:
		SoundPlayer.play_audio(SoundPlayer.SALTO)
		velocity.y = moveData.jump_force
		bufferedJump = false

func _on_JumpBuffer_timeout():
	bufferedJump = false

func _on_Coyote_timeout():
	coyote = false

func respawn():
	state = DEAD
	position = spawn_position



func _on_stasis_timeout():
	inmune = false
