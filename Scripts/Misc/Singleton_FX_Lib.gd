extends Node2D

onready var CAMERA = $"MP-01-Camera"
onready var backs = $"MP-01-Camera/Back"
onready var splash_screens = $Splash_Screens_Part
onready var explosions = $Explosions
onready var bricks = $Bricks


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
		if _num != 0:
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

func smoke(_num, _time):
	if _num == 0:
		pass

func proj(_num,_rot, _pos, _scale, _owner, _right, _speed, _col, _dmg, _hit, _ex):
	pass

func get_brick_color(_color):
	return bricks.get_color(_color)

func _on_Area2D_Respawn_area_entered(area):
	if area.get_groups().has("respawn"):
		Map_Hand.map.add_pos(area)

func _on_Area2D_Respawn_area_exited(area):
	if area.get_groups().has("respawn"):
		Map_Hand.map.remove_pos(area)

func _on_Area2D_Trigger_area_entered(area):
	if area.get_groups().has("trigger"):
		area.triggered()
