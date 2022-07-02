extends Node2D
export var gun_number = 1
export var solid_block = true
export var outline_color = Color8(255,255,255,255)
export var middle_color = Color8(255,255,255,255)
export var back_color = Color8(255,255,255,255)
export var top_01_color = Color8(255,255,255,255)
export var top_02_color = Color8(255,255,255,255)
export var scale_x = 1.5
export var scale_y = 1.0

onready var outline = $Sprite_01
onready var middle = $Sprite_03
onready var back = $Sprite_02
onready var top = $"MP-17-Weap_Spawner_top_01"
onready var particles = $CPUParticles2D
onready var anim = $AnimationPlayer
onready var anim2 = $AnimationPlayer2
onready var block = $StaticBody2D/CollisionShape2D
onready var timer_respawn = $Timer_Respawn
onready var spawn_area = $Area2D

var obj
var spawned_obj

func _ready():
	Map_Hand.map.connect("start",self ,"start")

func start():
	print_debug("started")
	outline.self_modulate = outline_color
	middle.self_modulate = middle_color
	back.self_modulate = back_color
	top.self_modulate = top_01_color
	particles.self_modulate = top_02_color
	anim.play("Idle")
	top.scale.y = scale_y
	top.scale.x = scale_x
	obj = Equipment.get_weap_pick(gun_number)
	# obj = Map_Hand.map.get_gun(gun_number)
	if solid_block:
		block.disabled = false
	else:
		block.disabled = true
	if spawn_area.get_overlapping_bodies().size() == 0:
		anim2.play("Spawn")

func spawn():
	if obj != Node2D:
		obj = Equipment.get_weap_pick(gun_number)
	spawned_obj = obj.instance()
	Map_Hand.add_kid_to_map(spawned_obj)
	spawned_obj.global_position = top.global_position
	spawned_obj.dont_hit_player()
	# if rotate_spawn:
	# 	gun_number += 1
	# 	if gun_number > 8:
	# 		gun_number = 1
	# 	obj = Equipment.get_weap_pick(gun_number)

func _on_Timer_Respawn_timeout():
	if spawn_area.get_overlapping_bodies().size() == 0:
		anim2.play("Spawn")
	else:
		timer_respawn.start()

func _on_Area2D_body_exited(_body):
	if !spawn_area.overlaps_body(spawned_obj):
		timer_respawn.start()
		anim2.play("Out")
