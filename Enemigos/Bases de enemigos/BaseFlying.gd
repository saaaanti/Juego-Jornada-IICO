extends KinematicBody2D

class_name Flying_Enemy



var velocity = Vector2.ZERO

export(Resource) var data = load("res://Enemigos/Bases de enemigos/BaseFlyingResource.tres")

onready var agent = $NavigationAgent2D

func _ready():

	
	set_target()

func _physics_process(delta):
	follow_path(delta)
	move()
	vel_flip()
	
func set_target():
	agent.set_target_location(Singleton.base.position)

func vel_flip():
	$AnimatedSprite.flip_h = velocity.x > 0
	
func move():
	velocity = move_and_slide(velocity)
	
func follow_path(delta):
	if not agent.is_navigation_finished():
		
		var direccion = global_position.direction_to(agent.get_next_location())
		var d_velocity = direccion * data.max_speed
		
		var giro = (d_velocity - velocity) * delta * 4
		velocity += giro
