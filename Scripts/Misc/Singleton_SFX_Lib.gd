extends Node2D
onready var hits = $Hits
onready var swings = $Swings
var hit_num = 0
var swing_num = 0 

func play(sfx = null):
	if sfx:
		get_node(sfx).play()

func stop(sfx = null):
	if sfx:
		get_node(sfx).stop()

func hit():
	hits.get_child(hit_num).play()
	hit_num += 1
	if hit_num > 15:
		hit_num = 0

func swing():
	swings.get_child(swing_num).play()
	swing_num += 1
	if swing_num > 15:
		swing_num = 0

func set_master_vol(_db):
	AudioServer.set_bus_volume_db(0,_db)

func set_music_vol(_db):
	AudioServer.set_bus_volume_db(1,_db)

func set_sfx_vol(_db):
	AudioServer.set_bus_volume_db(2,_db)

func set_menu_vol(_db):
	AudioServer.set_bus_volume_db(2,_db)
	