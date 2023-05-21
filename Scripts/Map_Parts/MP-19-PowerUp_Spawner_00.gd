extends Node2D

enum GUN_CHOICE {Map_PowerUp1, Map_PowerUp2, Map_PowerUp3, Map_PowerUp4}

onready var spawn_area = $Area2D
onready var top = $Area2D/CollisionShape2D
onready var anim = $AnimationPlayer
onready var timer = $Timer_Respawn

export(GUN_CHOICE) var power_up_number = 0
export var respawn_time = 30.0

var obj
var spawned_obj

func _ready():
	Map_Hand.map.connect("start",self ,"start")

func start():
	print_debug("started")
	timer.wait_time = respawn_time
	obj = Map_Hand.map.get_pick_up(power_up_number + 1, false)
	if spawn_area.get_overlapping_bodies().size() == 0:
		anim.play("Spawn")

func spawn():
	if obj == null:
		obj = Map_Hand.map.get_pick_up(power_up_number + 1, false)
	spawned_obj = obj.instance()
	Map_Hand.add_kid_to_map(spawned_obj)
	spawned_obj.global_position = top.global_position
	spawned_obj.dont_hit_player()
	spawned_obj.init(-1, 0, -1, true, 3, false)

func set_spawn(_power_up_num: int):
	power_up_number = _power_up_num
	start()

func _on_Area2D_body_entered(body:Node):
	pass
	# if body.get_groups().has("PickUp"):
	# 	body.set_outline_color(Color(255,0,0,255))

func _on_Area2D_body_exited(body:Node):
	if body.get_groups().has("PickUp"):
		# body.set_outline_color(FX.get_outline_color_pick())
		if body == spawned_obj:
			anim.play("Off")
			timer.start()

func _on_Timer_Respawn_timeout():
	if spawn_area.get_overlapping_bodies().size() == 0:
		anim.play("Spawn")