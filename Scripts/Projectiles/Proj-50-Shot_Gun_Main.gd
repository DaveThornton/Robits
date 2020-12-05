extends Node2D

onready var proj1 = $Projectile1
onready var proj2 = $Projectile2
onready var proj3 = $Projectile3
onready var proj4 = $Projectile4
onready var proj5 = $Projectile5
onready var timer = $Timer

var owned = 1

func start(_rot, _pos, _scale, _owner, _dmg):
	timer.start()
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	owned = _owner
	if _scale.y < 0:
		rotation *= -1
	proj1.start( _owner, int(_dmg / 5))
	proj2.start( _owner, int(_dmg / 5))
	proj3.start( _owner, int(_dmg / 5))
	proj4.start( _owner, int(_dmg / 5))
	proj5.start( _owner, int(_dmg / 5))

func _on_Timer_timeout():
	call_deferred("free")
