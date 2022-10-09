extends Node2D

class_name Nivel

onready var PlayerScene = "res://Jugadores/Jugador.tscn"

onready var spawnpoint1 = $Spawnpoint
onready var spawnpoint2 = $Spawnpoint2



# Called when the node enters the scene tree for the first time.
func _ready():
	VisualServer.set_default_clear_color(Color.lightblue)
	# TODO Error con el jitter de la camara, que tenga los fps seteados
	Engine.set_target_fps(Engine.get_iterations_per_second())
	
	
	Singleton.start()
	
	

func on_player_died(control1, skin):
	
	print("Murió y nos enteramos")
	
	var player = load(PlayerScene).instance()
	player.control1 = control1
	
	
	call_deferred("deferreado", player, skin, control1)
		

			
func deferreado(player, skin, control1): # TODO: queseyo
	add_child(player)
	player.animatedSprite.frames = skin
	if control1:
		player.global_position = spawnpoint1.global_position
	else: 
		player.global_position = spawnpoint2.global_position

