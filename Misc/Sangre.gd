extends CPUParticles2D

func _ready():
	emitting = true


func _on_Timer_timeout():
	call_deferred("queue_free")
