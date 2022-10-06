extends KinematicBody2D

export var target_path = NodePath()
export var max_speed = 40

var velocity = Vector2.ZERO

onready var target = get_node(target_path)

onready var agente = $NavigationAgent2D

func _ready():
	agente.set_target_location(target.global_position)
	
func _physics_process(delta):
	var direction = global_position.direction_to(agente.get_next_location())
	
	var velocity_objetivo = direction * max_speed
	var giro = (velocity_objetivo - velocity) * delta * 4
	velocity += giro
	
	velocity = move_and_slide(velocity)
	
