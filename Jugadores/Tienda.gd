extends Control

var active = false
var available = []
var instances = []
var index = 0


func _ready():
	visible = false

func show():
	visible = true
	active = true
	
func hide():
	visible =  false
	active = false

func change():
	available = Singleton.stock
	for i in get_children():
		instances = []
		i.queue_free()
		# TODO Call deferred
	for i in available:
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
	
func a():
	var sep = -20
	for i in instances.slice(0, index):
		i.position.x = sep
		sep -= 20
		
	
	
	
	

	
