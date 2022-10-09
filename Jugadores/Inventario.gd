extends Node

class_name Inventario

var plata = 0


onready var label = $CanvasLayer/Plata
onready var vida = $CanvasLayer/Vida

func _process(delta):
	
	vida.value = Singleton.base.vida
	label.text = "Tienen $" + str(plata)
	
func change_plata(cuanto):
	plata += cuanto
