extends MarginContainer

export(PackedScene) var pawn_screen

onready var bottom_hud = $HBoxContainer/VBoxContainer/Console_Bottom_HUD

#var p1_has_credits
#var p2_has_credits
#var p3_has_credits
#var p4_has_credits
#var p5_has_credits

#var p1_started
#var p2_started
#var p3_started
#var p4_started
#var p5_started

#signal use_credit(_player)

func _ready():
#	get_tree().get_current_scene().connect("coin_up", self, "init")
	var test1 = get_tree().get_current_scene().connect("input_to_screen", self, "movement")
#	self.connect("use_credit",get_tree().get_current_scene(),"use_credit")
	if test1 != 0:
		print("error in console start connect input to screen")
	init()

func movement(_player, _dir):
#	print(_player,"    ", _dir)
	if _player == 1:
#		if p1_has_credits:
		if _dir == 5:
			get_tree().get_current_scene().p1_started = true
#				emit_signal("use_credit",_player)
			get_tree().get_current_scene().load_screen(pawn_screen)
			queue_free()
	elif _player == 2:
#		if p2_has_credits:
		if _dir == 5:
			get_tree().get_current_scene().p2_started = true
#				emit_signal("use_credit",_player)
			get_tree().get_current_scene().load_screen(pawn_screen)
			queue_free()
	elif _player == 3:
#		if p3_has_credits:
		if _dir == 5:
			get_tree().get_current_scene().p3_started = true
#				emit_signal("use_credit",_player)
			get_tree().get_current_scene().load_screen(pawn_screen)
			queue_free()
	elif _player == 4:
#		if p4_has_credits:
		if _dir == 5:
			get_tree().get_current_scene().p4_started = true
#				emit_signal("use_credit",_player)
			get_tree().get_current_scene().load_screen(pawn_screen)
			queue_free()
	elif _player == 5:
#		if p5_has_credits:
		if _dir == 5:
			get_tree().get_current_scene().p5_started = true
#				emit_signal("use_credit",_player)
			get_tree().get_current_scene().load_screen(pawn_screen)
			queue_free()
	else:
		print("error invald player in arcade start")


func init(): # _player1, _player2, _player3, _player4, _player5):
	bottom_hud.change_label( 1, 3)
	bottom_hud.change_label( 2, 3)
	bottom_hud.change_label( 3, 3)
	bottom_hud.change_label( 4, 3)
	bottom_hud.change_label( 5, 3)