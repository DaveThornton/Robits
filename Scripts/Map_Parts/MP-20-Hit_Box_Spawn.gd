extends Node2D

export var gun1_nade2_power3 = 1
export var spawn_number = 1
export var mid_frame = 5
export var rotate_spawn = false
export var solid_block = true
export var outline_color = Color8(255,255,255,255)
export var middle_color = Color8(255,255,255,255)
export var back_color = Color8(255,255,255,255)
export var spent_color_01 = Color8(255,255,255,255)
export var spent_color_02 = Color8(255,255,255,255)

onready var outline = $Outline
onready var middle = $Middle
onready var back = $Back
onready var particles = $CPUParticles2D
onready var anim = $AnimationPlayer
onready var block = $StaticBody2D/CollisionShape2D
onready var timer_reset = $Timer
onready var spawn_pos = $Pos2D_Spawn

var used = false
var obj

func _ready():
	Map_Hand.map.connect("start",self ,"start")

func start():
	print("started MP 20")
	outline.self_modulate = outline_color
	middle.self_modulate = middle_color
	back.self_modulate = back_color
	middle.frame = mid_frame
	set_obj()
	if solid_block:
		block.disabled = false
	else:
		block.disabled = true

# func _process(_delta):

func spawn():
	if obj == null:
		set_obj()
	var s = obj.instance()
	Map_Hand.add_kid_to_map(s)
	s.global_position = spawn_pos.global_position
	s.dont_hit_player()
	if rotate_spawn:
		spawn_number += 1
		print("spawn number  ",spawn_number)
		if gun1_nade2_power3 == 1:
			if spawn_number > 8:
				spawn_number = 1
		else:
			if spawn_number > 4:
				spawn_number = 1
		set_obj()

func _on_Area2D_Hit_body_entered(body):
	if body.get_groups().has("player"):
		hit(1, "R Mark", "Mark", 1)

func hit(_owned, _my_name, _damage_type, _damage1):
	if !used:
		spent(true)

func spent(_spent:bool):
	if _spent:
		SFX.play("W_20_Beep_01")
		anim.play("Hit")
		timer_reset.start()
		used = true
		middle.visible = false
		back.self_modulate = spent_color_01
		outline.self_modulate = spent_color_02
	else:
		anim.play("Reset")
		used = false
		middle.visible = true
		back.self_modulate = back_color
		outline.self_modulate = outline_color

func _on_Timer_timeout():
	spent(false)

func set_obj():
	if gun1_nade2_power3 == 1:
		obj = Map_Hand.map.get_gun(spawn_number)
	elif gun1_nade2_power3 == 2:
		obj = Map_Hand.map.get_nade(spawn_number)
	elif gun1_nade2_power3 == 3:
		obj = Map_Hand.map.get_power_up(spawn_number)