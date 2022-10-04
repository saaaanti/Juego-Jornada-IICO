extends Node

var home = null

func _ready():
	for i in get_parent().get_children():
		if i is Nivel:
			home = i.get_node("Home")
			break
	
