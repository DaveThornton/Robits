extends Area2D
export var equip_start_weap = true

func _ready():
	pass

func _on_MP24Equip_Start_Weap_Area_body_entered(body):
	if equip_start_weap:
		if body.get_groups().has("player"):
			Game.set_start_equiped(true)
			Controllers.player_equip_start_weap(body.player)
	else:
		if body.get_groups().has("player"):
			Game.set_start_equiped(false)
			Controllers.player_remove_start_weap(body.player)		
















