extends Area2D

class_name Torreta

onready var detec = $Deteccion
onready var eje = $Eje

onready var health_bar = $Control/HealthBar

enum {
	CLOSEST_TO_BASE,
	LOWEST_LIFE,
	HIGHEST_LIFE,
	CLOSEST_TO_SELF,
}

export (int, "CLOSEST_TO_BASE", "LOWEST_LIFE", "HIGHEST_LIFE", "CLOSEST_TO_SELF") var target_mode
export var tiro = preload("res://Torretas/Tiros/BasicShot.tscn")
export var dmg = 1
export var drain = 6
export var travel_speed = 20


var currentTarget = null
var targeting = false

var can_shoot = true


var vida = 100
var cd
var inmune = false

# TODO: borrarlo del navmesh, mas que nada si ponemos barricadas

var placing = true
func _ready():
	cd = $shotCD.wait_time
	z_index = 100

func _physics_process(delta):
	
	
	$Control/CD_var.value = range_lerp($shotCD.time_left, cd, 0, 0, 100)
	
	if placing:
		pass
	else:
		check_target()
	
		mirar()
	
		check_shoot()
	
		if inmune:
			
			$Sprite.modulate.r = 40
		else:	
			$Sprite.modulate.r = 1
			do_drain(delta)
		
		health_bar.hp = vida
		if vida <= 0:
			die()

# TODO: que se muera de a poco



func do_drain(delta):
	vida -= drain * delta
	

func move_snap(pos):
	inmune = true
	position = (pos- Vector2(0, -10)).snapped(Vector2(9,9))
	
func place():
	z_index = 4
	inmune = false
	placing = false

func check_shoot():
	if not targeting:
		return
	else:
		# TODO: si el arma tiene que girar antes de dispararle se fija
		#if abs(eje.rotation - eje.get_angle_to(currentTarget.global_position)) < .4
		if can_shoot:
			can_shoot = false
		
			var t = tiro.instance()
			get_parent().add_child(t)
			t.global_position = eje.global_position
			t.rotation = eje.rotation
			t.damage = dmg
			t.travel_speed = travel_speed
			
			$shotCD.start()


	
func mirar():
	if targeting:
		
		eje.rotation = lerp_angle(eje.rotation, get_angle_to(currentTarget.global_position), 0.04)
		


func check_target():
	var posibles = []
	targeting = false
	
	var lo_ve = false
	
	
	
	for i in detec.get_overlapping_bodies():
		if is_instance_valid(i) and i is Enemy:
			
			$Raycasts.rotate($Raycasts.get_angle_to(i.global_position))
			
			
			
			for raycast in $Raycasts.get_children():
			
				if raycast.get_collider() == i:
				
					posibles.append(i)
					targeting = true
	
	match target_mode:
		CLOSEST_TO_BASE:
			
			for i in posibles:
				if not is_instance_valid(currentTarget):
					currentTarget = i
					continue
					

						
			
					
				if i.position.distance_to(Singleton.base.position) < currentTarget.position.distance_to(Singleton.base.position):
					currentTarget = i
					
		LOWEST_LIFE:
			print("No esta disponible")
		HIGHEST_LIFE:
			print("No esta disponible")
		CLOSEST_TO_SELF:
			print("No esta disponible")


func _on_shotCD_timeout():
	can_shoot = true


func _on_stasis_timeout():
	inmune = false

func die():
	call_deferred("queue_free")

func take_damage(damage):
	if inmune:
		return
	inmune = true
	$stasis.start()
	vida -= damage
	
	


func _on_TorretaBase_body_entered(body):
	print("Taking damage")
	if not body is Enemy:
		print("No es enemy??")
	take_damage(body.turret_damage)
	
