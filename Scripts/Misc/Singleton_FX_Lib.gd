extends Node2D

onready var CAMERA = $"MP-01-Camera"

var spot_to_add = []
var spot_to_remove = []

func add_trauma(_amount):
	CAMERA.add_trauma(_amount)

func camera_move(_move):
	CAMERA.can_move = _move

#func _process(delta):
#	if spot_to_add.size() > 0:
#		for i in spot_to_add.size():
#			Map_Hand.map.player_spawns.add_child(spot_to_add[i])
#		spot_to_add.clear()
#		print("FX enter: player spawns   ", Map_Hand.map.player_spawns.get_child_count(),"  <--in  out-->  ", Map_Hand.map.player_spawns_out.get_child_count())
#	if spot_to_remove.size() > 0:
#		for l in spot_to_add.size():
#			Map_Hand.map.player_spawns_out.add_child(spot_to_remove[l])
#		spot_to_remove.clear()
#		print("FX enter: player spawns   ", Map_Hand.map.player_spawns.get_child_count(),"  <--in  out-->  ", Map_Hand.map.player_spawns_out.get_child_count())

func _on_Area2D_Respawn_area_entered(area):
	if area.get_groups().has("respawn"):
		Map_Hand.map.add_pos(area)
#	pass
#	if area.get_groups().has("respawn"):
#		Map_Hand.map.player_spawns_out.remove_child(area)
#		spot_to_add.append(area)

func _on_Area2D_Respawn_area_exited(area):
	if area.get_groups().has("respawn"):
		Map_Hand.map.remove_pos(area)
#	pass
#	if area.get_groups().has("respawn") && Map_Hand.map.player_spawns.get_child_count() > 1:
#		Map_Hand.map.player_spawns.remove_child(area)
#		spot_to_remove.append(area)

func _on_Area2D_Trigger_area_entered(area):
	if area.get_groups().has("trigger"):
		area.triggered()
