extends StaticBody2D

onready var anim_sprite_wow = $Anim_Sprite_WOW
onready var respawn_timer = $Respawn_Timer
onready var hit_timer = $Hit_Timer
onready var hit_shape = $Area2D/CollisionShape2D
onready var shape_00 = $Shape_00
onready var shape_01 = $Shape_01
onready var shape_02 = $Shape_02
onready var shape_03 = $Shape_03

export var respawn = true
export var respawn_time = 30.0

var time_between = 0.4
var hit_count = 0
var hit_max = 4
var can_hit = true

var area_pos_00 = 18
var area_pos_01 = 10
var area_pos_02 = 1
var area_pos_03 = -2

func _ready():
	anim_sprite_wow.play()
	check_frame()

func set_respawn(_respawn): respawn = _respawn

func hit(owned, my_name, damage_type, damage):
	call_deferred("_hit",owned, my_name, damage_type, damage)

func _hit(_owned, _my_name, _damage_type, _damage):
	if hit_count < hit_max && can_hit:
		hit_count += 1
		can_hit = false
		hit_timer.start(time_between)
		Map_Hand.call_pow()
		check_frame()
		Player_Stats.add_wow_count(_owned,1)

func check_frame():
	if hit_count == 0:
		anim_sprite_wow.animation = "0"
		hit_shape.position.y = area_pos_00
		disable_collision_shapes()
		shape_00.disabled = false
	elif hit_count == 1:
		anim_sprite_wow.animation = "1"
		hit_shape.position.y = area_pos_01
		disable_collision_shapes()
		shape_01.disabled = false
	elif hit_count == 2:
		anim_sprite_wow.animation = "2"
		hit_shape.position.y = area_pos_02
		disable_collision_shapes()
		shape_02.disabled = false
	elif hit_count == 3:
		anim_sprite_wow.animation = "3"
		hit_shape.position.y = area_pos_03
		disable_collision_shapes()
		shape_03.disabled = false
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
		hit(body.player, "head", "head",100)

func disable_collision_shapes():
	shape_00.disabled = true
	shape_01.disabled = true
	shape_02.disabled = true
	shape_03.disabled = true

func _on_Hit_Timer_timeout():
	can_hit = true

func _on_Respawn_Timer_timeout():
	hit_count = 0
	check_frame()
	hit_shape.disabled = false
	self.visible = true