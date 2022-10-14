extends CanvasLayer

var stats = []

func add_stat(stat_name, cosa, string, esMetodo):
	stats.append([stat_name, cosa, string, esMetodo])



func _process(_delta):
	var label_text = ""
	
	var fps = Engine.get_frames_per_second()
	label_text += str("FPS: ", fps, "\n")
	
	var mem = OS.get_static_memory_usage()
	label_text += str("Memoria: ", String.humanize_size(mem), "\n")
	
	for i in stats:
		var v = null
		if is_instance_valid(i[1]):
			if i[3]:
				v = i[1].call(i[2])
			else:
				v = i[1].get(i[2])
			
		label_text += str(i[0], ": ", v)
		label_text += "\n"

	$Label.text = label_text
