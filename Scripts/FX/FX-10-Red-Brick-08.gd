extends Node2D

export(PackedScene) var brick
#export(PackedScene) var brick_boom
 
onready var spots = $spots

var hit_by
var my_color
func _ready():
	pass
	
func init(_owner, pos, _my_color): 
	hit_by = _owner
	self.global_position = pos
	my_color = _my_color
	for w in range (spots.get_children().size()):
		var place = spots.get_child(w)
		call_deferred("_spawn_brick", place.global_position)
	call_deferred("free")

func _spawn_brick(_pos):
	var new_brick = brick.instance()
	new_brick.color(my_color)
	# new_brick.self_modulate = my_color
	Map_Hand.add_kid_to_map(new_brick)
	# get_tree().get_current_scene().add_child(new_brick)
	new_brick.global_position = _pos
