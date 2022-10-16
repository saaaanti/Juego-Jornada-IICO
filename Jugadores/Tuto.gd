extends Node2D

func _ready():
	var tween = get_node("Tween")
	tween.interpolate_property($Control, "modulate:a",
			1, 0, 5, # 5 segundos
			Tween.TRANS_EXPO, Tween.EASE_IN)
	tween.start()
