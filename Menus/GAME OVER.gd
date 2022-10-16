extends CanvasLayer



func _on_Button_button_down(): # Reiniciar
	Singleton.change_scene("res://ZONA PRINCIPAL.tscn")
	call_deferred("queue_free")
func _on_Button2_button_down(): #MENU
	Singleton.change_scene("res://Menus/MainMenu.tscn")
	call_deferred("queue_free")
