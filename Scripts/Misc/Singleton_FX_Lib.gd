extends Node2D

# warning-ignore:unused_class_variable
onready var CAMERA = $"MP-01-Camera"

func _ready():
	pass # Replace with function body.
	
func add_trauma(_amount):
	CAMERA.add_trauma(_amount)