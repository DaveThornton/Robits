extends Node2D
enum BOX_TYPE {Blank, R, O, B, I, T, S, Bang}
enum SPAWN_THING {Pick_Up, Gun, Nade}
enum MAP_GUN_LIST {map_gun_1, map_gun_2, map_gun_3, map_gun_4, map_gun_5, map_gun_6, map_gun_7, map_gun_8}
enum MAP_NADE_LIST {map_nade_1, map_nade_2, map_nade_3, map_nade_4}
enum MAP_PICK_LIST {map_pick_up_1, map_pick_up_2, map_pick_up_3, map_pick_up_4}
export var used = false
export(SPAWN_THING) var spawn = 1
export(MAP_GUN_LIST) var map_gun_num = 0
export(MAP_NADE_LIST) var map_nade_num = 0
export(MAP_PICK_LIST) var map_pick_up_num = 0
export(BOX_TYPE) var mark = 1
onready var sprite = $Sprite
onready var anim = $AnimationPlayer
onready var spawn_pos = $Pos2D_Spawn
onready var timer = $Timer
onready var hit_timer = $Timer_Hit

var thing_count = 1

func _ready():
	start_gfx()

func _on_Area2D_Hit_body_entered(body):
	if body.get_groups().has("player"):
		hit(1, "R Mark", "Mark", 1)

func hit(_owned, _my_name, _damage_type, _damage1):
	if !used:
		hit_timer.start()
		used = true
		if mark == 1:
			anim.play("Hit_R")
		elif mark == 2:
			anim.play("Hit_O")
		elif mark == 3:
			anim.play("Hit_B")
		elif mark == 4:
			anim.play("Hit_I")
		elif mark == 5:
			anim.play("Hit_T")
		elif mark == 6:
			anim.play("Hit_S")
		elif mark == 7:
			anim.play("Hit_Bang")
		else:
			anim.play("Hit_Blank")

func _on_Timer_Hit_timeout():
	call_deferred("_spawn_thing")
	timer.start()

func _on_Timer_timeout():
	used = false
	start_gfx()

func start_gfx():
	if !used:
		if mark == 1:
			anim.play("Start_R")
		elif mark == 2:
			anim.play("Start_O")
		elif mark == 3:
			anim.play("Start_B")
		elif mark == 4:
			anim.play("Start_I")
		elif mark == 5:
			anim.play("Start_T")
		elif mark == 6:
			anim.play("Start_S")
		elif mark == 7:
			anim.play("Start_Bang")
		else:
			anim.play("Start_Blank")
	else:
		if mark == 1:
			anim.play("Used_R")
		elif mark == 2:
			anim.play("Used_O")
		elif mark == 3:
			anim.play("Used_B")
		elif mark == 4:
			anim.play("Used_I")
		elif mark == 5:
			anim.play("Used_T")
		elif mark == 6:
			anim.play("Used_S")
		elif mark == 7:
			anim.play("Used_Bang")
		else:
			anim.play("Used_Blank")

func _spawn_thing():
	var t
	if spawn == 1: t = Map_Hand.map.get_gun(map_gun_num + 1).instance()
	elif spawn == 0: t = Map_Hand.map.get_pick_up(map_pick_up_num + 1, false).instance()
	else: t = Map_Hand.map.get_nade(map_nade_num + 1).instance()

	Map_Hand.add_kid_to_map(t)
	t.global_position = spawn_pos.global_position
	t.set_collision_layer_bit( 1, false)
	t.set_collision_mask_bit( 1, false)
	t.call_deferred("init", -1, 0, 1, true, 3, false )
