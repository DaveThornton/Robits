extends Node2D

onready var s01 = $Sprite01
onready var s02 = $Sprite02
onready var s03 = $Sprite03
onready var s04 = $Sprite04
onready var s05 = $Sprite05
onready var s06 = $Sprite06
onready var s07 = $Sprite07
onready var s08 = $Sprite08
onready var s09 = $Sprite09
onready var s10 = $Sprite10
onready var s11 = $Sprite11
onready var s12 = $Sprite12
onready var s13 = $Sprite13
onready var s14 = $Sprite14
onready var s15 = $Sprite15
onready var s16 = $Sprite16
onready var s17 = $Sprite17
onready var s18 = $Sprite18
onready var s19 = $Sprite19
onready var s20 = $Sprite20

func set_maps(_m01,_m02,_m03,_m04,_m05,_m06,_m07,_m08,_m09,_m10,_m11,_m12,_m13,_m14,_m15,_m16,_m17,_m18,_m19,_m20):
	s01.frame = _m01
	s02.frame = _m02
	s03.frame = _m03
	s04.frame = _m04
	s05.frame = _m05
	s06.frame = _m06
	s07.frame = _m07
	s08.frame = _m08
	s09.frame = _m09
	s10.frame = _m10
	s11.frame = _m11
	s12.frame = _m12
	s13.frame = _m13
	s14.frame = _m14
	s15.frame = _m15
	s16.frame = _m16
	s17.frame = _m17
	s18.frame = _m18
	s19.frame = _m19
	s20.frame = _m20

func set_map(_spot, _num):
	if _spot == 1:
		s01.frame = _num
	elif _spot == 2:
		s02.frame = _num
	elif _spot == 3:
		s03.frame = _num
	elif _spot == 4:
		s04.frame = _num
	elif _spot == 5:
		s05.frame = _num
	elif _spot == 6:
		s06.frame = _num
	elif _spot == 7:
		s07.frame = _num
	elif _spot == 8:
		s08.frame = _num
	elif _spot == 9:
		s09.frame = _num
	elif _spot == 10:
		s10.frame = _num
	elif _spot == 11:
		s11.frame = _num
	elif _spot == 12:
		s12.frame = _num
	elif _spot == 13:
		s13.frame = _num
	elif _spot == 14:
		s14.frame = _num
	elif _spot == 15:
		s15.frame = _num
	elif _spot == 16:
		s16.frame = _num
	elif _spot == 17:
		s17.frame = _num
	elif _spot == 18:
		s18.frame = _num
	elif _spot == 19:
		s19.frame = _num
	elif _spot == 20:
		s20.frame = _num
	else:
		print_debug("menu 4x5 map vs error wrong number set_map", _spot, _num)

func return_map_from_spot(_spot):
	if _spot == 1:
		return s01.frame
	elif _spot == 2:
		return s02.frame
	elif _spot == 3:
		return s03.frame
	elif _spot == 4:
		return s04.frame
	elif _spot == 5:
		return s05.frame
	elif _spot == 6:
		return s06.frame
	elif _spot == 7:
		return s07.frame
	elif _spot == 8:
		return s08.frame
	elif _spot == 9:
		return s09.frame
	elif _spot == 10:
		return s10.frame
	elif _spot == 11:
		return s11.frame
	elif _spot == 12:
		return s12.frame
	elif _spot == 13:
		return s13.frame
	elif _spot == 14:
		return s14.frame
	elif _spot == 15:
		return s15.frame
	elif _spot == 16:
		return s16.frame
	elif _spot == 17:
		return s17.frame
	elif _spot == 18:
		return s18.frame
	elif _spot == 19:
		return s19.frame
	elif _spot == 20:
		return s20.frame
	else:
		print_debug("menu 4x5 map vs error wrong number return_map_from_spot")
