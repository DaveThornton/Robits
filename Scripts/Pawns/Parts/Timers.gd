extends Node2D

var dad

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

func start_jump():
	$Jump.start()
