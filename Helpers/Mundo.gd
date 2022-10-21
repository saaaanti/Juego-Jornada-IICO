extends Node2D

class_name Nivel

func _ready():

	# Color de fondo
	VisualServer.set_default_clear_color(Color.paleturquoise)
	
	# Framerate de la pantalla
	Engine.set_target_fps(Engine.get_iterations_per_second())
	
	# Comienza la logica del Singleton
	Singleton.start()


func _on_Puntos_timeout():
	if Singleton.playing:
		Singleton.puntos += 5
