extends Node2D
var list = {
	5: "005_Default_Laser",
	6: "005_Default_Laser",
	10: "005_Default_Laser",
	11: "005_Default_Laser",
	12: "005_Default_Laser",
	13: "005_Default_Laser",
	14: "005_Default_Laser",
	15: "005_Default_Laser",
	16: "005_Default_Laser",
	17: "005_Default_Laser",
	56: "005_Default_Laser"
}

func empty(_num):
	if list.has(_num):
		get_node(list[_num]).play()	
	else:
		get_node("000_Default_Gun").play()

