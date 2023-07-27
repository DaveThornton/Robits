extends Node2D

enum GUN_CHOICE {Map_gun1, Map_gun2, Map_gun3, Map_gun4, Map_gun5, Map_gun6, Map_gun7, Map_gun8, Custom_Gun_Num}

onready var timer = $Timer_Respawn

export(GUN_CHOICE) var gun_number = 0
export var custom_gun_num = 2
export var respawn_time = 15.0

var obj
var spawned_obj

func _ready():
	Map_Hand.map.connect("start",self ,"start")

func start():
	timer.wait_time = respawn_time
	obj = Map_Hand.map.get_gun(gun_number + 1)
	spawn()
	timer.start()

func spawn():
	if obj == null:
		obj = Map_Hand.map.get_gun(gun_number+ 1)
	spawned_obj = obj.instance()
	Map_Hand.add_kid_to_pick_ups(spawned_obj)
	spawned_obj.global_position = self.global_position
	spawned_obj.dont_hit_player()
	spawned_obj.init(-1, 0, -1, true, 3, false)

func set_spawn(gun_num):
	gun_number = gun_num
	start()

func _on_Timer_Respawn_timeout():
	spawn()
