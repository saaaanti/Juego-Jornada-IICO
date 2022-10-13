extends Enemy

class_name Flying_Enemy



var velocity = Vector2.ZERO
onready var agent = $NavigationAgent2D


func _ready():

	if is_instance_valid(Singleton.base):
		call_deferred("set_target")

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
		
		velocity += (global_position.direction_to(agent.get_next_location()) * max_speed - velocity) * delta * 4
