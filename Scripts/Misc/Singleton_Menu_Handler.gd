extends Node

var arcade_hud = "res://Scenes/Top_HUD.tscn"
var splash_screen = "res://Menus/Parts/M10-Splash.tscn"
var hud
var screen_loaded

#signal input_to_screen #movement up:1 left:2 right:3 down:4 start:5 back:6

#func _ready():
#	pass # Replace with function body.

#func load_hud(_hud_to_load):
#	if hud:
#		hud.queue_free()
#	var h = _hud_to_load.instance()
#	add_child(h)
#	hud = h
#
#func load_arcade_hud():
#	var h = load(arcade_hud).instance()
#	add_child(h)
#	get_tree().get_current_scene().hud = h
#	hud = h

#func load_screen(_screen_to_load):
#	var s = _screen_to_load.instance()
#	add_child(s)
#	screen_loaded = s
#
#func splash(_top, _body, _time, _pause):
#	var s = load(splash_screen).instance()
#	add_child(s)
#	s.init(_top, _body, _time, _pause)
#
#func input( _player, _dir):
#	print("player: ", _player," dir: ", _dir)
#	emit_signal("input_to_screen",_player, _dir)

#func update_hud():
#	if !get_tree().get_current_scene().is_game_over:
#		hud.update_player_hud_vis(p1_exists,p2_exists,p3_exists,p4_exists,p5_exists,p6_exists,p7_exists,p8_exists)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
