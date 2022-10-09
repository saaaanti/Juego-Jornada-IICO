extends Timer


onready var enemy_spawnpoints = $"../EnemySpawnpoints"


func _on_simpleSpawn_timeout():
	var i = load("res://Enemigos/enemy1/enemy1.tscn").instance()
	$"../Navigation2D".add_child(i)
	
	i.position = enemy_spawnpoints.get_children()[randi() % enemy_spawnpoints.get_children().size()].position
