extends Node2D

export(PackedScene) var gun_hold_00
export(PackedScene) var gun_hold_01
export(PackedScene) var gun_hold_02
export(PackedScene) var gun_hold_03
export(PackedScene) var gun_hold_04
#export(PackedScene) var gun_hold_05
#export(PackedScene) var gun_hold_06
export(PackedScene) var gun_hold_07
export(PackedScene) var gun_hold_08
export(PackedScene) var gun_hold_09
export(PackedScene) var gun_hold_10
export(PackedScene) var gun_hold_11
export(PackedScene) var gun_hold_12
export(PackedScene) var gun_hold_13
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
export(PackedScene) var gun_hold_27
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
export(PackedScene) var gun_hold_39
export(PackedScene) var gun_hold_40
export(PackedScene) var gun_hold_41
#export(PackedScene) var gun_hold_42
#export(PackedScene) var gun_hold_43
#export(PackedScene) var gun_hold_44
#export(PackedScene) var gun_hold_45
#export(PackedScene) var gun_hold_46
#export(PackedScene) var gun_hold_47
#export(PackedScene) var gun_hold_48
#export(PackedScene) var gun_hold_49
export(PackedScene) var gun_hold_50
export(PackedScene) var gun_hold_51
export(PackedScene) var gun_hold_52
export(PackedScene) var gun_hold_53
#export(PackedScene) var gun_hold_54
#export(PackedScene) var gun_hold_55
export(PackedScene) var gun_hold_56
#export(PackedScene) var gun_hold_57
#export(PackedScene) var gun_hold_58
#export(PackedScene) var gun_hold_59
export(PackedScene) var gun_hold_60
export(PackedScene) var gun_hold_61
export(PackedScene) var gun_hold_62
export(PackedScene) var gun_hold_63
export(PackedScene) var gun_hold_64
export(PackedScene) var gun_hold_65
export(PackedScene) var gun_hold_66
#export(PackedScene) var gun_hold_67
#export(PackedScene) var gun_hold_68
export(PackedScene) var gun_hold_69
#export(PackedScene) var gun_hold_70
#export(PackedScene) var gun_hold_71
#export(PackedScene) var gun_hold_72
#export(PackedScene) var gun_hold_73
#export(PackedScene) var gun_hold_74
#export(PackedScene) var gun_hold_75
#export(PackedScene) var gun_hold_76
#export(PackedScene) var gun_hold_77
#export(PackedScene) var gun_hold_78
#export(PackedScene) var gun_hold_79
export(PackedScene) var gun_hold_80

export(PackedScene) var item_pick_01
export(PackedScene) var item_pick_02
export(PackedScene) var item_pick_03
export(PackedScene) var item_pick_04
export(PackedScene) var item_pick_05
export(PackedScene) var item_pick_06
#export(PackedScene) var item_pick_07
#export(PackedScene) var item_pick_08
#export(PackedScene) var item_pick_09
#export(PackedScene) var item_pick_10
#export(PackedScene) var item_pick_11
#export(PackedScene) var item_pick_12
#export(PackedScene) var item_pick_13
#export(PackedScene) var item_pick_14
#export(PackedScene) var item_pick_15
#export(PackedScene) var item_pick_16
#export(PackedScene) var item_pick_17
#export(PackedScene) var item_pick_18
#export(PackedScene) var item_pick_19
#export(PackedScene) var item_pick_20

export(PackedScene) var pawn_01
export(PackedScene) var pawn_02
export(PackedScene) var pawn_03
export(PackedScene) var pawn_04
export(PackedScene) var pawn_05
export(PackedScene) var pawn_06
export(PackedScene) var pawn_07
export(PackedScene) var pawn_08
export(PackedScene) var pawn_09
export(PackedScene) var pawn_10
export(PackedScene) var pawn_11
export(PackedScene) var pawn_12
export(PackedScene) var pawn_13
export(PackedScene) var pawn_14
export(PackedScene) var pawn_15
#export(PackedScene) var pawn_16

