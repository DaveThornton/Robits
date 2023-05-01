extends Node2D

enum NADE_NAME {Grenade, Nazi_Grenade,Plasma_Grenade,Bomberman,TNT,Time_Bomb, Prox_Mine = 19}
enum POWER_UP_NAME {Ammo, Shield, Speed, Jump, Nrg, Battery,Back_Shield = 9}

export var show_splash = false
export var title_text = "top_text"
export var body_text = "body_text testing levely stuff blah blah ... blah!!!"
export var splash_time = 1.5
export var camera_move = false
export var camera_max_right = 1920
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
export(POWER_UP_NAME) var power_up_01
export(POWER_UP_NAME) var power_up_02
export(POWER_UP_NAME) var power_up_03
export(POWER_UP_NAME) var power_up_04

onready var player_spawns = $Player_spawns
onready var parts = $Map_parts 

var first = true
var next_spawn_spot = 0
var spawn_spots = []

signal start

func _ready():
	if show_splash:
		HUD.splash(title_text, body_text, splash_time, true)

	FX.set_back(background)
	FX.CAMERA.max_right = camera_max_right
	FX.camera_move(camera_move)

	if music > 0:
		SFX.music(true, music)
	else:
		SFX.music(false, music)
	_start()

func _start(): emit_signal("start")		

func next_spawn_pos():
	if first:
		for i in player_spawns.get_child_count():
			spawn_spots.append(player_spawns.get_child(i))
		first = false
	spawn_spots.shuffle()
	return spawn_spots.pop_front().position

func get_gun(_num):
	if _num == 1: return Equipment.get_weap_pick(gun_01)
	elif _num == 2: return Equipment.get_weap_pick(gun_02)
	elif _num == 3: return Equipment.get_weap_pick(gun_03)
	elif _num == 4: return Equipment.get_weap_pick(gun_04)
	elif _num == 5: return Equipment.get_weap_pick(gun_05)
	elif _num == 6: return Equipment.get_weap_pick(gun_06)
	elif _num == 7: return Equipment.get_weap_pick(gun_07)
	elif _num == 8: return Equipment.get_weap_pick(gun_08)

func get_nade(_num):
	if _num == 1: return Equipment.get_weap_pick(nade_01 + 20)
	elif _num == 2: return Equipment.get_weap_pick(nade_02 + 20)
	elif _num == 3: return Equipment.get_weap_pick(nade_03 + 20)
	elif _num == 4: return Equipment.get_weap_pick(nade_04 + 20)

func get_power_up(_num):
	if _num == 1: return Equipment.get_item(power_up_01 + 1)
	elif _num == 2: return Equipment.get_item(power_up_02 + 1)
	elif _num == 3: return Equipment.get_item(power_up_03 + 1)
	elif _num == 4: return Equipment.get_item(power_up_04 + 1)

func remove_spawn_pos(_pos): if spawn_spots.has(_pos): spawn_spots.erase(_pos)

func add_spawn_pos(_pos): if !spawn_spots.has(_pos): spawn_spots.append(_pos)

func set_music(_music: int):
	if _music > 0:
		SFX.music(true, music)
	else:
		SFX.music(false, music)

func remove_map(): reset()

func reset(): propagate_call("queue_free",[],false)