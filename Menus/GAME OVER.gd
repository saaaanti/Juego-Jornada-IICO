extends CanvasLayer



func _on_Button_button_down(): # Reiniciar
	get_tree().change_scene("res://ZONA PRINCIPAL.tscn")
	call_deferred("queue_free")
func _on_Button2_button_down(): #MENU
	get_tree().change_scene("res://Menus/MainMenu.tscn")
	call_deferred("queue_free")
