extends Node2D
export var my_pipe_number = 0
export var go_to_pipe_number = 0

onready var timer = $Timer
onready var timer_clear = $Timer_clear_space
onready var clear_area = $Area2D_Clear_Space/CollisionShape2D
onready var pos_top = $"Position2D-Top"
onready var pos_bottom = $"Position2D-Bottom"

var partner
var occ_player_array_in = []
var occ_player_array_in_remove = []
var occ_player_array_out = []
var occ_player_array_out_remove = []
var speed = 500
var clearing = false

var test_num = 0

func _ready():
	get_partner()

func _process(delta):
	if occ_player_array_out.size() > 0:
		call_deferred("move_players_up",delta)
	if occ_player_array_in.size() > 0:
		call_deferred("move_players_center",delta)
#	test_num += delta
#	if test_num > 1:
#		print_debug("in ", occ_player_array_in, "           out", occ_player_array_out, "                     mp 42")
#		test_num = 0
#---------------------------------------------------------------player movement
func move_players_up(_delta):
	if occ_player_array_out.size() > 0:
		for p in occ_player_array_out.size():
			var n = (occ_player_array_out.size() - p - 1)
			var s = occ_player_array_out[n]
			if s != null:
				if s.global_position.y > pos_bottom.global_position.y:
					s.global_position.y = pos_bottom.global_position.y - 5.0
				elif s.global_position.y > pos_top.global_position.y:
					s.global_position.y -= speed * _delta
					if s.global_position.y <= pos_top.global_position.y:
						s.can_move = true
						occ_player_array_out.remove(n)
			else:
				occ_player_array_out.remove(n)
				print_debug("didnt crash when he died")

func move_players_center(_delta):
	if occ_player_array_in.size() > 0 && !clearing:
		for p in occ_player_array_in.size():
			var s = occ_player_array_in[p]
			if s != null:
				if s.is_down:
					if (pos_top.global_position.x - s.global_position.x) < 0:
						occ_player_array_in[p].global_position.x -= (speed / 4) * _delta
					if (pos_top.global_position.x - s.global_position.x) > 0:
						s.global_position.x += (speed / 4) * _delta
		remove_players_in()

func remove_players_in():
		if occ_player_array_in_remove.size() > 0:
			for x in occ_player_array_in_remove.size():
				remove_in(occ_player_array_in.find(occ_player_array_in_remove[x]))
			occ_player_array_in_remove.clear()
#---------------------------------------------------------------trasnportation
func transport_here(_body):
	call_deferred("_transport_here",_body)
func _transport_here(_body):
	if _body != null:
		clearing = true
		clear_area.disabled = false
		timer_clear.start()
		_body.global_position = pos_bottom.global_position
		add_to_out(_body)
		for p in occ_player_array_in.size():
			if occ_player_array_in[p].global_position.x > pos_top.global_position.x:
				occ_player_array_in[p].knock_dir(-500, .2, 2, true)
			elif occ_player_array_in[p].global_position.x < pos_top.global_position.x:
				occ_player_array_in[p].knock_dir(-500, .2, 2, false)
			elif occ_player_array_in[p].global_position.x == pos_top.global_position.x:
				occ_player_array_in[p].knock_dir(-800, .3, 1, occ_player_array_in[p].is_right)

			
func transport_there(_body):
	call_deferred("_transport_there",_body)
func _transport_there(_body):
	if _body != null:
		_body.can_move = false
		_body.is_down = false
		if partner:
			partner.transport_here(_body)
		else:
			print_debug("cant find partner in mp 42")

#---------------------------------------------------------------get partner pipe
func get_partner():
	timer.start()

func _on_Timer_timeout():
	var m = Map_Hand.map.get_pipe(go_to_pipe_number)
	if m == null:
		print_debug(go_to_pipe_number," not a pipe number to go to. deleting self MP-42")
		call_deferred("queue_free")
	else:
		print_debug(my_pipe_number," ", m," ", go_to_pipe_number," ", m.my_pipe_number," MP-42")
		partner = m

#-----------------------------------------------------------------bodies entered
func _on_Area2DTop_body_entered(body):
	if body.get_groups().has("player"):
		add_to_in(body)

func _on_Area2DTop_body_exited(body):
	if body.get_groups().has("player"):
		remove_in(body)

func _on_Area2DBottom_body_entered(body):
	if body.get_groups().has("player"):
		if occ_player_array_in.find(body) != -1:
			remove_in(body)
			transport_there(body)

func _on_Area2DVery_Bottom_body_entered(body):
	if body.get_groups().has("player"):
		remove_in(body)
		transport_there(body)
#-----------------------------------------------------------------extra funcs

func _on_Timer_clear_space_timeout():
	clearing = false
	clear_area.disabled = true

#--------------------------------------------------------------------add/remove
func add_to_in(_body):
	if occ_player_array_in.find(_body) == -1:
		occ_player_array_in.append(_body)
	if!_body.is_connected("explode_p", self, "remove_in"):
		_body.connect("explode_p", self, "remove_in")

func remove_in(_body):
	if occ_player_array_in.find(_body) != -1:
		occ_player_array_in.erase(_body)
		_body.disconnect("explode_p", self, "remove_in")


func add_to_out(_body):
	if occ_player_array_out.find(_body) == -1:
		occ_player_array_out.append(_body)
	if !_body.is_connected("explode_p", self, "remove_out"):
		_body.connect("explode_p", self, "remove_out")

func remove_out(_body):
	var b = occ_player_array_out.find(_body)
	if b != -1:
		occ_player_array_out.remove(b)
		_body.disconnect("explode_p", self, "remove_out")
