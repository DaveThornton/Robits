extends Node2D

#export(PackedScene) var m01_VS
var mode
var over = false

func _ready():
	pass # Replace with function body.

func set_game_over(_over):
	over = _over

func set_mode(_mode):
	mode.call_deferred("free")
	#make a instance and all that shit then set it bu ttill then here you go the func is here
	mode = _mode

func check_over():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
