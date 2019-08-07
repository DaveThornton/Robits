extends Node2D
export(PackedScene) var gun_hold_01
export(PackedScene) var gun_hold_02
export(PackedScene) var gun_hold_03
export(PackedScene) var gun_hold_04
#export(PackedScene) var gun_hold_05
#export(PackedScene) var gun_hold_06
#export(PackedScene) var gun_hold_07
#export(PackedScene) var gun_hold_08
#export(PackedScene) var gun_hold_09
export(PackedScene) var gun_hold_10
export(PackedScene) var gun_hold_11
#export(PackedScene) var gun_hold_12
#export(PackedScene) var gun_hold_13
#export(PackedScene) var gun_hold_14
#export(PackedScene) var gun_hold_15
#export(PackedScene) var gun_hold_16
#export(PackedScene) var gun_hold_17
#export(PackedScene) var gun_hold_18
#export(PackedScene) var gun_hold_19
export(PackedScene) var gun_hold_20
export(PackedScene) var gun_hold_21
export(PackedScene) var gun_hold_22
export(PackedScene) var gun_hold_23
#export(PackedScene) var gun_hold_24
#export(PackedScene) var gun_hold_25
#export(PackedScene) var gun_hold_26
#export(PackedScene) var gun_hold_27
#export(PackedScene) var gun_hold_28
#export(PackedScene) var gun_hold_29
#export(PackedScene) var gun_hold_30
#export(PackedScene) var gun_hold_31
#export(PackedScene) var gun_hold_32
#export(PackedScene) var gun_hold_33
#export(PackedScene) var gun_hold_34
#export(PackedScene) var gun_hold_35
#export(PackedScene) var gun_hold_36
#export(PackedScene) var gun_hold_37
#export(PackedScene) var gun_hold_38
#export(PackedScene) var gun_hold_39
export(PackedScene) var gun_hold_40
#export(PackedScene) var gun_hold_41
#export(PackedScene) var gun_hold_42
#export(PackedScene) var gun_hold_43
#export(PackedScene) var gun_hold_44
#export(PackedScene) var gun_hold_45
#export(PackedScene) var gun_hold_46
#export(PackedScene) var gun_hold_47
#export(PackedScene) var gun_hold_48
#export(PackedScene) var gun_hold_49
export(PackedScene) var gun_hold_50
export(PackedScene) var gun_hold_60
export(PackedScene) var gun_hold_61
export(PackedScene) var gun_hold_80

export(PackedScene) var item_pick_01
export(PackedScene) var item_pick_02
export(PackedScene) var item_pick_03
export(PackedScene) var item_pick_04
export(PackedScene) var item_pick_05
export(PackedScene) var item_pick_06

var test_text ="hello world"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_weap_hold(_weap):
	if _weap == 1:
		return gun_hold_01
	elif _weap == 2:
		return gun_hold_02
	elif _weap == 3:
		return gun_hold_03
	elif _weap == 4:
		return gun_hold_04
	elif _weap == 10:
		return gun_hold_10
	elif _weap == 11:
		return gun_hold_11
	elif _weap == 20:
		return gun_hold_20
	elif _weap == 21:
		return gun_hold_21
	elif _weap == 22:
		return gun_hold_22
	elif _weap == 23:
		return gun_hold_23
	elif _weap == 40:
		return gun_hold_40
	elif _weap == 50:
		return gun_hold_50
	elif _weap == 60:
		return gun_hold_60
	elif _weap == 61:
		return gun_hold_61
	elif _weap == 80:
		return gun_hold_80
	else:
		print("Error in Singleton Equipment wrong weap number ----> ", _weap)

func get_weap_pick(_item):
	pass

func get_item(_item):
	if _item == 1:
		return item_pick_01
	elif _item == 2:
		return item_pick_02
	elif _item == 3:
		return item_pick_03
	elif _item == 4:
		return item_pick_04
	elif _item == 5:
		return item_pick_05
	elif _item == 6:
		return item_pick_06
	else:
		print("Error in Singleton Equipment wrong item number ----> ", _item)

func test():
	print(test_text)
	return test_text