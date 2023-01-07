extends Node2D
onready var hits = $Hits
onready var swings = $Swings
onready var shells = $Shells
onready var explosions = $Explosions
onready var menus = $Menus
onready var music_part = $Music_Part
onready var coins = $Coins

var hit_num = 0
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

func hit():
	hits.get_child(hit_num).play()
	hit_num += 1
	if hit_num > hits.get_child_count()-1:
		hit_num = 0

func menu(_num):# 0:coin   1:start   2:select   3:Error  4: Back
	menus.get_child(_num).play()

func swing():
	swings.get_child(swing_num).play()
	swing_num += 1
	if swing_num > swings.get_child_count()-1:
		swing_num = 0

func shell():
	shells.get_child(shell_num).play()
	shell_num += 1
	if shell_num > shells.get_child_count()-1:
		shell_num = 0

func explosion(_num):#1: Pawn  2: Convetional  3: Energy
	explosions.get_child(_num).get_child(exp_num).play()

func coin():
	coins.get_child(coin_num).play()
	coin_num += 1
	if coin_num > coins.get_child_count()-1:
		coin_num = 0

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
	