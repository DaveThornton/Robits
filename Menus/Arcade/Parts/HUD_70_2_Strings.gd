extends HBoxContainer

onready var spot_01 = $Text_01
onready var spot_02 = $Text_02

func update_strings(string_01: String, string_02: String):
	spot_01.text = string_01
	spot_02.text = string_02