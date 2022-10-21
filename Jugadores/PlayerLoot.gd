extends Area2D

func _on_LevantaLoot_area_entered(area):
	if area.get_parent() is Loot:
		Singleton.levantar_loot(area.get_parent())
		Singleton.puntos += 15
