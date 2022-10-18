extends CPUParticles2D

func _ready():
	print("Emmitting desde el heal")
	emitting = true

func _on_Timer_timeout():
	call_deferred("queue_free")
