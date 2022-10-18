extends Area2D



var travel_speed
var damage = 0

var velocity = Vector2.ZERO

var toco = false

func _ready():
	$CPUParticles2D.emitting = true
	$CPUParticles2D/CPUParticles2D.emitting = true
	




func _on_Area2D_body_entered(body):
	if body is Enemy:
		if not body.taking_damage:
			body.take_damage(damage)
		

#	elif body is TileMap: #O CUALQUIER OTRA COSA DEL FONDO CON LA QUE QUERAMOS INTERACTUAR NOSE
#		print("Explota el tiro y partículas contra la pared en ", body.name)
#		call_deferred("queue_free")


func _on_Timer_timeout():
	call_deferred("queue_free")
