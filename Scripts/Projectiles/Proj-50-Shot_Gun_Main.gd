extends Node2D

# onready var proj1 = $Projectile1
# onready var proj2 = $Projectile2
# onready var proj3 = $Projectile3
# onready var proj4 = $Projectile4
# onready var proj5 = $Projectile5
onready var pos1 = $Position2D
onready var pos2 = $Position2D2
onready var pos3 = $Position2D3
onready var pos4 = $Position2D4
onready var pos5 = $Position2D5
onready var timer = $Timer

var owned = 1

func start(_rot, _pos, _scale, _owner, _dmg):
	timer.start()
	rotation = _rot + rand_range(-.01, .01)
	self.global_position = _pos
	self.global_scale = _scale
	# owned = _owner
	# if _scale.y < 0:
	# 	rotation *= -1
	FX.proj(50.5,pos1.global_rotation , pos1.global_position, _scale, _owner, _dmg)
	FX.proj(50.5,pos2.global_rotation , pos1.global_position, _scale, _owner, _dmg)
	FX.proj(50.5,pos3.global_rotation , pos1.global_position, _scale, _owner, _dmg)
	FX.proj(50.5,pos4.global_rotation , pos1.global_position, _scale, _owner, _dmg)
	FX.proj(50.5,pos5.global_rotation , pos1.global_position, _scale, _owner, _dmg)

func _on_Timer_timeout():
	call_deferred("free")