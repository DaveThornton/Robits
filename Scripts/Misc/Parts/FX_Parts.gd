extends Node2D

export(PackedScene) var fx_09_log
# export(PackedScene) var bolt

func get_part(num):
	match num:
		9: return fx_09_log
		_: 
			print_debug("error in FX Parts invalid part number ", num, "retrurning log instead")
			return fx_09_log
