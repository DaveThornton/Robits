extends Node2D

# export(PackedScene) var ex002
# export(PackedScene) var ex003
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
export(PackedScene) var mp013
export(PackedScene) var mp027
export(PackedScene) var mp051

func get_part(num):
	match num:
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
		13: return mp013
		27: return mp027
		51: return mp051