extends Node2D

const PLAYER_SPAWN_CELL_NUM = 0

enum NADE_NAME {Grenade, Nazi_Grenade,Plasma_Grenade,Bomberman,TNT,Time_Bomb, Prox_Mine = 19}
enum POWER_UP_NAME {Ammo, Shield, Speed, Jump, Nrg, Battery, Coin = 7}

export var show_start_splash = false
export var start_splash_title = "top_text"
export var start_splash_body = "start_splash_body testing levely stuff blah blah ... blah!!!"
export var splash_time_sec = 1.5
export var camera_move = false
export var camera_max_right = 1920
export var start_weap_equiped = true
export var override_outline_color = false
export var outline_color_pick = Color8(255,255,255,255)
export var outline_color_hold = Color8(255,255,255,255)
export var background = 1
export var music = 0 # 0 is none
export var gun_01 = 2
export var gun_02 = 2
export var gun_03 = 2
export var gun_04 = 2
export var gun_05 = 2
export var gun_06 = 2
export var gun_07 = 2
export var gun_08 = 2
export(NADE_NAME) var nade_01
export(NADE_NAME) var nade_02
export(NADE_NAME) var nade_03
export(NADE_NAME) var nade_04
export(POWER_UP_NAME) var pick_up_01
export(POWER_UP_NAME) var pick_up_02
export(POWER_UP_NAME) var pick_up_03
export(POWER_UP_NAME) var pick_up_04

export var next_map_world_00 = 0
export var next_map_00 = 1
export var next_map_00_use_splash = false
export var next_map_00_splash_title = "top_text"
export var next_map_00_splash_body = "start_splash_body testing levely stuff blah blah ... blah!!!"
export var next_map_00_splash_time_sec = 1.5

export var next_map_world_01 = 0
export var next_map_01 = 1
export var next_map_01_use_splash = false
export var next_map_01_splash_title = "top_text"
export var next_map_01_splash_body = "start_splash_body testing levely stuff blah blah ... blah!!!"
export var next_map_01_splash_time_sec = 1.5

export var next_map_world_02 = 0
export var next_map_02 = 1
export var next_map_02_use_splash = false
export var next_map_02_splash_title = "top_text"
export var next_map_02_splash_body = "start_splash_body testing levely stuff blah blah ... blah!!!"
export var next_map_02_splash_time_sec = 1.5

onready var player_spawns = $Player_spawns
onready var parts = $Map_Parts 
onready var player_npc_spawn_map = $TM_10_Player_NPC_Spawn_00

var first = true
var next_spawn_spot = 0
var spawn_spots = []
var warp_point_1 = Vector2(960,540)
var warp_point_2 = Vector2(960,540)
var warp_point_3 = Vector2(960,540)
var warp_point_4 = Vector2(960,540)

signal start

func _ready():
	if show_start_splash:
		Map_Hand.splash_w_timer(start_splash_title, start_splash_body, splash_time_sec)
	FX.set_back(background)
	FX.CAMERA.max_right = camera_max_right
	FX.camera_move(camera_move)
	if start_weap_equiped:
		Settings.set_campaign_start_gun(true)
		for i in Settings.max_num_of_player: 
			Controllers.player_equip_start_weap(i + 1)
	if music > 0:
		SFX.music(true, music)
	else:
		SFX.music(false, music)
	if override_outline_color:
		FX.set_outline_color_pick(outline_color_pick)
		FX.set_outline_color_hold(outline_color_hold)
	_start()

func _start(): emit_signal("start")		

func next_spawn_pos():
	spawn_spots.shuffle()
	return spawn_spots.pop_front().position

func get_gun(_num: int):
	if _num == 1: return Equipment.get_weap_pick(gun_01)
	elif _num == 2: return Equipment.get_weap_pick(gun_02)
	elif _num == 3: return Equipment.get_weap_pick(gun_03)
	elif _num == 4: return Equipment.get_weap_pick(gun_04)
	elif _num == 5: return Equipment.get_weap_pick(gun_05)
	elif _num == 6: return Equipment.get_weap_pick(gun_06)
	elif _num == 7: return Equipment.get_weap_pick(gun_07)
	elif _num == 8: return Equipment.get_weap_pick(gun_08)

