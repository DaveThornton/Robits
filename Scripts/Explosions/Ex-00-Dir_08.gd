extends Node2D

export var trauma = 0.0
export var ex_size = 100.0
export var damage = 75

onready var anim_sprite = $AnimatedSprite
onready var damage_area = $EX_Part_Damage_Area_08
onready var kick_area = $EX_Part_Kick_Area

var owned = 0
var my_name = "Explosion"
var weap_name = "Explosion"

var damage_type = "Explosion"
var gun_num = 0

func init(_owner, _pos, _weap_name: int, _pawn_num, _dmg):
	owned = _owner
	self.global_position = _pos
	gun_num = _weap_name
	damage = _dmg

	var test = damage_area.connect("obj_entered", self, "body_entered")
	if !test:
		print_debug("error in ex 03 pawn didnt connect to ex area")
	damage_area.set_size(ex_size)
	kick_area.set_size(ex_size)
	# damage_area.update_shape()

	ex_sfx()
	FX.add_trauma(trauma)
	anim_sprite.frame = 0
	anim_sprite.playing = true

func start( _sr , _ss, _sss, _player):
	owned = _player
	self.position = _ss

func ex_sfx():
	SFX.play("EX_Standard")

func body_entered(body, _per):
	if body.get_groups().has("hittable"):
		body.hit(owned, gun_num, damage_type, damage)

func _on_AnimatedSprite_animation_finished():
	call_deferred("free")
