extends Node2D

export (PackedScene) var enemy
export (int) var cuantos 

var listo = false

func _ready():
	
	call_deferred("spawn")
	
	

func change_pos(glob_pos):
	global_position = glob_pos
	listo = true

func spawn():
	if listo:
		for a in range(cuantos):
			var i = enemy.instance()
			$"../Navigation2D".add_child(i)
			
			i.global_position = global_position + Vector2(a*2, a*2)
			#print("Nosotros en ", global_position ," e i en ", i.global_position)
		
	call_deferred("queue_free")
