extends Timer


var total = 0


onready var enemy_spawnpoints = $"../EnemySpawnpoints"
var scenes

var a
func _ready():
	scenes = ["res://Enemigos/Patrones/Patrones/2 Juntos Basicos.tscn", "res://Enemigos/Patrones/Patrones/3 Tiempo Juntos.tscn", ]

func _on_simpleSpawn_timeout():
	
	if not Singleton.playing: return

	if total == 3:
		scenes.append("res://Enemigos/Patrones/Patrones/3 Juntos Abejas.tscn")
		scenes.append("res://Enemigos/Patrones/Patrones/5 Tiempo Abejas.tscn")
	
	if total == 10:
		scenes.append("res://Enemigos/Patrones/Patrones/1 a 3 bosses.tscn")
	
	if total <= 2:
		a = 3
	elif total >= 2 and total <= 10:
		a = 2.4
	elif total >= 10 and total <= 15:
		a = 2
	elif total >= 15 and total <= 30 :
		a = 1.7
	elif total >= 30  :
		a = .7
	
	start(a)
	
	#print("Spawneamos, en total: ", total, " y a es ", a)

	randomize()
	
	
	var i = load( scenes[randi() % scenes.size()]).instance()
	
	
	get_parent().add_child(i)
	
	

	
	i.change_pos(enemy_spawnpoints.get_children()[randi() % enemy_spawnpoints.get_children().size()].global_position)

	total += 1
