extends HBoxContainer
#
#onready var count = $Label_Continue_Count
#
#func _ready():
#	pass # Replace with function body.
#
#func continue_update(_num:int): count.text = str(_num)
#
#func set_continue(_continue):
#	if _continue:
#		Player_Stats.set_continuing(player, true)
#		Player_Stats.set_in_game(player, false)
##		Controllers.get_controller(player)
##		continue_count()
##	else:
##		continue_started = false
###		update_state(10)
##		continue_count_num = 10
##		print_debug("dont know set_continue false in hud 02 in game")
#
#func continue_count():
##	print_debug(continue_count_num)
#	if continue_started:
#		update_state(8)
##		Player_Stats.set_continuing(player, true)
##		Player_Stats.set_can_spawn(player, false)
#		if continue_count_num > 0:
#			continue_count_num -= 1
#			igb_08_continue_count.text = str(continue_count_num)
#		elif continue_count_num <= 0:
#			continue_started = false
##			print_debug(Player_Stats.get_in_play(player), "<------in play --- in game------>",Player_Stats.get_in_game(player))
#			Player_Stats.set_in_play(player,false) 
#			Player_Stats.set_continuing(player, false)
##			Player_Stats.reset_player(player)
##			Player_Stats.set_can_spawn(player, true)
#			Game.check_over()
#			print_debug("end continue if game over?  ", Game.over)
#			if !Game.over:
#				if High_Score.is_score_high(Player_Stats.get_score(player)):
#					print_debug("trying to add name to high scores in game lets see")
#
#
#
#					pass
#				else:
#					Player_Stats.reset_player(player)
#			else:
##				print_debug("call high scores in hud after continue runs out")
#				High_Score.set_visible(true)
#			continue_count_num = 10
##			print_debug("need to do somthing when continue runs out hud 02 vbox in game")
#
