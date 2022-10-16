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
	
func _process(_delta):
	if not active: return
	
	# Movimiento mas suave
	
	
	#print("  ")
	for i in range(instances.size()):
		instances[i].position.x = lerp(instances[i].position.x, target_positions[i], 0.2)
		instances[i].scale = lerp(instances[i].scale, Vector2(target_scales[i], target_scales[i]), 0.2)
		#print("i: ", instances[i].scale)
	
		
var scale = .7
var gap = 25
func a():
	# TODO:
	

	
	


	for i in range( - int(available.size() / 2), int((available.size() / 2.0) + 0.5 )):
		var t = (index + i) % available.size()
		
		#print("El index es ", index, " y t es ", t, " e i es ", i)
		target_positions[t] = 25 * i
		
		if i == 0:
			target_scales[t] = 1
		elif abs(i) <= 2:
			target_scales[t] = 0.7 / abs(i)
		else:
			target_scales[t] = 0
			#abs(1 / i) if i != 0 else 1 # Teien otro resultado que esta bueno?
		
		instances[t].get_node("Titulo").visible = false
			
	instances[index].get_node("Titulo").visible = true
	
				
 
func buy():
	if instances[index].price <= Singleton.inventario.plata:
		Singleton.change_plata(Singleton.inventario.plata - instances[index].price)
		
		var t = instances[index].torreta.instance()
		if t is Torreta:
			get_parent().get_parent().add_child(t)
		if t is Item:
			get_parent().add_child(t)
		
		return t
