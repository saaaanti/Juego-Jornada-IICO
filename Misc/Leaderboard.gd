extends CanvasLayer

var labelScene = "res://Misc/Labelloco.tscn"

func _ready():
	var lScene = load(labelScene)
	
	var save = File.new()
	
	save.open("user://puntos.save", File.READ_WRITE)
	
	var file = save.get_as_text(false)
	
	var f = ""
	var flag = 0
	
	for i in file:
		
		
		f += i
		
		if i == "\n":
			flag += 1
		if flag == 2:
			print("SE termino y es ", f)
			f = ""
			flag = 0
	save.close()
	
