extends Node2D

export(PackedScene) var bomb_man_pickup
export(PackedScene) var boom

onready var anim = $AnimationPlayer
onready var anim2 = $AnimationPlayer2
onready var anim3 = $AnimationPlayer3
onready var timer = $Timer
onready var pos_throw = $Pos2D_Throw
#onready var sprite_pin = $Sprite_pin

#var just_shot = false
var player = 1
var gun_num = 20
var ammo = 1
# warning-ignore:unused_class_variable
var take_ammo = false
var armed = false
var my_name = "Bomb-Man"
var new_anim = "Un_pos"
var old_anim = "Un_pos"
#var dmg_type = "Boom"
var damage = 100
var can_shoot = true 
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var time = 4.0

signal ammo_change(player, ammo)
#signal shot(player)

func _ready():
	my_name = my_name
	gun_num = gun_num
	damage = damage
	var test1 = self.connect("ammo_change", get_tree().get_current_scene(), "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 23 Bomb Man")
#	var test2 = self.connect("shot", get_tree().get_current_scene(), "shot")
#	if test2 != 0:
#		print("failed to connect shot in weap hold 23 Bomb Man")

func init(_ammo, _player, _time):
	player = _player
	ammo = _ammo
	if _ammo <= 0:
		ammo = 0
		_armed(_time)
		
	else:
		timer.wait_time = time
	emit_signal("ammo_change",player,ammo)

#warning-ignore:unused_argument
func _process(delta):
	_set_anim()
		
	if new_anim != old_anim:
		anim.play(new_anim)
		old_anim = new_anim

func shoot_j():
	pass

func shoot():
	pass

func _armed(_time):
	anim2.play("Armed")
	anim3.play("Armed")
	anim3.seek((time - _time))
	timer.wait_time = _time
	timer.start()

func shoot_r():
	if can_shoot:
		if ammo > 0:
			armed = true
			ammo = 0
			_armed(time)
			emit_signal("ammo_change",player, ammo)
			Player_Stats.add_shot(player, 1)
#			emit_signal("shot", player)

func melee():
	pass

func throw():
	var t = bomb_man_pickup.instance()
	self.get_tree().get_current_scene().add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, timer.time_left, is_right, shoot_pos, false)
	_throw_where(t)
	emit_signal("ammo_change",player,0)
	queue_free()

func drop():
	call_deferred("_drop")
func _drop():
	var t = bomb_man_pickup.instance()
	self.get_tree().get_current_scene().add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, timer.time_left, is_right, shoot_pos, false)
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
			_obj.apply_impulse(pos_throw.position, Vector2(50, -400))
		if shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(300, -300))
		if shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(400, -100))
		if shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(300, 100))
		if shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(50, 350))
	else:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(-50, -400))
		if shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(-300, -300))
		if shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(-400, -100))
		if shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(-300, 100))
		if shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(-50, 350))

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

func _on_Timer_timeout():
	get_parent().get_parent().my_gun = null
	get_parent().get_parent().is_holding = false
	var b = boom.instance()
	self.get_tree().get_current_scene().add_child(b)
#	b.position = self.global_position
	b.init(player, self.global_position, my_name)
	queue_free()
