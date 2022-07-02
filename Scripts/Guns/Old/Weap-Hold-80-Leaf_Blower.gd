extends Node2D

export(PackedScene) var blower_pickup

onready var anim_pos = $Anim_Pos
onready var pos_throw = $Pos_Throw
onready var pos_arm = $Pos_Arm
#onready var pos_swing = $Pos_Swing
#onready var hit_area = $Pos_Arm/Area2D/CollisionPolygon2D

var player = 1
var gun_num = 60
var ammo = 1
#var armed = false
var my_name = "Leaf Blower"
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var dmg_type = "Air"
var damage = 100
#var can_shoot = true 
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var time = 4.0
var max_rot = 120
var up_swing = 1000
#var down_swing = 35

signal ammo_change(player, ammo)
signal shot(player)

func _ready():
	my_name = my_name
	gun_num = gun_num
	time = time
	damage = damage
	var test1 = self.connect("ammo_change", get_tree().get_current_scene(), "ammo_update")
	if test1 != 0:
		print_debug("failed to connect ammo change in weap hold 60 Axe")
	var test2 = self.connect("shot", get_tree().get_current_scene(), "shot")
	if test2 != 0:
		print_debug("failed to connect shot in weap hold 60 Axe")

func init(_ammo, _player, _time):
	player = _player
	ammo = 1
	emit_signal("ammo_change",player,ammo)

# TODO : delta intergration is needed!!!!
func _process(delta):
	_set_anim()
	pos_arm.rotation_degrees -= up_swing * delta
	if pos_arm.rotation_degrees <= 0:
		pos_arm.rotation_degrees = clamp(pos_arm.rotation_degrees,0,max_rot)
	if new_anim != old_anim:
		anim_pos.play(new_anim)
		old_anim = new_anim

func shoot_j():
	pass

func shoot():
	pass
#	if can_shoot:
#		hit_area.disabled = false
#		pos_arm.rotation_degrees += down_swing
#		pos_arm.rotation_degrees = clamp(pos_arm.rotation_degrees,0, max_rot)
#		var arm_pos = pos_arm.rotation_degrees 
##		print_debug(arm_pos)
#		if arm_pos >= 60 :
#			if arm_pos <= 80:
##				print_debug(arm_pos)
#				emit_signal("shot", player)

func shoot_r():
	pass
#	hit_area.disabled = true
#	pass

func melee():
	shoot()

func throw():
	var t = blower_pickup.instance()
	Map_Hand.add_kid_to_map(t)
	t.position = pos_throw.global_position
#	t.rotation = pos_throw.global_rotation
#	t.scale.x = pos_throw.global_scale.x
	t.init(ammo, player, .5, is_right, shoot_pos, false)
	_throw_where(t)
	emit_signal("ammo_change",player,0)
	emit_signal("shot", player)
	queue_free()

func drop():
	call_deferred("_drop")
func _drop():
	var t = blower_pickup.instance()
	Map_Hand.add_kid_to_map(t)
	t.position = pos_throw.global_position
#	t.rotation = pos_throw.global_rotation
#	t.scale = pos_throw.global_scale
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
#		_obj.spin(20000)
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
#		_obj.spin(-20000)

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
		if body.player == player || pos_arm.rotation_degrees == max_rot - up_swing:
			print_debug("quit hitting yourself and or you are leaving you weapon down and not swinging it")
		else:
			body.hit(player, my_name, dmg_type,damage)
