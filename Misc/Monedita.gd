extends RigidBody2D

class_name Loot

export var valor = 10
# TODO: podemos converirlo en recurso si queremos tener otros tipos de dropeables, tipo una manzanita y te tira vida
func destroy():
	call_deferred("queue_free")
