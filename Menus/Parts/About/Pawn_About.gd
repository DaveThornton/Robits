extends Node2D
onready var pic = $Pawn_Pic
onready var info = $Info

export var player_color = 7

func _ready():
	var c1 = Player_Stats.get_body_color(player_color)
	var c2 = Player_Stats.get_sec_color(player_color)
	pic.color(c1,c2)
	info.color(c1,c2)

func _on_Pawn_09_About_visibility_changed():
	if self.visible:
		info.print_about()
	else:
		info.clear_about()