extends Camera2D



export var min_size = .2
export var max_size = 1.1



var center = Vector2.ZERO

var players
var z = 0
var last_z = 0

func _ready():
	
	players = get_tree().get_nodes_in_group("Jugadores")
	
	# TODO: mas de 2
	
	
	for i in players:
		center += i.global_position
	
	var mx_x = 0
	var mn_x = INF
	
	var mx_y = 0
	var mn_y = INF
	
	for player in players:
		mx_x = max(player.global_position.x, mx_x)
		mn_x = min(player.global_position.x, mn_x)
		
		mx_y = max(player.global_position.y, mx_y)
		mn_y = min(player.global_position.y, mn_y)
		# TODO: que cambie con la diferencia en altura. Está desactivado porque cada salto lo hacía cambiar un montón
		# Capaz poniéndole un threshhold o un suavizado mas agrasivo
	
	var spread = ((mx_x - mn_x + mx_y - mn_y) / 2) -40 # 
	# Spread minimo: 40
	# Maximo: 200
	z = clamp((spread * (max_size - min_size) / 160) + min_size, min_size, max_size)
	
	z = lerp(last_z, z, 0.1) 
	last_z = z
	zoom = Vector2(z, z)
	
	
	
	global_position = center * 0.5
	
	#smoothing_enabled = true
	

func _process(_delta):
	
	
	
	players = get_tree().get_nodes_in_group("Jugadores")
	last_z = z
	
	center = Vector2.ZERO
	for i in players:
		center += i.global_position
	
	if len(players) < 1: return
	center = Vector2(center.x / len(players), center.y / len(players))
	



	
	var mx_x = 0
	var mn_x = INF
	
	var mx_y = 0
	var mn_y = INF
	
	for player in players:
		mx_x = max(player.global_position.x, mx_x)
		mn_x = min(player.global_position.x, mn_x)
		
		mx_y = max(player.global_position.y, mx_y)
		mn_y = min(player.global_position.y, mn_y)
		# TODO: que cambie con la diferencia en altura. Está desactivado porque cada salto lo hacía cambiar un montón
		# Capaz poniéndole un threshhold o un suavizado mas agrasivo
	
	var spread = ((mx_x - mn_x + mx_y - mn_y) / 2) -40 # 
	# Spread minimo: 40
	# Maximo: 200
	z = clamp((spread * (max_size - min_size) / 160) + min_size, min_size, max_size)
	
	z = lerp(last_z, z, 0.07) 
	
	zoom = Vector2(z, z)
	
	
	
	global_position = center
	
	
