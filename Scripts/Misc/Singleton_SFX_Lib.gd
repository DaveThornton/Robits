extends Node2D
onready var obj_collisions = $SFX_Obj_Collision
onready var melee = $SFX_Weapons/SFX_Melee
onready var shells = $SFX_Weapons/SFX_Shells
onready var explosions = $SFX_Explosions
onready var menus = $SFX_Menus
onready var music_part = $SFX_Music_Part
onready var projectiles = $SFX_Weapons/SFX_Projectile_Part
onready var reloads = $SFX_Weapons/SFX_Reload_Part
onready var click_out = $SFX_Weapons/SFX_Click_Out_Part
onready var pawn = $SFX_Pawn
onready var powerups = $SFX_Power_Ups
onready var proj_hit = $SFX_Weapons/SFX_Proj_Hit
onready var voice_part =$SFX_Voice_Part

var oc_num = 0
var swing_num = 0 
var shell_num = 0
var exp_num = 0
var coin_num = 0

# func play(sfx = null):
# 	if sfx:
# 		if has_node(sfx):
# 			get_node(sfx).play()
# 		else:
# 			get_node("Menu_Error_09").play()
# 			print_debug("error in singleton sfx no sfx ", sfx, "so it played a stupid sound")

func stop(sfx = null):
	if sfx:
		if has_node(sfx):
			get_node(sfx).stop()
		else:
			print_debug("error in singleton sfx no sfx ", sfx)
func obj_collision():
	obj_collisions.get_child(oc_num).play()
	oc_num += 1
	if oc_num > obj_collisions.get_child_count()-1:
		oc_num = 0

func menu(_num): menus.get_child(_num).play()# 0:coin   1:start   2:select   3:Error  4: Back
	
#-------------------------------------------Weapons------------------
func swing(): melee.get_child(1).play()

func melee_hit(): melee.get_child(0).play()

func hit_map(): proj_hit.get_node("FX_Map_Hit").play()

func hit_player(): proj_hit.get_node("FX_Obj_Hit").play()

func projectile(_num): projectiles.play(_num)
	
func shell():
	shells.get_child(shell_num).play()
	shell_num += 1
	if shell_num > shells.get_child_count()-1:
		shell_num = 0

func explosion(_num): explosions.get_child(_num).get_child(exp_num).play() #1: Pawn  2: Convetional  3: Energy
	
func reload(_num):
	reloads.reload(_num)

func empty(_num):
	click_out.empty(_num)
#-------------------------------------------Power Ups----------------

func coin(): powerups.get_node("Coin").play()
	
func ammo(): powerups.get_node("Ammo_Box").play()

func shield(): powerups.get_node("Shield").play()

func speed(): powerups.get_node("Speed").play()
	
func jump(): powerups.get_node("Jump").play()

func nrg(): powerups.get_node("NRG").play()

func battery(): powerups.get_node("Battery").play()
	
func puck(): powerups.get_node("Puck").play()

func back_shield(): powerups.get_node("Back_Shield").play()

func add_balloon(): powerups.get_node("Balloon").play()

#-------------------------------------------Pawn Stuff---------------
func throw(): pawn.get_node("Throw").play()

func drop(): pawn.get_node("Drop").play()

func pick_up(): pawn.get_node("Pick_Up").play()

func jump_ground(): pawn.get_node("Jump_Ground").play()

func jump_air(): pawn.get_node("Jump_Air").play()

func jump_down(): pawn.get_node("Jump_Down").play()

func jump_land(): pawn.get_node("Jump_Land").play()
#-------------------------------------------Menu Stuff----------------

func menu_coin(): menus.get_node("M_00_Coin").play()

func menu_start(): menus.get_node("M_01_Start").play()

func menu_select(): menus.get_node("M_02_Select").play()

func menu_error(): menus.get_node("M_03_Error").play()

func menu_back(): menus.get_node("M_04_Back").play()

func menu_move(): menus.get_node("M_05_Move").play()

func menu_click(): menus.get_node("M_06_Click_Short").play()

func voice(voice_num): voice_part.play(voice_num)
#---------------------------------------------------------------------
func music(_play, _num):
	if _play:
		music_part.play(_num)
	else:
		music_part.stop()

func set_master_vol(_db): AudioServer.set_bus_volume_db(0,_db)

func set_music_vol(_db): AudioServer.set_bus_volume_db(1,_db)

func set_sfx_vol(_db): AudioServer.set_bus_volume_db(2,_db)

func set_menu_vol(_db): AudioServer.set_bus_volume_db(3,_db)

func change_master_vol(_db): AudioServer.set_bus_volume_db(0,((AudioServer.get_bus_volume_db(0) + _db)))

func change_music_vol(_db): AudioServer.set_bus_volume_db(1,((AudioServer.get_bus_volume_db(1) + _db)))

func change_sfx_vol(_db): AudioServer.set_bus_volume_db(2,((AudioServer.get_bus_volume_db(2) + _db)))

func change_menu_vol(_db): AudioServer.set_bus_volume_db(3,((AudioServer.get_bus_volume_db(3) + _db)))

func get_master_vol(): return AudioServer.get_bus_volume_db(0)
	
func get_music_vol(): return AudioServer.get_bus_volume_db(1)
	
func get_sfx_vol(): return AudioServer.get_bus_volume_db(2)
	
func get_menu_vol(): return AudioServer.get_bus_volume_db(3)