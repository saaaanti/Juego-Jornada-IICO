extends Node2D

class_name Home

var vida = 100

func _on_HitBox_body_entered(body):
	if body is Enemy:
		vida -= body.home_damage
		body.die(false)

func _process(delta):
	if vida <= 0:
		$HitBox/CollisionShape2D.disabled = true
