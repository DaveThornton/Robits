extends Node2D

onready var CAMERA = $"MP-01-Camera"

func add_trauma(_amount):
	CAMERA.add_trauma(_amount)

func camera_move(_move):
	CAMERA.can_move = _move

func _on_Area2D_Respawn_area_entered(area):
#	call_deferred("swap_parent",area)
	if area.get_groups().has("respawn"):
#		Map_Hand.map.add_spot(area)
#		Map_Hand.map.player_spawns_out.remove_child(area)
		area.get_parent().remove_child(area)
#		var a =area.get_parent()
#		a.remove_child(area)
		Map_Hand.map.player_spawns.add_child(area)
	print("FX enter: player spawns   ", Map_Hand.map.player_spawns.get_child_count(),"  <--in  out-->  ", Map_Hand.map.player_spawns_out.get_child_count())

func _on_Area2D_Respawn_area_exited(area):
#	call_deferred("swap_parent",area)
	if area.get_groups().has("respawn"):
#		Map_Hand.map.remove_spot(area)
#		self
#		Map_Hand.map.player_spawns.remove_child(area)
#		var a =area.get_parent()
#		a.remove_child(area)
		area.get_parent().remove_child(area)
		Map_Hand.map.player_spawns_out.add_child(area)
#	print("FX exit: player spawns   ", Map_Hand.map.player_spawns.get_child_count(),"  <--in  out-->  ", Map_Hand.map.player_spawns_out.get_child_count())

func swap_parent(area):
	print("swap parent")
	if area.get_parent() == Map_Hand.map.player_spawns:
		var a =area.get_parent()
		a.remove_child(area)
		Map_Hand.map.player_spawns_out.add_child(area)
		print("player spawns   ", Map_Hand.map.player_spawns.get_child_count(),"  <--in  out-->  ", Map_Hand.map.player_spawns_out.get_child_count())
	elif area.get_parent() == Map_Hand.map.player_spawns_out:
		var a =area.get_parent()
		a.remove_child(area)
		Map_Hand.map.player_spawns.add_child(area)
		print("player spawns   ", Map_Hand.map.player_spawns.get_child_count(),"  <--in  out-->  ", Map_Hand.map.player_spawns_out.get_child_count())
	else:
		print(area, " <----  this is not a respawn what is it doing here?")
	pass

func _on_Area2D_Trigger_area_entered(area):
	if area.get_groups().has("trigger"):
		area.triggered()
