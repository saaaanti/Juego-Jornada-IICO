extends AnimatedSprite

onready var target_rotation = randi() % 180

func _ready():
	playing = true
	rotation_degrees = randi() % 180
	
	
	
func _process(_delta):
	rotation = lerp_angle(rotation, deg2rad(target_rotation), 0.1)

func _on_Explosion_animation_finished():
	queue_free()
