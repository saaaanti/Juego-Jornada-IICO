extends Node2D

class_name TorretaProducto

# TODO: Lo podemos hacer un recurso como el del jugador
export (PackedScene) var torreta 
export var price = 150


func _ready():
	$Label.text = "$ " + str(price)
	update_color()

func update_color():
	
	if Singleton.inventario.plata >= price:
		$Label.add_color_override("font_color", Color.white)
		
	else:
		$Label.add_color_override("font_color", Color.red)