func get_gun_num(_num):
	if _num == 1: return gun_01
	elif _num == 2: return gun_02
	elif _num == 3: return gun_03
	elif _num == 4: return gun_04
	elif _num == 5: return gun_05
	elif _num == 6: return gun_06
	elif _num == 7: return gun_07
	elif _num == 8: return gun_08

func get_nade(_num: int):
	if _num == 1: return Equipment.get_weap_pick(nade_01 + 20)
	elif _num == 2: return Equipment.get_weap_pick(nade_02 + 20)
	elif _num == 3: return Equipment.get_weap_pick(nade_03 + 20)
	elif _num == 4: return Equipment.get_weap_pick(nade_04 + 20)

func get_pick_up(_num: int,_is_area: bool):
	print_debug(_num, _is_area)
	if _is_area:
		if _num == 1: return Equipment.get_area_item(pick_up_01 + 1)
		elif _num == 2: return Equipment.get_area_item(pick_up_02 + 1)
		elif _num == 3: return Equipment.get_area_item(pick_up_03 + 1)
		elif _num == 4: return Equipment.get_area_item(pick_up_04 + 1)
	else:
		if _num == 1: return Equipment.get_rigid_item(pick_up_01 + 1)
		elif _num == 2: return Equipment.get_rigid_item(pick_up_02 + 1)
		elif _num == 3: return Equipment.get_rigid_item(pick_up_03 + 1)
		elif _num == 4: return Equipment.get_rigid_item(pick_up_04 + 1)

func get_pick_up_num(_num: int):
	if _num ==1: return pick_up_01 +1
	elif _num == 2: return pick_up_02 + 1
	elif _num == 3: return pick_up_03 + 1
	elif _num == 4: return pick_up_04 + 1

func get_next_level_w_info(_num):
	var map_w_info = []
	if _num < 2: 
		map_w_info.append(next_map_world_00)
		map_w_info.append(next_map_00)
		map_w_info.append(next_map_00_use_splash)
		map_w_info.append(next_map_00_splash_title)
		map_w_info.append(next_map_00_splash_body)
		map_w_info.append(next_map_00_splash_time_sec)
	elif _num == 2: 
		map_w_info.append(next_map_world_01)
		map_w_info.append(next_map_01)
		map_w_info.append(next_map_01_use_splash)
		map_w_info.append(next_map_01_splash_title)
		map_w_info.append(next_map_01_splash_body)
		map_w_info.append(next_map_01_splash_time_sec)
	elif _num > 2: 
		map_w_info.append(next_map_world_02)
		map_w_info.append(next_map_02)
		map_w_info.append(next_map_02_use_splash)
		map_w_info.append(next_map_02_splash_title)
		map_w_info.append(next_map_02_splash_body)
		map_w_info.append(next_map_02_splash_time_sec)
	return map_w_info#0: 0: world for next map 1: next map number to load, 2: use spash ,  3: splash title , 4: splash body ,  5: lenght of splash in seconds


func remove_spawn_pos(_pos): if spawn_spots.has(_pos): spawn_spots.erase(_pos)

func add_spawn_pos(_pos): if !spawn_spots.has(_pos): spawn_spots.append(_pos)

func set_music(_music: int):
	if _music > 0: SFX.music(true, music)
	else: SFX.music(false, music)

func add_kid_to_parts(kid): parts.add_child(kid)

func add_player_spawn(spawn_spot): 
	player_spawns.add_child(spawn_spot)
	spawn_spots.append(spawn_spot)

func set_warp_point(_point_num: int, _point_pos: Vector2):
	match _point_num:
		1: warp_point_1 = _point_pos
		2: warp_point_2 = _point_pos
		3: warp_point_3 = _point_pos
		4: warp_point_4 = _point_pos

func get_warp_point(_point_num: int):
	match _point_num:
		1: return warp_point_1
		2: return warp_point_2
		3: return warp_point_3
		4: return warp_point_4

func remove_map(): reset()

func reset(): propagate_call("queue_free",[],false)
