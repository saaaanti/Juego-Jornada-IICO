extends Area2D



func _on_Area2D_body_entered(body):
	print("Chocamos con ", body)
	if body is Jugador: 
		print("Deletiando")
		body.respawn()
