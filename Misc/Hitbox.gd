extends Area2D


func _on_Hitbox_body_entered(body):
	if body is Jugador:
		body.take_damage(global_position)
