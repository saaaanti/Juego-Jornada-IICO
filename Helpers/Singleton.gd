extends Node

var inventario
var base

var players = []
	
func levantar_loot(loot: Loot):
	inventario.change_plata(loot.valor)
	loot.destroy()

func start():
	for i in get_parent().get_children():
		if i.name == "nivel":
			for j in i.get_children():
				if j is Inventario:
					inventario = j
				if j is Home:
					base = j
					print("Home es ", base)

func _process(delta):
	var hay_que_resetear = true
	if players != []:
		for player in players:
			if is_instance_valid(player):
				if player.state != player.DEAD:
					hay_que_resetear = false
		
		if $transition.time_left <= 0 and hay_que_resetear:
			print("Empieza el cosi")
			$transition.start(1)


func _on_transition_timeout():
	players = []
	get_tree().change_scene("res://MainMenu.tscn")
