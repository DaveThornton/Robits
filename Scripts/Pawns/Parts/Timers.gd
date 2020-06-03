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

func _on_Jump_timeout():
	dad.jumptimer()

func _on_Stun_timeout():
	dad.stuntimer()


#func shieldhittimer()
#
#func shielduptimer()
#
#func nrguptimer()
#
#func speedtimer()
#
#func jumptimer()
#
#func stuntimer()
