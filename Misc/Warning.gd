extends Node2D

var target

func _process(_delta):
	rotation = lerp_angle(rotation, target, 0.5)

func borrar():
	call_deferred("_queue_free")
