extends KinematicBody2D 

onready var anim = $AnimationPlayer
onready var ray_d = $Cast_Down
onready var ray_u = $Cast_Up

onready var left_a = $Left_Area/CollisionShape2D
onready var right_a = $Right_Area/CollisionShape2D
onready var top_a = $Top_Area/CollisionShape2D
onready var bott_a = $Bottom_Area/CollisionShape2D

onready var top_stop_a = $Top_Stop_Area/CollisionShape2D

var player = 0
var my_name = "Turtle Shell"
var damage_type = "physical"
var damage = 1000
var gun_num = 27
var ammo = 1
var is_right = false
var just_shot = false
var move = 0 #0 = none #1 = Left #2 = Right #3 = Up #4 = Down
var time = 1

func _ready():
	anim.play("Spin")

func _process(_delta):
	if self.rotation_degrees > 0 || self.rotation_degrees < 0:
		self.rotation_degrees = 0
	if move == 0:#not moving maybe falling
		if !ray_d.is_colliding():
			var _1 = move_and_collide(Vector2(0,5))
			if anim.is_playing():
				anim.stop(false)
		side_hit(false)
		top_hit(false)
		bott_hit(false)
		top_stop_hit(false)
		return
	elif move == 1:#moving left
		if ray_d.is_colliding():
			print_debug("going dowm turtle pick")
			var _2 = move_and_collide(Vector2(-10,-1))
		else:
			var _3 = move_and_collide(Vector2(-10,2))
		side_hit(true)
		top_hit(false)
		bott_hit(false)
		top_stop_hit(true)
		return
	elif move == 2:#moving right
		if ray_d.is_colliding():
			var _4 = move_and_collide(Vector2(10,-1))
		else:
			var _5 = move_and_collide(Vector2(-10,2))
		side_hit(true)
		top_hit(false)
		bott_hit(false)
		top_stop_hit(true)
		return
	elif move == 3:#moving up
		if ray_u.is_colliding():
			move = 4
		else:
			var _6 = move_and_collide(Vector2(0,-10))
		side_hit(false)
		top_hit(true)
		bott_hit(true)
		top_stop_hit(false)
		return
	elif move == 4:#moving down
		if ray_d.is_colliding():
			move = 0
		else:
			var _7 = move_and_collide(Vector2(0,10))
			side_hit(false)
			top_hit(false)
			bott_hit(true)
			top_stop_hit(true)
		return

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	player = _player
	if _dir != 1 && _dir != 5:
		if _is_right:
			move = 1
		else:
			move = 2
	elif _dir == 1:
		move = 3
	elif _dir == 5:
		move = 4

func spin(_clock):
	if _clock:
		anim.play("Spin")
	else:
		anim.play_backwards("Spin")

func side_hit(_enable):
	if _enable:
		left_a.disabled = false
		right_a.disabled = false
	else:
		left_a.disabled = true
		right_a.disabled = true

func top_hit(_enable):
	if _enable:
		top_a.disabled = false
	else:
		top_a.disabled = true

func bott_hit(_enable):
	if _enable:
		bott_a.disabled = false
	else:
		bott_a.disabled = true

func top_stop_hit(_enable):
	if _enable:
		top_stop_a.disabled = false
	else:
		top_stop_a.disabled = true

func _on_Left_Area_body_entered(body):
	if body.get_groups().has("hittable") && move != 0:
		body.hit(player, my_name, damage_type, damage)
	move = 2

func _on_Right_Area_body_entered(body):
	if body.get_groups().has("hittable") && move != 0:
		body.hit(player, my_name, damage_type, damage)
	move = 1

func _on_Top_Area_body_entered(body):
	if body.get_groups().has("hittable") && move != 0:
		body.hit(player, my_name, damage_type, damage)
	move = 4

func _on_Bottom_Area_body_entered(body):
	if body.get_groups().has("hittable") && move != 0:
		body.hit(player, my_name, damage_type, damage)
	move = 0

func _on_Top_Stop_Area_body_entered(body):
	if body.get_groups().has("player"):
		move = 0

func _on_Left_Kick_Area_body_entered(body):
	if body.get_groups().has("player"):
		move = 2

func _on_Right_Kick_Area_body_entered(body):
	if body.get_groups().has("player"):
		move = 1
