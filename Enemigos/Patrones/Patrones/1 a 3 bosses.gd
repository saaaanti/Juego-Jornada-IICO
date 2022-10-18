
extends Node2D

export (PackedScene) var enemy
var cuantos
export (float) var tiempo

var hay = 0


func _ready():

	cuantos = (randi() % 3) + 1
	
	print("Ha y ", cuantos)
	
	$Timer.wait_time = tiempo

	
func change_pos(glob_pos):
	global_position = glob_pos
	

func _on_Timer_timeout():
	
	var i = enemy.instance()
	$"../Navigation2D".add_child(i)
	i.global_position = global_position
	#print("Tiempo, nosotros en ", global_position, " e i en ", i.global_position)
	hay += 1
	
	if hay >= cuantos:
		call_deferred("queue_free")
		
