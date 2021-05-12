extends Node2D
export var power_up_number = 1
export var solid_block = true
export var outline_color = Color8(255,255,255,255)
export var middle_color = Color8(255,255,255,255)
export var back_color = Color8(255,255,255,255)
export var top_01_color = Color8(255,255,255,255)
export var top_02_color = Color8(255,255,255,255)
export var scale_x = 1.0
export var scale_y = 1.0

onready var outline = $Sprite_01
onready var middle = $Sprite_03
onready var back = $Sprite_02
onready var top = $"MP-17-Weap_Spawner_top_01"
onready var particles = $CPUParticles2D
onready var anim = $AnimationPlayer
onready var block = $StaticBody2D/CollisionShape2D
# onready var timer_start = $Timer_Start
onready var timer_respawn = $Timer_Respawn
onready var spawn_area = $Area2D

var obj

func _ready():
	Map_Hand.map.connect("start",self ,"start")

func start():
	print("started")
	outline.self_modulate = outline_color
	middle.self_modulate = middle_color
	back.self_modulate = back_color
	top.self_modulate = top_01_color
	particles.self_modulate = top_02_color
	anim.play("Idle")
	top.scale.y = scale_y
	top.scale.x = scale_x
	obj = Map_Hand.map.get_power_up(power_up_number)
	if solid_block:
		block.disabled = false
	else:
		block.disabled = true
	if spawn_area.get_overlapping_bodies().size() == 0:
		spawn()

func _process(_delta):
	# print("in area ",spawn_area.get_overlapping_bodies().size())
	if spawn_area.get_overlapping_bodies().size() == 0 && timer_respawn.is_stopped():
		timer_respawn.start()

func spawn():
	if obj == null:
		obj = Map_Hand.map.get_power_up(power_up_number)
	var s = obj.instance()
	Map_Hand.add_kid_to_map(s)
	s.global_position = top.global_position
	s.dont_hit_player()


# func _on_Timer_timeout():
# 	if obj == null:
# 		obj = Map_Hand.map.get_gun(gun_number)
# 	spawn()

func _on_Timer_Respawn_timeout():
	if spawn_area.get_overlapping_bodies().size() == 0:
		spawn()
	else:
		timer_respawn.start()

func _on_Area2D_body_exited(_body):
	# print("exited with ",spawn_area.get_overlapping_bodies().size(), " left in the area" )
	if spawn_area.get_overlapping_bodies().size() == 0 && timer_respawn.is_stopped():
		timer_respawn.start()
