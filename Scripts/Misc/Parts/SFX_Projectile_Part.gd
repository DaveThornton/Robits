extends Node2D

# var pro_02
var list = {
	1: "001",
	2: "002",
	3: "003",
	4: "004",
	5: "005",
	6: "006",
	7: "007",
	8: "008",
	9: "009",
	10: "010",
	11: "011",
	12: "012",
	13: "013",
	14: "014",
	15: "015",
	16: "016",
	17: "017",
	18: "018",
	19: "019",
	40: "040",
	41: "041",
	42: "042",
	50: "050",
	51: "051",
	56: "056",
	57: "057",
	58: "058",
#TODO: give Weap 59 Bow its own sount FX
	59: "007",
	83: "083",
	84: "084"
}

func play(_num):
	if list.has(_num):
		get_node(list[_num]).play()	
	else:
		print_debug("error no sound for projectile  ", _num, "  in SFX.Projectile_part")