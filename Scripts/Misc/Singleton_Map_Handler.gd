extends Node
var map
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn_pos():
#	print("MAP HANDLER DID IT I set the the spawn pos")
	map = get_tree().get_current_scene().map #elemate this
	return map.next_spawn_pos()

func load_map( _map_to_load):
	var m = _map_to_load.instance()
	map = m
	get_tree().get_current_scene().map = m
#warning-ignore:return_value_discarded
	self.connect("reset",m,"reset")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
