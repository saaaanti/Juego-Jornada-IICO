extends Node2D

class_name Nivel

onready var PlayerScene = "res://Jugadores/Jugador.tscn"




# Called when the node enters the scene tree for the first time.
func _ready():

	
	VisualServer.set_default_clear_color(Color.paleturquoise)

	Engine.set_target_fps(Engine.get_iterations_per_second())
	
	Singleton.start()
	
	


