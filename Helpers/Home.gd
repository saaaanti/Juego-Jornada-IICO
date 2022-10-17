extends Node2D

class_name Home

var vida = 100
onready var tween = $Tween

export (Color) var start_color
export (Color) var end_color

var up = true

func _on_HitBox_body_entered(body):
	if body is Enemy:
		vida -= body.home_damage
		body.die(false)

func _process(_delta):
	if vida <= 0:
		$HitBox/CollisionShape2D.disabled = true
	
	
	$Gema.modulate = Color(range_lerp(vida, 100, 0, start_color.r, end_color.r),
	range_lerp(vida, 100, 10, start_color.g, end_color.g),
	range_lerp(vida, 100, 10, start_color.b, end_color.b),
	range_lerp(vida, 100, 10, start_color.a, end_color.a))

func _ready():
	change()

func change():
	
	

	if up:
		tween.interpolate_property($Gema, "position:y",
   -16, -24, 2.5 ,
	Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	else:
		tween.interpolate_property($Gema, "position:y",
   -24, -16, 2.5 ,
	Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	
	tween.start()
	up = not up


func _on_Tween_tween_completed(_object, _key):
	change()
