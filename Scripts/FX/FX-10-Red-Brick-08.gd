extends Node2D

export(PackedScene) var brick
#export(PackedScene) var brick_boom
 
onready var spots = $spots

var hit_by

func _ready():
	pass
	
func init(_owner, pos): 
	hit_by = _owner
	self.global_position = pos
#	print(self.global_position,"8 brick ready pos")
	for w in range (spots.get_children().size()):
		var place = spots.get_child(w)
#		print(place.global_position)
		call_deferred("_spawn_brick", place.global_position)
#	var new_boom = brick_boom.instance()
#	get_tree().get_current_scene().add_child(new_boom)
#	new_boom.global_position = self.global_position
	call_deferred("free")

func _spawn_brick(_pos):
	var new_brick = brick.instance()
	get_tree().get_current_scene().add_child(new_brick)
	new_brick.global_position = _pos
