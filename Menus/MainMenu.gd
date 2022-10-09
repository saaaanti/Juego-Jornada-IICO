extends Node2D

var rb = preload("res://Menus/rb.tscn")

onready var camera = $Camera2D

var frames = ["res://Recursos/SkinAmarilloAnim.tres", "res://Recursos/SkinAzulAnim.tres", "res://Recursos/SkinVerdeAnim.tres"]
var noise = OpenSimplexNoise.new()
var cam_pos
# Configure

func _ready():
	cam_pos = camera.global_position
	randomize()
	VisualServer.set_default_clear_color(Color.lightblue)
	# TODO Error con el jitter de la camara, que tenga los fps seteados
	Engine.set_target_fps(Engine.get_iterations_per_second())
	var f = randi() % 6 + 1
	for _i in range(f):
		
		randomize()
		var a = rb.instance()
		add_child(a)
		
		a.get_node("AnimatedSprite").frames = load(frames[randi() % 3])
		a.get_node("AnimatedSprite").play("Run")
		a.position = Vector2(randi() % 140 + 167, randi() % 130 - 10)
		var an = randi() % 360
		var v = Vector2(cos(an), sin(an))
		a.add_central_force(v * 50)
		a.rotation = an
		
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8


var c = 0
var s = true

func _process(delta):
	if c == 100:
		s = false
	elif c == 0:
		s = true
		
	if s:
		c+= .1
	else:
		c -= .1
	
	camera.global_position = cam_pos + Vector2(noise.get_noise_2d(c/10,-c/10) * 50, noise.get_noise_2d(-c/10,c/10) * 50)
	
	var z  = noise.get_noise_2d(c/25,-c/25)
	
	
	camera.zoom = Vector2(z+1,z+1)


func _on_Button_button_down():
	# TODO: anim de transición
	get_tree().change_scene_to(load("res://ZONA PRINCIPAL.tscn"))


func _on_Button2_button_down():
	get_tree().quit()
