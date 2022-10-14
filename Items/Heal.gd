extends Node2D

class_name Item

# TODO: particulas
func _ready():
	call_deferred("heal")
	
func heal():
	print("Parent ", get_parent())
	if get_parent() is Jugador:
		print("if")
		print(get_parent().vida)
		get_parent().heal(100)
		print(get_parent().vida)
