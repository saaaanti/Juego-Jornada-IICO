extends Node2D

class_name Tiro


onready var tween = $Tween

var done = false
var damage

func _on_lifeTime_timeout():
	call_deferred("queue_free")

func _ready():
	

	
	tween.interpolate_property($Sprite, "position:x",
		$Sprite.position.x, 98, 1,
		Tween.TRANS_QUINT, Tween.EASE_OUT)
	tween.start()

func _process(delta):
	if not done:
		var enemy = $RayCast2D.get_collider()
		if enemy is Enemy:
			enemy.take_damage(damage)
			done = true
	
