
extends Node

class_name Inventario

var plata = 400

onready var label = $CanvasLayer/Plata
onready var vida = $CanvasLayer/Vida
onready var puntos_label = $CanvasLayer/Puntaje

var target_vida = 100



func _process(delta):
	
	target_vida = Singleton.base.vida
	
	vida.value = lerp(vida.value, target_vida, 7 * delta)
	
	label.text = "Tienen $" + str(plata)
	
	puntos_label.text = "Puntos: " + str(Singleton.puntos)
	
func change_plata(cuanto):
	plata += cuanto

