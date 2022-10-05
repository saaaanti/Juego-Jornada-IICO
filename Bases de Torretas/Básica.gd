extends Sprite

onready var detec = $Deteccion
onready var eje = $Eje

export var smooth = 0.1
var currentTarget = null

export(Resource) var datosTorreta

func _physics_process(_delta):
	var closestOne = INF
	var flag = false
	currentTarget = null
	for i in detec.get_overlapping_bodies():
		var dToNew = global_position.distance_to(i.global_position) 
		if  dToNew < closestOne:
			flag = true
			currentTarget = i
			closestOne = dToNew
	
	if currentTarget == null and not flag:
		currentTarget = null
		eje.rotation = lerp_angle(eje.rotation, 0, smooth)
		return
		# TODO: vuelve a la posición
	
	eje.rotate(eje.get_angle_to(currentTarget.global_position))
	#eje.rotation = lerp_angle(eje.rotation, eje.get_angle_to(currentTarget.global_position), smooth)	
	#print("Current target es, ", currentTarget)
