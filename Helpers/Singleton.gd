extends Node

var inventario
var base

var players = []

var playing = false

# TODO: un stock de verdad
var stock = [preload("res://Torretas/Pobre/PobreItem.tscn"), preload("res://Torretas/Pobre/PobreItem.tscn"),
preload("res://Torretas/Pobre/PobreItem.tscn")]

func levantar_loot(loot: Loot):
	inventario.change_plata(loot.valor)
	loot.destroy()

func start():
	playing = true
	
	for i in get_parent().get_children():
		if i.name == "nivel":
			for j in i.get_children():
				if j is Inventario:
					inventario = j
				if j is Home:
					base = j
					print("Home es ", base)
					
	get_tree().call_group("Tiendas", "change")
	

func _process(delta):
	var hay_que_resetear = true
	if players != []:
		
		for player in players:
			if is_instance_valid(player):
				if player.state != player.DEAD:
					hay_que_resetear = false
					playing = true
		
		if $transition.time_left <= 0 and hay_que_resetear:
			print("Empieza el cosi")
			$transition.start(1)
	# ??? best practices seguro
	if is_instance_valid(base) and playing:
		if base.vida > 0:
			playing = true
		else:
			playing = false
			if $transition.time_left <= 0:
				$transition.start(1)
func _on_transition_timeout():
	game_over()
	playing = false

func game_over():

	players = []
	add_child(load("res://Menus/GAME OVER.tscn").instance())
