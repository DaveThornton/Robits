extends Node2D

export(PackedScene) var rail_pickup
export(PackedScene) var projectile

onready var anim_fire = $AnimationPlayer
onready var melee_timer = $Melee_Timer
onready var shoot_timer = $Shoot_Timer
onready var shoot_cast = $POS_Gun/Raycast/Shoot
onready var melee_cast = $POS_Gun/Raycast/Melee
onready var throw_cast = $POS_Gun/Raycast/Throw
onready var pos_shoot = $POS_Gun/POS/Shoot
onready var pos_shell = $POS_Gun/POS/Shell
onready var pos_throw = $POS_Gun/POS/Throw
onready var beam = $POS_Gun/Gun_Sprite/Beam
onready var beam_end =$POS_Gun/Gun_Sprite/Beam_End
onready var partic = $POS_Gun/Gun_Sprite/CPUParticles2D

var player = 1
var pawn = 0
var gun_num = 19
var ammo = 30
var ammo_max = 90
var take_ammo = true
var my_name = "Rail Gun"
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var dmg_type = "Bullet"
var damage = 100
var can_shoot = true
var just_shot = false
var shoot_pos = 3
var walk = 0
var change_shoot_pos = true
var is_right = true
var time = 4.0
var max_beam = 2000
var shoot_pressed = false
var shoot_pressed_time = 0

signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 02 AK-47")

func init(_ammo, _player, _timer, _just_shot):
	ammo = _ammo
	player = _player
	just_shot = _just_shot
	emit_signal("ammo_change",player,ammo)

func _physics_process(delta):
	if shoot_cast.is_colliding():
		beam_end.global_position = shoot_cast.get_collision_point()
	else: 
		beam_end.global_position = shoot_cast.cast_to
	beam.region_rect.end.x = beam_end.position.length() * 4
	if shoot_pressed && can_shoot:
		shoot_pressed_time += delta
	if can_shoot && !beam.visible:
		beam.visible = true

func shoot_j():
	shoot_pressed = true
	anim_fire.play("ChargeUp")

func shoot():
	if shoot_pressed_time > 1 && shoot_pressed:
		if can_shoot:
			if melee_cast.is_colliding() && shoot_pos == 3:
				melee()
			elif ammo > 0:
				if !shoot_cast.is_colliding():
					print("shoot cast not colliding why gun 19")
				else: 
					var e = projectile.instance()
					Map_Hand.add_kid_to_map(e)
					e.init(player, shoot_cast.get_collision_point(), my_name, pawn, damage)
				anim_fire.play("Shoot")
				ammo = clamp(ammo - 1, 0, ammo_max)
				emit_signal("ammo_change",player,ammo)
				Player_Stats.add_shot(player, 1)
				just_shot = true
				SFX.play("Sniper_Shoot")
				shoot_timer.start()
				can_shoot = false
			else:
				SFX.play("Gun_Click")
			shoot_pressed = false

func shoot_r():
	anim_fire.play("Chargedown")
	shoot_pressed = false
	shoot_pressed_time = 0 

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
	var t = rail_pickup.instance()
	Map_Hand.add_kid_to_map(t)
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
	var t = rail_pickup.instance()
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

func _on_Shoot_Timer_timeout():
	can_shoot = true

func _on_Melee_Timer_timeout():
	can_shoot = true
