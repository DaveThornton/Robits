extends Node2D

onready var map_list = $Campaign_Map_List
onready var bad_guys = $Campaign_Bad_Guys

#list of world titles
export var title_00 = "text 00"
export var title_01 = "text 01"
export var title_02 = "text 02"
export var title_03 = "text 03"
export var title_04 = "text 04"
export var title_05 = "text 05"
export var title_06 = "text 06"
export var title_07 = "text 07"
export var title_08 = "text 08"
export var title_09 = "text 09"
export var title_10 = "text 10"

#list of world discriptions
export var w00_dis = ""
export var w01_dis = ""
export var w02_dis = ""
export var w03_dis = ""
export var w04_dis = ""
export var w05_dis = ""
export var w06_dis = ""
export var w07_dis = ""
export var w08_dis = ""
export var w09_dis = ""
export var w10_dis = ""

#list of worlds completed
var w00_comp = false
var w01_comp = false
var w02_comp = false
var w03_comp = false
var w04_comp = false
var w05_comp = false
var w06_comp = false
var w07_comp = false
var w08_comp = false
var w09_comp = false
var w10_comp = false

var control_order = []
var current_world = 0
var current_level = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print_debug("error Singleton Controller connecting Player Controller to reset from world gd")

func load_next_level(map_w_info):#0: world for next map 1: next map number to load, 2: use spash ,  3: splash title , 4: splash body ,  5: lenght of splash in seconds
	set_current_world_level(map_w_info[0], map_w_info[1])
	var map_to_load = get_map(map_w_info[0], map_w_info[1])
	Map_Hand.load_map_cam(map_to_load, map_w_info[3], map_w_info[4], map_w_info[5], map_w_info[2])

func get_map(_world, _map): return map_list.get_map(_world, _map)
func get_bad_guy(_bg_num): return bad_guys.get_bg(_bg_num)

func get_map_title(_num):
	match _num:
		0: return title_00
		1: return title_01
		2: return title_02
		3: return title_03
		4: return title_04
		5: return title_05
		6: return title_06
		7: return title_07
		8: return title_08
		9: return title_09
		10: return title_10
		_: 
			print_debug("error in campiagn singleton in valid map title request in get map asked for ", _num, ". returning map 1 title instead")
			return title_01

func get_map_discription(_num):
	match _num:
		0: return w00_dis
		1: return w01_dis
		2: return w02_dis
		3: return w03_dis
		4: return w04_dis
		5: return w05_dis
		6: return w06_dis
		7: return w07_dis
		8: return w08_dis
		9: return w09_dis
		10: return w10_dis
		_: 
			print_debug("error in campiagn singleton in valid map request in get map discription asked for ", _num, ". returning map 1 discription instead")
			return w01_dis

func set_level_comp(_num, _bool):
	match _num:
		0: w00_comp = _bool
		1: w01_comp = _bool
		2: w02_comp = _bool
		3: w03_comp = _bool
		4: w04_comp = _bool
		5: w05_comp = _bool
		6: w06_comp = _bool
		7: w07_comp = _bool
		8: w08_comp = _bool
		9: w09_comp = _bool
		10: w10_comp = _bool
		_: print_debug("error in campiagn singleton in valid level num  in set level comp asking for ",_num,"   ",_bool)

func get_level_comp(_num):
	match _num:
		0: return w00_comp
		1: return w01_comp
		2: return w02_comp
		3: return w03_comp
		4: return w04_comp
		5: return w05_comp
		6: return w06_comp
		7: return w07_comp
		8: return w08_comp
		9: return w09_comp
		10: return w10_comp
		_: print_debug("error in campiagn singleton in valid level num  in get level comp asking for", _num)

func get_level_comp_count(): return (int(w00_comp) + int(w01_comp) + int(w02_comp) + int(w03_comp) + int(w04_comp) + int(w05_comp) + int(w06_comp) + int(w07_comp) + int(w08_comp) + int(w09_comp) + int(w10_comp))

func get_level_comp_array():
	var a = [w00_comp, w01_comp, w02_comp, w03_comp, w04_comp, w05_comp, w06_comp, w07_comp, w08_comp, w09_comp, w10_comp]
	return a

func get_levels_there():
	var worlds_there = []
	for l in map_list.get_world_count():
		worlds_there.append(map_list.get_world_has_level(l))
	print_debug("worlds there", worlds_there)
	return worlds_there

func set_current_world_level(world, level):
	current_world = world
	current_level = level

func get_current_world(): return current_world
func get_current_level(): return current_level

func reset():
	clear_players()
	for i in 11:
		set_level_comp(i,false)

func complete_current_world(): complete_world(current_world)
func complete_world(_num):
	match _num:
		0: w00_comp = true
		1: w01_comp = true
		2: w02_comp = true
		3: w03_comp = true
		4: w04_comp = true
		5: w05_comp = true
		6: w06_comp = true
		7: w07_comp = true
		8: w08_comp = true
		9: w09_comp = true
		10: w10_comp = true
		_: print_debug("invalid world number in campaign complete world  used number :",_num)

# this section has to do with who is in control of the map selection in campaign
func get_player_in_control():
	if control_order.size() > 0:
		return control_order[0]
	else:
		print_debug("error in singleton campaign get player in control no players in array so retruning 1")
		return 1

func set_player_in_control(_player):
	remove_player(_player)
	control_order.insert(0,_player)

func add_player(_player):
	if control_order.find(_player) == -1:
		control_order.append(_player)
	print_debug(control_order,"in singleton campaign")

func remove_player(_player):
	if control_order.find(_player) != -1:
		control_order.remove(_player)
	else:
		print_debug("error trying to remove player from control ", _player , " is not in the array")

func clear_players(): control_order.clear()
