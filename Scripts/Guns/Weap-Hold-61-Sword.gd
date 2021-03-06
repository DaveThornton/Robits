extends Node2D

export(PackedScene) var sword_pickup

onready var anim_pos = $Anim_Pos
onready var pos_throw = $Pos_Throw
onready var pos_arm = $Pos_Arm
onready var hit_area = $Pos_Arm/Pos_Swing/Area2D/CollisionPolygon2D

var player = 1
var gun_num = 61
var ammo = 1
# warning-ignore:unused_class_variable
var take_ammo = false
var my_name = "Sword"
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var dmg_type = "blade"
var damage = 100
var can_shoot = true 
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var time = 4.0
var max_rot = 120
var up_swing = 500
var down_swing = 800
var swinging: = false

signal ammo_change(player, ammo)
signal shot(player)

func _ready():
	my_name = my_name
	gun_num = gun_num
	time = time
	damage = damage
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 61 Sword")
	var test2 = self.connect("shot", Player_Stats, "add_shot")
	if test2 != 0:
		print("failed to connect shot in weap hold 61 Sword")

func init(_ammo, _player, _time, _just_shot):
	player = _player
	ammo = 1
	emit_signal("ammo_change",player,ammo)

func _process(delta):
	#sword swinging
	if swinging:
		pos_arm.rotation_degrees += (down_swing * delta)
	else:
		pos_arm.rotation_degrees -= (up_swing * delta)
	pos_arm.rotation_degrees = clamp(pos_arm.rotation_degrees,0,max_rot)
	#enabling and disabling attack area
	if pos_arm.rotation_degrees < max_rot && pos_arm.rotation_degrees > 0 && swinging:
		hit_area.disabled = false
	else:
		hit_area.disabled = true
	#setting animations for point what direction
	_set_anim()
	if new_anim != old_anim:
		anim_pos.play(new_anim)
		old_anim = new_anim

func shoot_j():
	swinging = true
	emit_signal("shot", player, 1)

func shoot():
	pass

func shoot_r():
	swinging = false

func melee():
	print("trying to hit with melee does it still work if so please remove this melee in sword holding else fix it then dummy")

func throw():
	var t = sword_pickup.instance()
	Map_Hand.add_kid_to_map(t)
#	self.get_tree().get_current_scene().add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, .5, is_right, shoot_pos, true)
	_throw_where(t)
	emit_signal("ammo_change",player,0)
	emit_signal("shot", player, 1)
	queue_free()

func drop():
	call_deferred("_drop")
func _drop():
	var t = sword_pickup.instance()
	Map_Hand.add_kid_to_map(t)
#	self.get_tree().get_current_scene().add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, 1, is_right, shoot_pos, false)
	_drop_where(t)
	emit_signal("ammo_change",player,0)
	queue_free()

func set_shoot_pos(_num, _is_right):
	if change_shoot_pos:
		shoot_pos = _num
		is_right = _is_right

func add_ammo(_ammo):
	pass

func _throw_where(_obj):
	if is_right:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(100, -800))
		if shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(600, -600))
		if shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(800, -200))
		if shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(600, 200))
		if shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(100, 700))
		_obj.spin(20000)
	else:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, -800))
		if shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, -600))
		if shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(-800, -200))
		if shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, 200))
		if shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, 700))
		_obj.spin(20000)

func _drop_where(_obj):
	_obj.set_collision_layer_bit( 1, false)
	_obj.set_collision_mask_bit( 1, false)

func _set_anim():
	if is_right:
		if shoot_pos == 1:
			new_anim = "Up-Right"
		if shoot_pos == 2:
			new_anim = "Right-Up"
		if shoot_pos == 3 ||shoot_pos == 6:
			new_anim = "Right"
		if shoot_pos == 4:
			new_anim = "Right-Down"
		if shoot_pos == 5:
			new_anim = "Down-Right"
	else:
		if shoot_pos == 1:
			new_anim = "Up-Left"
		if shoot_pos == 2:
			new_anim = "Left-Up"
		if shoot_pos == 3 ||shoot_pos == 6:
			new_anim = "Left"
		if shoot_pos == 4:
			new_anim = "Left-Down"
		if shoot_pos == 5:
			new_anim = "Down-Left"

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		if body.player != player:
			body.hit(player, my_name, dmg_type,damage)
		else:
			print("quit hitting yourself")
	elif body.get_groups().has("hittable"):
			body.hit(player, my_name, dmg_type,damage)
	
	
#	if body.get_groups().has("hittable"):
#		if body.player == player || pos_arm.rotation_degrees == max_rot - up_swing:#          error?
#			print("quit hitting yourself and or you are leaving you weapon down and not swinging it")
#		else:
#			body.hit(player, my_name, dmg_type,damage)
