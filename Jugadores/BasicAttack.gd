extends Area2D



func _ready():
	$particulas.emitting = true
	$particulas2.emitting = true


func _on_Timer_timeout():
	call_deferred("queue_free")


func _on_BasicAttack_body_entered(body):
	if body is Enemy:
		print("Es enemy")
