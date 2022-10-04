extends ProgressBar

var targetValue = 100

func _process(delta):
	
	value = lerp(value, targetValue, 7 * delta)
	
	if abs(value - targetValue) < 1:
		value = targetValue
	
func change(newValue):
	targetValue = newValue
