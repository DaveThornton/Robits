extends Node2D

export(PackedScene) var ak47_Pickup
export(PackedScene) var shell
export(PackedScene) var bullet_hit

onready var anim_pos = $Anim_Player_Pos
onready var anim_fire = $Anim_Player_Shoot
onready var melee_timer = $Melee_Timer
onready var shoot_timer = $Shoot_Timer
onready var shoot_cast = $Pos2D_Walk/RayCast2D
onready var pos_no_hit = $Pos2D_Walk/Pos2D_No_Hit
onready var pos_shell = $Pos2D_Walk/Pos2D_Shell
onready var pos_walk = $Pos2D_Walk
onready var pos_throw = $Pos2D_Throw
onready var melee_cast = $Pos2D_Walk/RayCast2D_Melee
onready var melee_area_shape = $Pos2D_Walk/Area2D_Melee/CollisionShape2D

var player = 1
var gun_num = 2
var ammo = 30
var ammo_max = 90
var my_name = "Ak-47"
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var dmg_type = "Bullet"
var damage = 51
var can_shoot = true 
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var time = 4.0
var how_far = Vector2(600.0, 0.0)

signal ammo_change(player, ammo)
signal shot(player)

func _ready():
	self.connect("ammo_change", get_tree().get_current_scene(), "ammo_update")
	self.connect("shot", get_tree().get_current_scene(), "shot")
	shoot_cast.cast_to = how_far

func init(_ammo, _player, _timer):
	ammo = _ammo
	player = _player
	emit_signal("ammo_change",player,ammo)

func _process(delta):
	_set_anim()
	if pos_walk.rotation_degrees < 0:
		if pos_walk.rotation_degrees < 24:
			if pos_walk.rotation_degrees < 48:
				pos_walk.rotation_degrees += .6
			pos_walk.rotation_degrees += .1
		pos_walk.rotation_degrees += .01
		
	if new_anim != old_anim:
		anim_pos.play(new_anim)
		old_anim = new_anim

func shoot_j():
	if can_shoot:
		var melee_result = melee_cast.is_colliding()
		if melee_result:
			print_debug("melee attack")
			can_shoot = false
			anim_fire.play("Melee")
			melee_timer.start()
			emit_signal("shot", player)

func shoot():
	if can_shoot:
		var melee_result = melee_cast.is_colliding()
		if !melee_result:
			print_debug("no melee attck")
			if ammo > 0:
				var s = shell.instance()
				self.get_tree().get_current_scene().add_child(s)
				s.position = pos_shell.global_position
				s.rotation = pos_shell.global_rotation
	#			s.scale = pos_shell.scale 
				can_shoot = false
				shoot_timer.start()
				var result = shoot_cast.is_colliding()
				anim_fire.play("Fire")
				var x = bullet_hit.instance()
				if result:
					if shoot_cast.get_collider().get_groups().has("map"):
						self.get_tree().get_current_scene().add_child(x)
						x.position = shoot_cast.get_collision_point()
					elif shoot_cast.get_collider().get_groups().has("player"):
						shoot_cast.get_collider().hit(player, my_name, dmg_type, damage)
						self.get_tree().get_current_scene().add_child(x)
						x.position = shoot_cast.get_collision_point()
				else:
					self.get_tree().get_current_scene().add_child(x)
					x.global_position = pos_no_hit.global_position
				self.position = Vector2(0,0)
				ammo = clamp(ammo - 1, 0, ammo_max)
				emit_signal("ammo_change",player,ammo)
				emit_signal("shot", player)
				pos_walk.rotation_degrees -= 12


func shoot_r():
	print_debug("shoot rel")

func _on_Area2D_Melee_body_entered(body):
	if body.get_groups().has("player"):
#		body.stun(gun_num)
		body.hit(player, my_name, dmg_type, damage)

func throw():
	var t = ak47_Pickup.instance()
	self.get_tree().get_current_scene().add_child(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, 1, is_right, shoot_pos)
	_throw_where(t)
	emit_signal("ammo_change",player,0)
	queue_free()

func drop():
	var t = ak47_Pickup.instance()
	self.get_tree().get_current_scene().add_child(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, 1, is_right, shoot_pos)
	_drop_where(t)
	emit_signal("ammo_change",player,0)
	queue_free()

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
		if shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(600, -400))
		if shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(600, -200))
		if shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(600, 200))
		if shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(100, 700))
	else:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, -700))
		if shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, -400))
		if shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, -200))
		if shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, 200))
		if shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, 700))

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

func _on_Shoot_Timer_timeout():
	can_shoot = true

func _on_Melee_Timer_timeout():
	can_shoot = true