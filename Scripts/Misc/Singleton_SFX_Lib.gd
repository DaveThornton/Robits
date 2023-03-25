extends Node2D
onready var obj_collisions = $SFX_Obj_Collision
onready var melee = $SFX_Weapons/SFX_Melee
onready var shells = $SFX_Weapons/SFX_Shells
onready var explosions = $Explosions
onready var menus = $SFX_Menus
onready var music_part = $SFX_Music_Part
onready var projectiles = $SFX_Weapons/SFX_Projectile_Part
onready var pawn = $SFX_Pawn
onready var powerups = $SFX_Power_Ups
var oc_num = 0
var swing_num = 0 
var shell_num = 0
var exp_num = 0
var coin_num = 0

func play(sfx = null):
	if sfx:
		get_node(sfx).play()

func stop(sfx = null):
	if sfx:
		get_node(sfx).stop()

func obj_collision():
	obj_collisions.get_child(oc_num).play()
	oc_num += 1
	if oc_num > obj_collisions.get_child_count()-1:
		oc_num = 0

func menu(_num): menus.get_child(_num).play()# 0:coin   1:start   2:select   3:Error  4: Back
	
#-------------------------------------------Weapons------------------
func swing(): melee.get_child(1).play()

func melee_hit(): melee.get_child(0).play()

func projectile(_num): projectiles.play(_num)
	
func shell():
	shells.get_child(shell_num).play()
	shell_num += 1
	if shell_num > shells.get_child_count()-1:
		shell_num = 0

func explosion(_num): explosions.get_child(_num).get_child(exp_num).play() #1: Pawn  2: Convetional  3: Energy
	
#-------------------------------------------Power Ups----------------

func coin(): powerups.get_node("Coin").play()
	


#-------------------------------------------Pawn Stuff---------------
func throw(): pawn.get_node("Throw").play()

func drop(): pawn.get_node("Drop").play()

func pick_up(): pawn.get_node("Pick_Up").play()

func jump_ground(): pawn.get_node("Jump_Ground").play()

func jump_air(): pawn.get_node("Jump_Air").play()

func jump_down(): pawn.get_node("Jump_Down").play()
#-------------------------------------------End of Pawn Stuff-------

func music(_play, _num):
	if _play:
		music_part.play(_num)
	else:
		music_part.stop()

func set_master_vol(_db):
	AudioServer.set_bus_volume_db(0,_db)

func set_music_vol(_db):
	AudioServer.set_bus_volume_db(1,_db)

func set_sfx_vol(_db):
	AudioServer.set_bus_volume_db(2,_db)

func set_menu_vol(_db):
	AudioServer.set_bus_volume_db(3,_db)

func change_master_vol(_db):
	AudioServer.set_bus_volume_db(0,((AudioServer.get_bus_volume_db(0) + _db)))

func change_music_vol(_db):
	AudioServer.set_bus_volume_db(1,((AudioServer.get_bus_volume_db(1) + _db)))

func change_sfx_vol(_db):
	AudioServer.set_bus_volume_db(2,((AudioServer.get_bus_volume_db(2) + _db)))

func change_menu_vol(_db):
	AudioServer.set_bus_volume_db(3,((AudioServer.get_bus_volume_db(3) + _db)))

func get_master_vol():
	return AudioServer.get_bus_volume_db(0)
	
func get_music_vol():
	return AudioServer.get_bus_volume_db(1)
	
func get_sfx_vol():
	return AudioServer.get_bus_volume_db(2)
	
func get_menu_vol():
	return AudioServer.get_bus_volume_db(3)
	
