extends Node2D

var rb = preload("res://Menus/rb.tscn")

onready var camera = $Camera2D

var frames = ["res://Recursos/SkinAmarilloAnim.tres", "res://Recursos/SkinAzulAnim.tres", "res://Recursos/SkinVerdeAnim.tres"]

onready var character_select = $"Blur/Control2/Select Character"
var noise = OpenSimplexNoise.new()
var cam_pos

var selecting = false
var p1 = false
var p2 = false
var p1_ready = false
var p2_ready = false

var p1_skin
var p2_skin

onready var spriteP = $"Blur/Control2/Select Character/Panel/der/Todo P/Sprite P"
var p1_index
onready var spriteG = $"Blur/Control2/Select Character/Panel/izq/TodoG/Sprite G"
var p2_index

func _ready():
	cam_pos = camera.global_position
	randomize()
	VisualServer.set_default_clear_color(Color.lightblue)
	# TODO Error con el jitter de la camara, que tenga los fps seteados
	Engine.set_target_fps(Engine.get_iterations_per_second())
	
	for _i in range(randi() % 6 + 2):
		
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
	
	
	p2_index = randi() % 3
	p2_skin = frames[p2_index]
	spriteG.frames = load(p2_skin)
	
	
	p1_index = randi() % 3
	p1_skin = frames[p1_index]
	spriteP.frames = load(p1_skin)
	
	call_deferred("set_animations")
	

var c = 0
var s = true



func set_animations():
	# TODO me tira error pero anda?
	spriteP.play("Idle")
	spriteG.play("Idle")
	
	
var changing = false


func _process(_delta):
	# Animación
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
	## Animación ñ
	#
	
	
	# TODO: Está horrible askljf
	$"Blur/Control2/Select Character/Panel/der/Todo P".visible = p1
	$"Blur/Control2/Select Character/Panel/izq/TodoG".visible = p2

	$"Blur/Control2/Select Character/Panel/izq/Label G".visible = not p2
	$"Blur/Control2/Select Character/Panel/der/Label P".visible = not p1
	
	if selecting:
		if Input.is_action_just_pressed("p1_action") and not p1:
			p1_joined()
		if Input.is_action_just_pressed("p2_action") and not p2:
			p2_joined()
			
		if Input.is_action_just_pressed("p1_down") and p1:
			p1_quited()
		if Input.is_action_just_pressed("p2_down") and p2:
			p2_quited()
			
		if p1:
	
			
					
			if Input.is_action_just_pressed("p1_left"):
				p1_index -= 1
				if p1_index == -1:
					p1_index = 2
				p1_skin = frames[p1_index]
				spriteP.frames =  load(p1_skin)
				
			if Input.is_action_just_pressed("p1_right"):
				p1_index += 1
				if p1_index == 3:
					p1_index = 0
				p1_skin = frames[p1_index]
				spriteP.frames =  load(p1_skin)
				
			
		if p2:
		
				
			
					
			if Input.is_action_just_pressed("p2_left"):
				p2_index -= 1
				if p2_index == -1:
					p2_index = 2
				p2_skin = frames[p2_index]
				spriteG.frames = load(p2_skin)
				
			if Input.is_action_just_pressed("p2_right"):
				p2_index += 1
				if p2_index == 3:
					p2_index = 0
				p2_skin = frames[p2_index]
				spriteG.frames = load(p2_skin)
				
		
		# TODO: seguro hay una forma mas mejor
		
			
		

func p1_joined():
	$"Blur/Control2/Select Character/Panel/der/Unirse P".text = "Listo"
	
	
	
	p1 = true
	
	
func p1_quited():
	$"Blur/Control2/Select Character/Panel/der/Unirse P".text = "Unirse: "
	
	
	p1 = false
	
	

func p2_joined():
	$"Blur/Control2/Select Character/Panel/izq/Unirse G".text = "Listo"
	
	
	
	p2 = true
	
func p2_quited():
	$"Blur/Control2/Select Character/Panel/izq/Unirse G".text = "Unirse: "
	
	
	p2 = false
	


func _on_Button_button_down():
	# TODO: anim de transición
	if not selecting:
		var tween = $Tween
		
		tween.interpolate_property($Blur/Control2/Jugar, "rect_position:y",
			81, 140, 0.7,
			tween.TRANS_BACK, tween.EASE_IN_OUT)
		
		var tween_c = $Tween
		tween_c.interpolate_property(character_select, "rect_position:x",
		-210, 30, 0.85,
		tween_c.TRANS_BACK, tween_c.EASE_IN_OUT)
		

		selecting = true
		tween.start()
	
	if selecting and (p1 or p2) and not changing:
			
			
			
			changing = true
			Singleton.p1 = p1
			Singleton.p1_skin = p1_skin
			Singleton.p2 = p2
			Singleton.p2_skin = p2_skin
		
		
			var _r = Singleton.change_scene("res://ZONA PRINCIPAL.tscn")
		
func _on_Button2_button_down():
	
	get_tree().quit()
