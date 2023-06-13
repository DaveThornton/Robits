extends Node2D

export(PackedScene) var mp002
export(PackedScene) var mp005_128_dn
export(PackedScene) var mp005_128_up
export(PackedScene) var mp005_96_dn
export(PackedScene) var mp005_96_up
export(PackedScene) var mp005_64_dn
export(PackedScene) var mp005_64_up
export(PackedScene) var mp006_128
export(PackedScene) var mp006_96
export(PackedScene) var mp006_64
export(PackedScene) var mp010
export(PackedScene) var mp011
export(PackedScene) var mp011_camp
export(PackedScene) var mp013
export(PackedScene) var mp017
export(PackedScene) var mp018
export(PackedScene) var mp019
export(PackedScene) var mp024
export(PackedScene) var mp025
export(PackedScene) var mp027
export(PackedScene) var mp029
export(PackedScene) var mp031
export(PackedScene) var mp033
export(PackedScene) var mp043
export(PackedScene) var mp044
export(PackedScene) var mp045
export(PackedScene) var mp050
export(PackedScene) var mp051
export(PackedScene) var mp055
export(PackedScene) var mp058
export(PackedScene) var mp059
export(PackedScene) var mp060
export(PackedScene) var mp061
export(PackedScene) var mp063
export(PackedScene) var mp064
export(PackedScene) var mp070
export(PackedScene) var mp071
export(PackedScene) var mp090


func get_part(num):
	match num:
		2: return mp002
		5.1: return mp005_128_dn
		5.2: return mp005_128_up
		5.3: return mp005_96_dn
		5.4: return mp005_96_up
		5.5: return mp005_64_dn
		5.6: return mp005_64_up
		6.1: return mp006_128
		6.2: return mp006_96
		6.3: return mp006_64

		10: return mp010
		11: return mp011
		11.1: return mp011_camp
		13: return mp013
		17: return mp017
		18: return mp018
		19: return mp019
		24: return mp024
		25: return mp025
		27: return mp027
		29: return mp029
		31: return mp031
		33: return mp033
		43: return mp043
		44: return mp044
		45: return mp045
		50: return mp050
		51: return mp051
		55: return mp055
		58: return mp058
		59: return mp059
		60: return mp060
		61: return mp061
		63: return mp063
		64: return mp064
		70: return mp070
		71: return mp071
		90: return mp090