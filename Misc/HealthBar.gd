extends ProgressBar

var hp = 100

func _process(delta):
	
	value = lerp(value, hp, 7 * delta)
	
	if abs(value - hp) < 1:
		value = hp
	

