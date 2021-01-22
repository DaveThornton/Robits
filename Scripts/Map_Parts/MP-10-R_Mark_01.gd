extends Node2D

export var used = false
export(PackedScene) var spawn_01
#export var let = 1
export var spawn_nothing = false
export var mark = 1
export var my_color = Color8(255,255,0,255)
onready var sprite = $Sprite
onready var anim = $AnimationPlayer
onready var spawn_pos = $Pos2D_Spawn
#onready var hit_area = $Area2D_Hit
onready var timer = $Timer
onready var hit_timer = $Timer_Hit

func _ready():
	sprite.self_modulate = my_color
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
			anim.play("Hit_A")
		elif mark == 8:
			anim.play("Hit_Bang")
		elif mark == 46:
			anim.play("Hit_Brick")

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
			anim.play("Start_A")
		elif mark == 8:
			anim.play("Start_Bang")
		elif mark == 46:
			anim.play("Start_Brick")
	else:
		anim.play("Used")

func _spawn_thing():
	if !spawn_nothing:
		var t = spawn_01.instance()
		Map_Hand.add_kid_to_map(t)
		t.global_position = spawn_pos.global_position
		t.set_collision_layer_bit( 1, false)
		t.set_collision_mask_bit( 1, false)
		t.init( -1, 0, 1, true, 3, false )
