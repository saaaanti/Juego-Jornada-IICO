extends Area2D

class_name TiroSimple

var travel_speed
var damage = 0

var velocity = Vector2.ZERO

func _process(delta):
	mover(delta)


func mover(delta):
	position += travel_speed * delta * 10 * Vector2.RIGHT.rotated(rotation)
	
	
func _on_BasicShot_body_entered(body):
	if body is Enemy:
		body.take_damage(damage)
		call_deferred("queue_free")
		
	elif body is TileMap: #O CUALQUIER OTRA COSA DEL FONDO CON LA QUE QUERAMOS INTERACTUAR NOSE
		print("Explota el tiro y partículas contra la pared en ", body.name)
		call_deferred("queue_free")