func get_weap_hold(_weap: int):
	if _weap < 25:
		if _weap == 0:
			return gun_hold_00
		elif _weap == 1:
			return gun_hold_01
		elif _weap == 2:
			return gun_hold_02
		elif _weap == 3:
			return gun_hold_03
		elif _weap == 4:
			return gun_hold_04
	#	elif _weap == 5:
	#		return gun_hold_05
	#	elif _weap == 6:
	#		return gun_hold_06
		elif _weap == 7:
			return gun_hold_07
		elif _weap == 8:
			return gun_hold_08
		elif _weap == 9:
			return gun_hold_09
		elif _weap == 10:
			return gun_hold_10
		elif _weap == 11:
			return gun_hold_11
		elif _weap == 12:
			return gun_hold_12
		elif _weap == 13:
			return gun_hold_13
		elif _weap == 20:
			return gun_hold_20
		elif _weap == 21:
			return gun_hold_21
		elif _weap == 22:
			return gun_hold_22
		elif _weap == 23:
			return gun_hold_23
		else:
			print("Error in Singleton Equipment wrong weap number ----> ", _weap, " ... so you get a AK-47")
			return gun_hold_02
	elif _weap < 50:
		if _weap == 27:
			return gun_hold_27
		elif _weap == 39:
			return gun_hold_39
		elif _weap == 40:
			return gun_hold_40
		elif _weap == 41:
			return gun_hold_41
		elif _weap == 50:
			return gun_hold_50
		else:
			print("Error in Singleton Equipment wrong weap number ----> ", _weap, " ... so you get a AK-47")
			return gun_hold_02
	elif _weap < 75:
		if _weap == 51:
			return gun_hold_51
		elif _weap == 52:
			return gun_hold_52
		elif _weap == 53:
			return gun_hold_53
		elif _weap == 56:
			return gun_hold_56
		elif _weap == 60:
			return gun_hold_60
		elif _weap == 61:
			return gun_hold_61
		elif _weap == 62:
			return gun_hold_62
		elif _weap == 63:
			return gun_hold_63
		elif _weap == 64:
			return gun_hold_64
		elif _weap == 65:
			return gun_hold_65
		elif _weap == 66:
			return gun_hold_66
#		elif _weap == 67:
#			return gun_hold_67
#		elif _weap == 68:
#			return gun_hold_68
		elif _weap == 69:
			return gun_hold_69
		else:
			print("Error in Singleton Equipment wrong weap number ----> ", _weap, " ... so you get a AK-47")
			return gun_hold_02
	else:
		if _weap == 80:
			return gun_hold_80
		else:
			print("Error in Singleton Equipment wrong weap number ----> ", _weap, " ... so you get a AK-47")
			return gun_hold_02

func get_weap_pick(_weap):
	print("get_weap_pick is empty in singleton equipment")
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
		print("Error in Singleton Equipment wrong item number ----> ", _item, " you get Ammo")
		return item_pick_01

func get_pawn(_pawn_num):
	if _pawn_num == 1:
		return pawn_01
	elif _pawn_num == 2:
		return pawn_02
	elif _pawn_num == 3:
		return pawn_03
	elif _pawn_num == 4:
		return pawn_04
	elif _pawn_num == 5:
		return pawn_05
	elif _pawn_num == 6:
		return pawn_06
	elif _pawn_num == 7:
		return pawn_07
	elif _pawn_num == 8:
		return pawn_08
	elif _pawn_num == 9:
		return pawn_09
	elif _pawn_num == 10:
		return pawn_10
	elif _pawn_num == 11:
		return pawn_11
	elif _pawn_num == 12:
		return pawn_12
	elif _pawn_num == 13:
		return pawn_13
	elif _pawn_num == 14:
		return pawn_14
	elif _pawn_num == 15:
		return pawn_15
	elif _pawn_num == 16:
		var _pawn = (randi() % 14) + 1
		return get_pawn(_pawn)
	elif _pawn_num == 0:
		print("no pawn selected pawn number = ", _pawn_num, " you get pawn #13")
		return pawn_13
	else:
		print("not a good pawn number ", _pawn_num, " so im sending in pawn #1")
		return pawn_01
