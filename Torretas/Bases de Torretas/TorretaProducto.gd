extends Node2D

class_name TorretaProducto

# TODO: Lo podemos hacer un recurso como el del jugador
export (PackedScene) var torreta # TODO: path a la escena de la torreta que le corresponde
export var price = 100
# export var shop_icon = Foto que le corresponde

func _ready():
	$Label.text = "$ " + str(price) # + randi() % 45
	update_color()

func update_color():
	
	if Singleton.inventario.plata >= price:
		$Label.add_color_override("font_color", Color.white)
		
	else:
		
		$Label.add_color_override("font_color", Color.red)
