extends Node2D
export var my_pipe_number = 0
export var go_to_pipe_number = 0

onready var timer = $Timer
onready var pos_top = $"Position2D-Inside"
onready var pos_bottom = $"Position2D-Outside"

var partner
var occ_player_array_in = []
var occ_player_array_out = []
var speed = 500

var test_num = 0


func _ready():
	get_partner()

func _process(delta):
	if occ_player_array_out.size() > 0:
		print("next")
		for p in occ_player_array_out.size():
			if occ_player_array_out[p]:
				occ_player_array_out[p].global_position.x -= speed * delta
				occ_player_array_out[p].global_position.y = pos_top.global_position.x
				if occ_player_array_out[p].global_position.y < pos_top.global_position.y:
					occ_player_array_out[p].can_move = true
					occ_player_array_out.remove(p)
			else:
				occ_player_array_out.remove(p)
	if occ_player_array_in.size() > 0:
		for p in occ_player_array_in.size():
			if occ_player_array_in[p]:
				if occ_player_array_in[p].is_down:
					if (pos_top.global_position.y - occ_player_array_in[p].global_position.x) < 0:
						occ_player_array_in[p].global_position.y -= (speed / 4) * delta
					if (pos_top.global_position.y - occ_player_array_in[p].global_position.x) > 0:
						occ_player_array_in[p].global_position.y += (speed / 4) * delta
			else:
				occ_player_array_in.remove(p)
#	test_num += delta
#	if test_num > 1:
#		print("in ", occ_player_array_in, "           out", occ_player_array_out, "                     mp 42")
#		test_num = 0
#---------------------------------------------------------------trasnportation
func transport_here(_body):
	_body.global_position = pos_bottom.global_position
	if occ_player_array_out.find(_body) == -1:
		occ_player_array_out.append(_body)
	

func transport_there(_body):
	_body.can_move = false
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
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2DOutside_body_entered(body):
	if body.get_groups().has("player"):
		occ_player_array_in.append(body)

func _on_Area2DOutside_body_exited(body):
	if body.get_groups().has("player"):
		occ_player_array_in.erase(body)


func _on_Area2DInside_body_entered(body):
	if body.get_groups().has("player"):
		var l = occ_player_array_in.find(body)
		if l != -1:
			occ_player_array_in.remove(l)
			transport_there(body)

func _on_Area2DInside_body_exited(body):
	pass # Replace with function body.
