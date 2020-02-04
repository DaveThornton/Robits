extends Node2D

func play(sfx = null):
	if sfx:
		get_node(sfx).play()

func set_master_vol(_db):
	AudioServer.set_bus_volume_db(0,_db)

func set_music_vol(_db):
	AudioServer.set_bus_volume_db(1,_db)

func set_sfx_vol(_db):
	AudioServer.set_bus_volume_db(2,_db)

func set_menu_vol(_db):
	AudioServer.set_bus_volume_db(2,_db)
