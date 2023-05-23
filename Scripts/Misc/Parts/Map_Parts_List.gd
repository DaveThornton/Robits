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
export(PackedScene) var mp027
export(PackedScene) var mp029
export(PackedScene) var mp043
export(PackedScene) var mp050
export(PackedScene) var mp051

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
		27: return mp027
		29: return mp029
		43: return mp043
		50: return mp050
		51: return mp051