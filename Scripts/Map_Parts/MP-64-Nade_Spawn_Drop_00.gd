extends Node2D

enum GUN_CHOICE {Map_Nade1, Map_Nade2, Map_Nade3, Map_Nade4}

onready var timer = $Timer_Respawn

export(GUN_CHOICE) var nade_number = 0
export var custom_gun_num = 2
export var respawn_time = 30.0

var obj
var spawned_obj

func _ready():
	Map_Hand.map.connect("start",self ,"start")

func start():
	timer.wait_time = respawn_time
	obj = Map_Hand.map.get_nade(nade_number + 1)
	timer.start()

func spawn():
	if obj == null:
		obj = Map_Hand.map.get_nade(nade_number + 1)
	spawned_obj = obj.instance()
	Map_Hand.add_kid_to_pick_ups(spawned_obj)
	spawned_obj.global_position = self.global_position
	spawned_obj.dont_hit_player()
	spawned_obj.init(-1, 0, -1, true, 3, false)

func set_spawn(_nade_num):
	nade_number = _nade_num
	start()

func _on_Timer_Respawn_timeout():
	spawn()
