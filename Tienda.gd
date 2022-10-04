extends Control

var active = false
var available = []
var selected = null


func _ready():
	visible = false

func show():
	visible = true
	active = true
func hide():
	visible =  false
	active = false

func left():
	pass
func right():
	pass
	
