extends Node2D

export(PackedScene) var pawn_part
export var ex_size = 100.0
export var trauma = 0.5
onready var damage_area = $EX_Part_Damage_Area
onready var kick_area = $EX_Part_Kick_Area
var owned = 0
var my_name = "Explosion"
var weap_name = "Explosion"
var damage1 = 1
var damage2 = 10
var damage_type = "Explosion"
var gun_num = 0

func init(_owner, _pos, _weap_name: int, _pawn_num, _dmg):
	print_debug("init called inside of pawn ex")
	self.global_position = _pos
	damage1 = (_dmg * .5)

	var part1 = pawn_part.instance()
	Map_Hand.add_kid_to_map(part1)
	part1.init(_owner, _pawn_num, 0, true, (_pos + Vector2(-2, -2)), Vector2(-200, -200))
	var part2 = pawn_part.instance()
	Map_Hand.add_kid_to_map(part2)
	part2.init(_owner, _pawn_num, 1, true, (_pos + Vector2(2, -2)), Vector2(200, -200))
	var part3 = pawn_part.instance()
	Map_Hand.add_kid_to_map(part3)
	part3.init(_owner, _pawn_num, 2, true, (_pos + Vector2(-2, 2)), Vector2(-200, -150))
	var part4 = pawn_part.instance()
	Map_Hand.add_kid_to_map(part4)
	part4.init(_owner, _pawn_num, 3, true, (_pos + Vector2(2, 2)), Vector2(100, -200))

	owned = _owner
	weap_name = _weap_name
	SFX.explosion(1)
	FX.add_trauma(trauma)
	gun_num = _weap_name
	# this adds the megaman like explosion
	FX.mega_ex(_pos)

	var test = damage_area.connect("obj_entered", self, "body_entered")
	if !test:
		print_debug("error in ex 03 pawn didnt connect to ex area")
	damage_area.set_size(ex_size)
	kick_area.set_size(ex_size)
	damage_area.update_shape()

func start( _sr , _ss, _sss, _player):
	owned = _player
	self.position = _ss

func body_entered(body, per):
	print("body entered")
	var dmg = clamp(damage2 * per,(damage2 * .2),damage2)
	# print_debug("body entered and take damage given is ",dmg)
	body.hit(owned, gun_num, damage_type, dmg)

func _on_Timer_timeout():
	call_deferred("free")

func _on_Timer2_timeout():
	damage_area.disable_shape(true)
	kick_area.disable_shape(true)
