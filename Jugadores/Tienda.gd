extends Control

var active = false
var available = []
var instances = []
var target_positions = []
var target_scales = []

var index = 0


func _ready():
	hide()

func show():
	a()

	visible = true
	active = true
	
func hide():


	for i in instances:
		i.position.x = 0
		
	for i in instances:
		i.scale = Vector2(0.4, 0.4)
	
	visible =  false
	active = false

func change():
	available = Singleton.stock
	target_positions = []
	target_scales = []
	
	for i in get_children():
		instances = []
		i.queue_free()
		# TODO Call deferred
		
	for i in available:
		target_positions.append(0)
		target_scales.append(1)
		var instance = i.instance()
		add_child(instance)
		instances.append(instance)
	a()	

func left():
	index -= 1
	if index < 0:
		index = available.size() - 1 

	a()
func right():
	
	index += 1
	if index == available.size():
		index = 0
		

	a()
	
func _process(delta):
	if not active: return
	
	# Movimiento mas suave
	for i in range(instances.size()):
		instances[i].position.x = lerp(instances[i].position.x, target_positions[i], 0.2)
		instances[i].scale = lerp(instances[i].scale, Vector2(target_scales[i], target_scales[i]), 0.2)
		
	
		
var scale = .7
var gap = 25
func a():
	# TODO:
	

	
	# TODO: desastre atómico
	match instances.size():

		1: 
			target_positions[0] = 0
			target_scales[0] = 1 
		2:
			if index == 0:
				target_positions[index] = 0
				target_scales[index] = 1
				
				target_positions[1] = gap
				target_scales[1] = scale
			else:
				target_positions[index] = 0
				target_scales[index] = 1
				
				target_positions[0] = -1 * index * gap
				target_scales[0] = scale
			
		3:
			if index == 0:
				target_positions[instances.size()-1] = -25
				target_scales[instances.size()-1] =  .7

				target_positions[index] = 0
				target_scales[index] = 1
				
				target_positions[index+1] = 25
				target_scales[index+1] = .7
				
			elif index == instances.size() - 1:
				target_positions[index-1] = -25
				target_scales[index-1] =  .7

				target_positions[index] = 0
				target_scales[index] = 1

				target_positions[0] = 25
				target_scales[0] = .7
				
			else:
				target_positions[index-1] = -25
				target_scales[index-1] =  .7

				target_positions[index] = 0
				target_scales[index] = 1

				target_positions[index+1] = 25
				target_scales[index+1] = .7
 
func buy():
	if instances[index].price <= Singleton.inventario.plata:
		print("se puede comprar ")
		return true
