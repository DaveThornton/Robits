extends StaticBody2D

onready var anim_sprite_top = $Anim_Sprite_Outside
onready var sprite_back = $Sprite_Back
onready var respawn_timer = $Respawn_Timer
onready var hit_timer = $Hit_Timer
onready var hit_shape = $Area2D/CollisionShape2D
onready var shape_00 = $Shape_00
onready var shape_01 = $Shape_01
onready var shape_02 = $Shape_02
onready var shape_03 = $Shape_03
onready var shape_04 = $Shape_04
onready var shape_05 = $Shape_05

export var respawn = true
export var respawn_time = 30.0

var time_between = 0.4
var hit_count = 0
var hit_max = 6
var can_hit = true

var area_pos_00 = 20
var area_pos_01 = 14
var area_pos_02 = 10
var area_pos_03 = 6
var area_pos_04 = 0
var area_pos_05 = -6

func _ready():
	anim_sprite_top.play()
	check_frame()

func hit(owned, my_name, damage_type, damage):
	call_deferred("_hit",owned, my_name, damage_type, damage)

func _hit(_owned, _my_name, _damage_type, _damage):
	if hit_count < hit_max && can_hit:
		hit_count += 1
		can_hit = false
		hit_timer.start(time_between)
		Map_Hand.call_pow()
		check_frame()

func check_frame():
	sprite_back.frame = hit_count
	if hit_count == 0:
		anim_sprite_top.animation = "0"
		hit_shape.position.y = area_pos_00
		disable_collision_shapes()
		shape_00.disabled = false
	elif hit_count == 1:
		anim_sprite_top.animation = "1"
		hit_shape.position.y = area_pos_01
		disable_collision_shapes()
		shape_01.disabled = false
	elif hit_count == 2:
		anim_sprite_top.animation = "2"
		hit_shape.position.y = area_pos_02
		disable_collision_shapes()
		shape_02.disabled = false
	elif hit_count == 3:
		anim_sprite_top.animation = "3"
		hit_shape.position.y = area_pos_03
		disable_collision_shapes()
		shape_03.disabled = false
	elif hit_count == 4:
		anim_sprite_top.animation = "4"
		hit_shape.position.y = area_pos_04
		disable_collision_shapes()
		shape_04.disabled = false
	elif hit_count == 5:
		anim_sprite_top.animation = "5"
		hit_shape.position.y = area_pos_05
		disable_collision_shapes()
		shape_05.disabled = false
	elif hit_count == hit_max:
		if respawn:
			self.visible = false
			disable_collision_shapes()
			hit_shape.disabled = true
			respawn_timer.start(respawn_time)
		else:
			call_deferred("queue_free")
	else:
		print_debug("error in mp 43 pow hit count shouldnt be this ", hit_count)

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		hit(0, "head", "head",100)

func disable_collision_shapes():
	shape_00.disabled = true
	shape_01.disabled = true
	shape_02.disabled = true
	shape_03.disabled = true
	shape_04.disabled = true
	shape_05.disabled = true

func _on_Hit_Timer_timeout():
	can_hit = true


func _on_Respawn_Timer_timeout():
	hit_count = 0
	check_frame()
	hit_shape.disabled = false
	self.visible = true
