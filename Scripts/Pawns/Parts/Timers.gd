extends Node2D

var dad

#-------------time_out----------------------

func _ready():
	dad = get_parent()

func _on_Knock_Back_timeout():
	dad.knockbacktimer()

func _on_Shield_Hit_timeout():
	dad.shieldhittimer()

func _on_Shield_Up_timeout():
	dad.shielduptimer()

func _on_NRG_Up_timeout():
	dad.nrguptimer()

func _on_Speed_timeout():
	dad.speedtimer()

func _on_Jump_Up_timeout():
	dad.jumpuptimer()

func _on_Stun_timeout():
	dad.stuntimer()

func _on_Jump_timeout():
	dad.jumptimer()

func _on_Last_Hit_By_timeout():
	dad.hitbytimer()

func _on_Show_player_ind_timeout():
	dad.set_ready_show_player_ind(false)

#----------set_timers----------------

func set_knock_back(_time):
	$Knock_Back.wait_time = _time

func set_shield_hit(_time):
	$Shield_Hit.wait_time = _time

func set_shield_up(_time):
	$Shield_Up.wait_time = _time

func set_nrg_up(_time):
	$NRG_Up.wait_time = _time

func set_jump_up(_time):
	$Jump_Up.wait_time = _time

func set_speed(_time):
	$Speed.wait_time = _time

func set_stun(_time):
	$Stun.wait_time = _time

func set_jump(_time):
	$Jump.wait_time = _time

func is_jump_stopped():
	return $Jump.is_stopped()

#-------start_timers---------------------

func start_knock_back():
	$Knock_Back.start()

func start_shield_hit():
	$Shield_Hit.start()

func start_shield_up():
	$Shield_Up.start()

func start_nrg_up():
	$NRG_Up.start()

func start_jump_up():
	$Jump_Up.start()

func start_speed():
	$Speed.start()

func start_stun():
	$Stun.start()

func start_jump():
	$Jump.start()

func start_last_hit_by():
	$Last_Hit_By.start()

func start_show_player_ind():
	$Show_player_ind.start()