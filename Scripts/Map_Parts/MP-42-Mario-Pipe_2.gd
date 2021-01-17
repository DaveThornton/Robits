extends Node2D
export var my_pipe_number = 0
export var go_to_pipe_number = 0

onready var timer = $Timer
onready var pos_top = $"Position2D-Top"
onready var pos_bottom = $"Position2D-Bottom"

var partner
var occ_player_array_in = []
var occ_player_array_in_remove = []
var occ_player_array_out = []
var occ_player_array_out_remove = []
var speed = 500

func _ready():
	get_partner()

func _process(delta):
	if occ_player_array_out.size() > 0:
		call_deferred("move_players_up",delta)
#		print("next")
#		for p in occ_player_array_out.size():
#			if occ_player_array_out[p].global_position.y > pos_bottom.global_position.y:
#				occ_player_array_out[p].global_position.y = pos_bottom.global_position.y
#			if occ_player_array_out[p]:
#				occ_player_array_out[p].global_position.y -= speed * delta
#				occ_player_array_out[p].global_position.x = pos_top.global_position.x
#				if occ_player_array_out[p].global_position.y < pos_top.global_position.y:
#					occ_player_array_out[p].can_move = true
#					occ_player_array_out.remove(p)
#			else:
#				occ_player_array_out.remove(p)
	if occ_player_array_in.size() > 0:
		call_deferred("move_players_center",delta)
#		for p in occ_player_array_in.size():
#			if occ_player_array_in[p]:
#				if occ_player_array_in[p].is_down:
#					if (pos_top.global_position.x - occ_player_array_in[p].global_position.x) < 0:
#						occ_player_array_in[p].global_position.x -= (speed / 4) * delta
#					if (pos_top.global_position.x - occ_player_array_in[p].global_position.x) > 0:
#						occ_player_array_in[p].global_position.x += (speed / 4) * delta
#			else:
#				occ_player_array_in.remove(p)
#---------------------------------------------------------------player movement
func move_players_up(_delta):
	if occ_player_array_out.size() > 0:
#		print("next")
		for p in occ_player_array_out.size():
			if occ_player_array_out[p].global_position.y > pos_bottom.global_position.y:
				occ_player_array_out[p].global_position.y = pos_bottom.global_position.y
			if occ_player_array_out[p]:
				occ_player_array_out[p].global_position.y -= speed * _delta
				occ_player_array_out[p].global_position.x = pos_top.global_position.x
				if occ_player_array_out[p].global_position.y < pos_top.global_position.y:
					occ_player_array_out[p].can_move = true
					occ_player_array_out_remove.append(occ_player_array_out[p])
			else:
				occ_player_array_out_remove.append(occ_player_array_out[p])
		remove_players_out()

func remove_players_out():
		if occ_player_array_out_remove.size() > 0:
			for x in occ_player_array_out_remove.size():
				var l = occ_player_array_out.find(occ_player_array_out_remove[x])
				occ_player_array_out.remove(l)
			occ_player_array_out_remove.clear()

func move_players_center(_delta):
	if occ_player_array_in.size() > 0:
		for p in occ_player_array_in.size():
			if occ_player_array_in[p]:
				if occ_player_array_in[p].is_down:
					if (pos_top.global_position.x - occ_player_array_in[p].global_position.x) < 0:
						occ_player_array_in[p].global_position.x -= (speed / 4) * _delta
					if (pos_top.global_position.x - occ_player_array_in[p].global_position.x) > 0:
						occ_player_array_in[p].global_position.x += (speed / 4) * _delta
			else:
				occ_player_array_in_remove.append(p)
		remove_players_in()

func remove_players_in():
		if occ_player_array_in_remove.size() > 0:
			for x in occ_player_array_in_remove.size():
				var l = occ_player_array_in.find(occ_player_array_in_remove[x])
				occ_player_array_in.remove(l)
			occ_player_array_in_remove.clear()
#---------------------------------------------------------------trasnportation
func transport_here(_body):
	call_deferred("_transport_here",_body)
func _transport_here(_body):
	_body.global_position = pos_bottom.global_position
	if occ_player_array_out.find(_body) == -1:
		occ_player_array_out.append(_body)
	

func transport_there(_body):
	call_deferred("_transport_there",_body)
func _transport_there(_body):
	_body.can_move = false
	_body.is_down = false
	if partner:
		partner.transport_here(_body)
	else:
		print("cant find partner in mp 42")

#---------------------------------------------------------------get partner pipe
func get_partner():
	timer.start()

func _on_Timer_timeout():
	var m = Map_Hand.map.get_pipe(go_to_pipe_number)
	if m == null:
		print(go_to_pipe_number," not a pipe number to go to. deleting self MP-42")
		call_deferred("queue_free")
	else:
		print(my_pipe_number," ", m," ", go_to_pipe_number," ", m.my_pipe_number," MP-42")
		partner = m

#-----------------------------------------------------------------bodies entered
func _on_Area2DTop_body_entered(body):
	if body.get_groups().has("player"):
		occ_player_array_in.append(body)

func _on_Area2DTop_body_exited(body):
	if body.get_groups().has("player"):
		occ_player_array_in.erase(body)


func _on_Area2DBottom_body_entered(body):
	if body.get_groups().has("player"):
		var l = occ_player_array_in.find(body)
		if l != -1:
			occ_player_array_in.remove(l)
			transport_there(body)
	#	else:
	#		occ_player_array_out.append(body)

func _on_Area2DBottom_body_exited(body):
	pass
#	var l = occ_player_array_out.find(body)
#	if l != -1:
#		occ_player_array_out.remove(l)
##		transport_there(body)


func _on_Area2DVery_Bottom_body_entered(body):
	if body.get_groups().has("player"):
		var l = occ_player_array_in.find(body)
		if l != -1:
			occ_player_array_in.remove(l)
		transport_there(body)
