extends Timer




func _on_simpleSpawn_timeout():
	var i = load("res://Enemigos/enemy1/enemy1.tscn").instance()
	$"../Navigation2D".add_child(i)
