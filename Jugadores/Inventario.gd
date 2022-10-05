extends Node

class_name Inventario

var plata = 0

onready var label = $CanvasLayer/Plata

func _process(delta):
	var text = "Tienen $" + str(plata)
	label.text = text
	
func change_plata(cuanto):
	plata += cuanto
