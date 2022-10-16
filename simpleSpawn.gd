extends Timer


var total = 0


onready var enemy_spawnpoints = $"../EnemySpawnpoints"
var scenes


func _ready():
	scenes = ["res://Enemigos/Patrones/Patrones/2 Juntos Basicos.tscn", "res://Enemigos/Patrones/Patrones/3 Juntos Abejas.tscn", "res://Enemigos/Patrones/Patrones/3 Tiempo Juntos.tscn", "res://Enemigos/Patrones/Patrones/5 Tiempo Abejas.tscn"]

func _on_simpleSpawn_timeout():
	
	if not Singleton.playing: return
	
	var a = range_lerp( total, 0, 60, 3, 0.9)
	
	start(a  )
	
	#print("A es ", a)
	
	randomize()
	
	
	var i = load( scenes[randi() % scenes.size()]).instance()
	
	
	get_parent().add_child(i)
	
	

	
	i.change_pos(enemy_spawnpoints.get_children()[randi() % enemy_spawnpoints.get_children().size()].global_position)

	total += 1
