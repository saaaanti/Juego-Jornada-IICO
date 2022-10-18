extends Item

# TODO: particulas
func _ready():
	call_deferred("heal")
	


func _on_Timer_timeout():
	call_deferred("queue_free")
