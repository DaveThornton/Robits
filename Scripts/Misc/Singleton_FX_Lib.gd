extends Node2D

onready var CAMERA = $"MP-01-Camera"
onready var backs = $"MP-01-Camera/Back"
onready var splash_screens = $Splash_Screens_Part
onready var explosions = $Explosions
onready var projectiles = $Projectlies
onready var shells = $Shells
onready var bricks = $Bricks
onready var misc = $MiscFX


var spot_to_add = []
var spot_to_remove = []

func add_trauma(_amount):
	CAMERA.add_trauma(_amount)

func set_back(_num):
	back_blank()
	backs.get_child(_num).visible = true

func splash(_go, _num):
	if _go:
		splash_screens.go()

		splash_screens.screen(_num)
	else:
		splash_screens.stop()

func back_blank():
	for b in backs.get_child_count():
		backs.get_child(b).visible = false

func camera_move(_move):
	CAMERA.move(_move)

func add_kid(_kid):
	self.add_child(_kid)

func explode(_num, _owner, _pos, _weap_name, _pawn_num, _dmg):
	explosions.call_deferred("boom",_num, _owner, _pos, _weap_name, _pawn_num, _dmg)

func proj_hit(_num, _pos, _moving):
	explosions.call_deferred("proj_hit",_num, _pos, _moving)

func smoke(_pos):
	misc.poof(_pos)

func stuck_arrow():
	return misc.stuck_arrow()

func stuck_bolt():
	return misc.stuck_bolt()

func get_plasma_det():
	return misc.get_plasma_det()

func shell(_num, _pos, _rot):
	shells.spawn(_num, _pos, _rot)

func proj(_num,_rot, _pos, _scale, _owner, _dmg):
	projectiles.call_deferred("make_vs", _num,_rot, _pos, _scale, _owner, _dmg)

func proj_bad(_num,_rot, _pos, _scale, _owner, _dmg):
	projectiles.call_deferred("make_bad", _num,_rot, _pos, _scale, _owner, _dmg)

func four_brick(_owner, _pos, _color):
	bricks.add_four(_owner, _pos, _color)

func get_brick_color(_color):
	return bricks.get_color(_color)

func crt(_on):
	if _on:
		CAMERA.crt_on()
	else:
		CAMERA.crt_off()

func get_crt_status():
	return CAMERA.get_crt_status()

func screen_static(_on):
	if _on:
		CAMERA.static_on()
	else:
		CAMERA.static_off()

func get_static_status():
	return CAMERA.get_static_status()

func get_static_min():
	return CAMERA.min_c_static

func get_static_max():
	return CAMERA.max_c_static

func juice(_on):
	pass


func _on_Area2D_Respawn_area_entered(area):
	if area.get_groups().has("respawn"):
		Map_Hand.add_pos(area)

func _on_Area2D_Respawn_area_exited(area):
	if area.get_groups().has("respawn"):
		Map_Hand.remove_pos(area)

func _on_Area2D_Trigger_area_entered(area):
	if area.get_groups().has("trigger"):
		area.triggered()
