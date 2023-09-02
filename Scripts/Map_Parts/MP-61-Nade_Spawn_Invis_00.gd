extends Node2D

enum GUN_CHOICE {Map_Nade1, Map_Nade2, Map_Nade3, Map_Nade4}

onready var spawn_area = $Area2D
onready var top = $Area2D/CollisionShape2D
onready var anim = $AnimationPlayer
onready var timer = $Timer_Respawn

export(GUN_CHOICE) var nade_number = 0
export var custom_gun_num = 2
export var respawn_time = 30.0

var obj
var spawned_obj

func _ready():
	Map_Hand.map.connect("start",self ,"start")

func start():
	# dont know why but doing it this way keeps a error from happening
	set_timer(respawn_time)
	# Spawns the grenade at the begining
	obj = Map_Hand.map.get_nade(nade_number + 1)
	if spawn_area.get_overlapping_bodies().size() == 0:
		anim.play("Spawn")

func set_timer(_time):
	timer.wait_time = _time

func spawn():
	if obj == null:
		obj = Map_Hand.map.get_nade(nade_number + 1)
	spawned_obj = obj.instance()
	Map_Hand.add_kid_to_pick_ups(spawned_obj)
	spawned_obj.global_position = top.global_position
	spawned_obj.dont_hit_player()
	spawned_obj.init(-1, 0, -1, true, 3, false)

func set_spawn(_nade_num):
	nade_number = _nade_num
	start()

func _on_Area2D_body_entered(body:Node):
	if body.get_groups().has("PickUp"):
		body.set_outline_color(Color(255,0,0,255))

func _on_Area2D_body_exited(body:Node):
	if body.get_groups().has("PickUp"):
		body.set_outline_color(FX.get_outline_color_pick())
		if body == spawned_obj:
			anim.play("Off")
			timer.start()

func _on_Timer_Respawn_timeout():
	if spawn_area.get_overlapping_bodies().size() == 0:
		anim.play("Spawn")
