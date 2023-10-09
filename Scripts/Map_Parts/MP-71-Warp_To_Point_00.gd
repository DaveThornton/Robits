extends Area2D

var warp_number = 1

func setup(_warp_number):
	warp_number = _warp_number

func _on_MP71Warp_To_Point_00_body_entered(body:Node):
	if body.has_method("warp_to"):
		body.warp_to(Map_Hand.get_warp_point(warp_number))
	else:
		print_debug("this obj doesnt have the warp to function so nothing happened")