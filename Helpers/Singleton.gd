extends Node

var inventario
var base

var players = []

var playing = false

var debug = preload("res://debug/DEBUG.tscn")
var debug_i

# TODO: un stock de verdad
var stock = [
	preload("res://Torretas/Pobre/PobreItem.tscn"),
	preload("res://Torretas/GONZA1/Prod_gonza.tscn"),
	preload("res://Items/HealProd.tscn"),
	preload("res://Items/HealProd.tscn"),
	preload("res://Items/HealProd.tscn")
	]

var p1 = false
var p2 = false

var p1_skin 
var p2_skin 

func levantar_loot(loot: Loot):
	Singleton.change_plata(Singleton.inventario.plata + loot.valor)
	loot.destroy()

func free_player(player):
	player.queue_free()

func _ready():
	call_deferred("start_debug")

func start_debug():
	debug_i = debug.instance()
	get_parent().add_child(debug_i)
	
func start():
	playing = true
	
	for i in get_tree().get_nodes_in_group("Jugadores"):
		if i.name == "Jugador 1":
			if p1:
				i.animatedSprite.frames = load(p1_skin)
			else:
				call_deferred("free_player", i)
		
		elif i.name == "Jugador 2":
			if p2:
				i.animatedSprite.frames = load(p2_skin)
				
				
			else:
				call_deferred("free_player", i)
		

	
	
	
	
	for i in get_parent().get_children():
		if i.name == "nivel":
			for j in i.get_children():
				if j is Inventario:
					inventario = j
				if j is Home:
					base = j
					
					
	get_tree().call_group("Tiendas", "change")
	
	get_tree().call_group("Productos", "update_color")

func _process(_delta):
	var hay_que_resetear = true
	if players != []:
		
		for player in players:
			if is_instance_valid(player):
				if player.state != player.DEAD:
					hay_que_resetear = false
					playing = true
		
		if $transition.time_left <= 0 and hay_que_resetear:
			
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

func change_plata(p):
	
	inventario.plata = p
	get_tree().call_group("Productos", "update_color")



func game_over():

	players = []
	add_child(load("res://Menus/GAME OVER.tscn").instance())
