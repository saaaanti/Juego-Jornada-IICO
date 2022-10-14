extends Node

class_name Inventario

var plata = 150



onready var label = $CanvasLayer/Plata
onready var vida = $CanvasLayer/Vida

var target_vida = 100

func _process(delta):
	
	target_vida = Singleton.base.vida
	
	vida.value = lerp(vida.value, target_vida, 7 * delta)
	
	label.text = "Tienen $" + str(plata)
	
func change_plata(cuanto):
	plata += cuanto
