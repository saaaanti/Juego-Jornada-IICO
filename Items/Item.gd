extends Node2D

class_name Item

func heal():
	print("Parent ", get_parent())
	if get_parent() is Jugador:
		print("if")
		print(get_parent().vida)
		get_parent().heal(100)
		print(get_parent().vida)
	
	

func healbase():
	print("Curando base")
	if is_instance_valid(Singleton.base):
		print(Singleton.base.vida)
		Singleton.base.vida += 10
		if Singleton.base.vida > 100:
			Singleton.base.vida = 100
		print(Singleton.base.vida)
		
	
	call_deferred("queue_free")
