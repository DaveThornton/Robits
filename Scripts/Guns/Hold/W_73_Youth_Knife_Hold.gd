extends Node2D

export(PackedScene) var knife_pickup

onready var gun_pos = $POS_Gun
onready var pos_throw = $POS_Throw
onready var cast_throw = $RayCast2D
onready var axe = $POS_Gun/Axe
onready var hit_area = $Melee_Area/CollisionShape2D

var player = 1
var gun_num = 73
var ammo = 1
var take_ammo = false
var my_name = "Youth Knife"
var dmg_type = "blade"
var damage = 33
var can_shoot = true
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var swinging = false
var up_swing = 500
var down_swing = 750
var time_swing = 0.0
var time = 4.0
var walk = 40
var walk_back = 40

signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 73")

func init(_ammo, _player, _time, _just_shot):
	player = _player
	ammo = 1
	emit_signal("ammo_change",player,ammo)

func _process(delta):
	#axe swinging
	if swinging:
		walk = walk - down_swing * delta
		walk = clamp(walk,0,walk_back)
		gun_pos.rotation_degrees = gun_pos.rotation_degrees + down_swing * delta
		gun_pos.rotation_degrees = clamp(gun_pos.rotation_degrees,0,90)
	else:
		walk = walk + up_swing * delta
		walk = clamp(walk,0,walk_back)
		gun_pos.rotation_degrees = gun_pos.rotation_degrees - up_swing * delta
		gun_pos.rotation_degrees = clamp(gun_pos.rotation_degrees,0,90)
	if time_swing == 0.0:
		return
	elif time_swing < 0.0:
		hit_area.disabled = true
		time_swing = 0.0
	time_swing -= delta
#	print(time_swing)
		
	
func shoot_j():
	swinging = true
	Player_Stats.add_shot(player, 1)
	hit_area.disabled = false
	time_swing = 0.5

func shoot():
	pass

func shoot_r():
	swinging = false
	time_swing = 0.0
	hit_area.disabled = true

func melee():
	print("i dont know how this got called W_73_Axe Melee?")

func throw():
	var t = knife_pickup.instance()
	Map_Hand.add_kid_to_map(t)
#	self.get_tree().get_current_scene().add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, .5, is_right, shoot_pos, true)
	if cast_throw.is_colliding():
		t.position = cast_throw.get_collision_point()
		_drop_where(t)
	else:
		t.position = pos_throw.global_position
		_throw_where(t)
	_throw_where(t)
	emit_signal("ammo_change",player,0)
	emit_signal("shot", player, 1)
	queue_free()

func drop():
	call_deferred("_drop")
func _drop():
	var t = knife_pickup.instance()
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
		elif shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(600, -600))
		elif shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(800, -200))
		elif shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(600, 200))
		elif shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(100, 700))
		_obj.spin(20000)
	else:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, -800))
		elif shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, -600))
		elif shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(-800, -200))
		elif shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, 200))
		elif shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, 700))
		_obj.spin(-20000)

func _drop_where(_obj):
	_obj.set_collision_layer_bit( 1, false)
	_obj.set_collision_mask_bit( 1, false)

func _on_Melee_Area_body_entered(body):
	if body.get_groups().has("player"):
		if body.player != player:
			body.hit(player, my_name, dmg_type,damage)
		else:
			print("quit hitting yourself")
	elif body.get_groups().has("hittable"):
			body.hit(player, my_name, dmg_type,damage)
