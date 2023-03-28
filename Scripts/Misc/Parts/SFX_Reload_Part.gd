extends Node2D

var list = {
	50: "W_50_Reload"
}

func reload(_num):
	if list.has(_num):
		get_node(list[_num]).play()	
	else:
		pass