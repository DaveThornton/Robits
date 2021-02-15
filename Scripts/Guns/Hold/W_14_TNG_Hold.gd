extends Node2D

const MAX_LENGTH = 750

export(PackedScene) var tng_pickup
export(PackedScene) var hit_anim
export(PackedScene) var hit_anim_nothing


onready var anim_fire = $AnimationPlayer

onready var melee_timer = $Melee_Timer
onready var shoot_timer = $Shoot_Timer
onready var shoot_cast = $POS_Gun/Gun_Sprite/Shoot_cast
onready var melee_cast = $POS_Gun/Raycast/Melee
onready var throw_cast = $POS_Gun/Raycast/Throw
onready var beam_end = $POS_Gun/Gun_Sprite/Laser_Sprite/Shoot
onready var pos_shell = $POS_Gun/POS/Shell
onready var pos_throw = $POS_Gun/POS/Throw
onready var beam = $POS_Gun/Gun_Sprite/Laser_Sprite

var player = 1
var gun_num = 14
var ammo = 250
var ammo_max = 550
#var shot_count = 0
var take_ammo = true
var my_name = "TNG"
var dmg_type = "Laser"
var damage = 9
var can_shoot = true
var just_shot = false
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 0.0
var walk_amount = 0.0
var time = 4.0
var shoot_pressed = false

signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 13 TOS")

func init(_ammo, _player, _timer, _just_shot):
	ammo = _ammo
	player = _player
	emit_signal("ammo_change",player,ammo)

func _physics_process(delta):
	if shoot_cast.is_colliding():
		beam_end.global_position = shoot_cast.get_collision_point()
	else:
		beam_end.position = shoot_cast.cast_to
	beam.region_rect.end.x = beam_end.position.length() * 5
	if shoot_pressed && can_shoot && ammo >= 1:
		beam.visible = true
		if shoot_cast.is_colliding() && time >.05:
			if shoot_cast.get_collider().get_groups().has("player"):
				Player_Stats.add_hit(player, 1)
				_hit(shoot_cast.get_collision_point())
				shoot_cast.get_collider().hit(player, my_name, dmg_type, damage)
			elif shoot_cast.get_collider().get_groups().has("hittable"):
				Player_Stats.add_hit(player, 1)
				_hit(shoot_cast.get_collision_point())
				shoot_cast.get_collider().hit(player, my_name, dmg_type, damage)
			else:
				_hit(shoot_cast.get_collision_point())
			anim_fire.play("Shoot")
			ammo = clamp(ammo - 1, 0, ammo_max)
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
			time = 0
		elif time >.1:
			_hit_nothing(beam_end.position)
			ammo = clamp(ammo - 1, 0, ammo_max)
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
			time = 0
		time += delta
	else:
		beam.visible = false

func shoot_j():
	if can_shoot:
		shoot_pressed = true
		anim_fire.play("Shoot")

func shoot():
	pass

func shoot_r():
	shoot_pressed = false
	anim_fire.play("UnShoot")

func melee():
	if can_shoot:
		can_shoot = false
		anim_fire.play("Melee")
		melee_timer.start()
		Player_Stats.add_shot(player, 1)

func _on_Melee_Area_body_entered(body):
	if body.get_groups().has("player"):
		if body.player != player:
			body.hit(player, my_name, dmg_type, damage)
		else:
			print("quit hitting your self")

func throw():
	var t = tng_pickup.instance()
	Map_Hand.add_kid_to_map(t)
	if shoot_pos == 6:
		pos_throw.position.x = 30
	t.position = pos_throw.global_position
	t.init(ammo, player, 1, is_right, shoot_pos, false)
	if throw_cast.is_colliding():
		t.position = self.global_position
		_drop_where(t)
	else:
		t.position = pos_throw.global_position
		_throw_where(t)
	emit_signal("ammo_change",player,0)
	call_deferred("free")

func drop():
	call_deferred("_drop")
func _drop():
	var t = tng_pickup.instance()
	Map_Hand.add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, 1, is_right, shoot_pos, false)
	_drop_where(t)
	emit_signal("ammo_change",player,0)
	call_deferred("free")

func set_shoot_pos(_num, _is_right):
	if change_shoot_pos:
		shoot_pos = _num
		is_right = _is_right

func add_ammo(_ammo):
	ammo = clamp(ammo + _ammo, 0, ammo_max)
	emit_signal("ammo_change",player,ammo)

func _throw_where(_obj):
	if is_right:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(100, -700))
		elif shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(600, -400))
		elif shoot_pos == 3 || shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(600, -200))
		elif shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(600, 200))
		elif shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(100, 700))
	else:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, -700))
		elif shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, -400))
		elif shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, -200))
		elif shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, 200))
		elif shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, 700))

func _drop_where(_obj):
	_obj.set_collision_layer_bit( 1, false)
	_obj.set_collision_mask_bit( 1, false)

func _hit(_pos):
	var x = hit_anim.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = _pos

func _hit_nothing(_pos):
	var x = hit_anim_nothing.instance()
	Map_Hand.add_kid_to_map(x)
	x.global_position = beam_end.global_position
	x.emitting = true

func _on_Melee_Timer_timeout():
	can_shoot = true
