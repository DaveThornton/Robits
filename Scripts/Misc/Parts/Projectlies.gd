extends Node2D

export(PackedScene) var proj002
export(PackedScene) var proj003
export(PackedScene) var proj004
export(PackedScene) var proj005
export(PackedScene) var proj006
export(PackedScene) var proj007
export(PackedScene) var proj008
export(PackedScene) var proj009
export(PackedScene) var proj010
export(PackedScene) var proj011
export(PackedScene) var proj012
export(PackedScene) var proj013
export(PackedScene) var proj015
export(PackedScene) var proj016
export(PackedScene) var proj017
export(PackedScene) var proj018
export(PackedScene) var proj040
export(PackedScene) var proj041
export(PackedScene) var proj042
export(PackedScene) var proj050_1
export(PackedScene) var proj050_2
export(PackedScene) var proj051
export(PackedScene) var proj056
# export(PackedScene) var proj057
export(PackedScene) var proj058
export(PackedScene) var proj059
export(PackedScene) var proj084

export(PackedScene) var bg_proj004
export(PackedScene) var bg_proj010
export(PackedScene) var bg_proj103
export(PackedScene) var bg_proj104

export(PackedScene) var camp_proj000
export(PackedScene) var camp_proj002

var proj_004_color = 0

var no_hit_player = 35592
var no_hit_player_map = 35584

func make_vs(_num,_rot, _pos, _scale, _owner, _dmg):
	var new_projectile
	var layer = no_hit_player
	match _num:
		2:
			new_projectile = proj002.instance()
		3:
			new_projectile = proj003.instance()
		4:
			new_projectile = proj004.instance()
			if proj_004_color == 1:
				new_projectile.call_deferred("set_frame", 0)
			elif proj_004_color == 2:
				new_projectile.call_deferred("set_frame", 3)
			proj_004_color += 1
			if proj_004_color == 3:
				proj_004_color = 0
		5:
			new_projectile = proj005.instance()
		6:
			new_projectile = proj006.instance()
		7:
			new_projectile = proj007.instance()
			layer = no_hit_player
		8:
			new_projectile = proj008.instance()
		9:
			new_projectile = proj009.instance()
		10:
			new_projectile = proj010.instance()
		11:
			new_projectile = proj011.instance()
		12:
			new_projectile = proj012.instance()
		13:
			new_projectile = proj013.instance()
		15:
			new_projectile = proj015.instance()
		16:
			new_projectile = proj016.instance()
		17:
			new_projectile = proj017.instance()
		18:
			new_projectile = proj018.instance()
			layer = no_hit_player
		40:
			new_projectile = proj040.instance()
			layer = no_hit_player
		41:
			new_projectile = proj041.instance()
			layer = no_hit_player
		42:
			new_projectile = proj042.instance()
		50:
			new_projectile = proj050_1.instance()
		50.5:
			new_projectile = proj050_2.instance()
		51:
			new_projectile = proj051.instance()
		56:
			new_projectile = proj056.instance()
			layer = no_hit_player
		57:
			new_projectile = proj002.instance()#---------still using proj 002
		58:
			new_projectile = proj058.instance()
		59:
			new_projectile = proj059.instance()
			layer = 35592
		83:
			new_projectile = proj002.instance()#---------still using proj 002
		84:
			new_projectile = proj084.instance()
	Map_Hand.add_kid_to_map(new_projectile)
	new_projectile.start( _rot , _pos, _scale, _owner, _dmg)

	if Game.mode == 0:
		new_projectile.set_layer(layer)

func make_bad(_num,_rot, _pos, _scale, _owner, _dmg):
	var new_projectile
	match _num:
		4:
			new_projectile = bg_proj004.instance()
		10:
			new_projectile = bg_proj010.instance()
		103:
			new_projectile = bg_proj103.instance()
		104:
			new_projectile = bg_proj103.instance()

	Map_Hand.add_kid_to_map(new_projectile)
	new_projectile.start( _rot , _pos, _scale, _owner, _dmg)

func get_layer_mode_0_a():
	return no_hit_player_map

func get_layer_mode_0_b():
	return no_hit_player
