extends TileMap

const WEAP_01_R = 0
const WEAP_01_O = 1
const WEAP_01_B = 2
const WEAP_01_I = 3
const WEAP_01_T = 4
const WEAP_01_S = 5
const WEAP_01_BANG = 6
const WEAP_01_HOLDER = 7
const WEAP_02_R = 8
const WEAP_02_O = 9
const WEAP_02_B = 10
const WEAP_02_I = 11
const WEAP_02_T = 12
const WEAP_02_S = 13
const WEAP_02_BANG = 14
const WEAP_02_HOLDER = 15
const WEAP_03_R = 16
const WEAP_03_O = 17
const WEAP_03_B = 18
const WEAP_03_I = 19
const WEAP_03_T = 20
const WEAP_03_S = 21
const WEAP_03_BANG = 22
const WEAP_03_HOLDER = 23
const WEAP_04_R = 24
const WEAP_04_O = 25
const WEAP_04_B = 26
const WEAP_04_I = 27
const WEAP_04_T = 28
const WEAP_04_S = 29
const WEAP_04_BANG = 30
const WEAP_04_HOLDER = 31
const WEAP_05_R = 32
const WEAP_05_O = 33
const WEAP_05_B = 34
const WEAP_05_I = 35
const WEAP_05_T = 36
const WEAP_05_S = 37
const WEAP_05_BANG = 38
const WEAP_05_HOLDER = 39
const WEAP_06_R = 40
const WEAP_06_O = 41
const WEAP_06_B = 42
const WEAP_06_I = 43
const WEAP_06_T = 44
const WEAP_06_S = 45
const WEAP_06_BANG = 46
const WEAP_06_HOLDER = 47
const WEAP_07_R = 48
const WEAP_07_O = 49
const WEAP_07_B = 50
const WEAP_07_I = 51
const WEAP_07_T = 52
const WEAP_07_S = 53
const WEAP_07_BANG = 54
const WEAP_07_HOLDER = 55
const WEAP_08_R = 56
const WEAP_08_O = 57
const WEAP_08_B = 58
const WEAP_08_I = 59
const WEAP_08_T = 60
const WEAP_08_S = 61
const WEAP_08_BANG = 62
const WEAP_08_HOLDER = 63

const NADE_01_HOLDER = 64
const NADE_02_HOLDER = 65
const NADE_03_HOLDER = 66
const NADE_04_HOLDER = 67
const POWERUP_01_HOLDER = 68
const POWERUP_02_HOLDER = 69
const POWERUP_03_HOLDER = 70
const POWERUP_04_HOLDER = 71

func _ready():
	Map_Hand.map.connect("start",self,"start_spawning_parts")

func start_spawning_parts():
	var part_offset = Vector2(0,0)
	var cells = self.get_used_cells()
	for cell in cells:
		part_offset = Vector2(16,16)
		var index = self.get_cell(cell.x, cell.y)
		# print("index :   ",index)
		match index:
			WEAP_01_R:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(1, 1, 0)
			WEAP_01_O:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(2, 1, 0)
			WEAP_01_B:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(3, 1, 0)
			WEAP_01_I:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(4, 1, 0)
			WEAP_01_T:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(5, 1, 0)
			WEAP_01_S:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(6, 1, 0)
			WEAP_01_BANG:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(7, 1, 0)
			WEAP_01_HOLDER:
				var new_mark = spawn_part(cell, 17, part_offset)
				new_mark.set_spawn(0)
			WEAP_02_R:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(1, 1, 1)
			WEAP_02_O:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(2, 1, 1)
			WEAP_02_B:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(3, 1, 1)
			WEAP_02_I:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(4, 1, 1)
			WEAP_02_T:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(5, 1, 1)
			WEAP_02_S:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(6, 1, 1)
			WEAP_02_BANG:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(7, 1, 1)
			WEAP_02_HOLDER:
				var new_mark = spawn_part(cell, 17, part_offset)
				new_mark.set_spawn(1)
			WEAP_03_R:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(1, 1, 2)
			WEAP_03_O:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(2, 1, 2)
			WEAP_03_B:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(3, 1, 2)
			WEAP_03_I:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(4, 1, 2)
			WEAP_03_T:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(5, 1, 2)
			WEAP_03_S:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(6, 1, 2)
			WEAP_03_BANG:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(7, 1, 2)
			WEAP_03_HOLDER:
				var new_mark = spawn_part(cell, 17, part_offset)
				new_mark.set_spawn(2)
			WEAP_04_R:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(1, 1, 3)
			WEAP_04_O:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(2, 1, 3)
			WEAP_04_B:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(3, 1, 3)
			WEAP_04_I:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(4, 1, 3)
			WEAP_04_T:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(5, 1, 3)
			WEAP_04_S:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(6, 1, 3)
			WEAP_04_BANG:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(7, 1, 3)
			WEAP_04_HOLDER:
				var new_mark = spawn_part(cell, 17, part_offset)
				new_mark.set_spawn(3)
			WEAP_05_R:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(1, 1, 4)
			WEAP_05_O:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(2, 1, 4)
			WEAP_05_B:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(3, 1, 4)
			WEAP_05_I:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(4, 1, 4)
			WEAP_05_T:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(5, 1, 4)
			WEAP_05_S:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(6, 1, 4)
			WEAP_05_BANG:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(7, 1, 4)
			WEAP_05_HOLDER:
				var new_mark = spawn_part(cell, 17, part_offset)
				new_mark.set_spawn(4)
			WEAP_06_R:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(1, 1, 5)
			WEAP_06_O:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(2, 1, 5)
			WEAP_06_B:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(3, 1, 5)
			WEAP_06_I:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(4, 1, 5)
			WEAP_06_T:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(5, 1, 5)
			WEAP_06_S:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(6, 1, 5)
			WEAP_06_BANG:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(7, 1, 5)
			WEAP_06_HOLDER:
				var new_mark = spawn_part(cell, 17, part_offset)
				new_mark.set_spawn(5)
			WEAP_07_R:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(1, 1, 6)
			WEAP_07_O:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(2, 1, 6)
			WEAP_07_B:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(3, 1, 6)
			WEAP_07_I:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(4, 1, 6)
			WEAP_07_T:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(5, 1, 6)
			WEAP_07_S:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(6, 1, 6)
			WEAP_07_BANG:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(7, 1, 6)
			WEAP_07_HOLDER:
				var new_mark = spawn_part(cell, 17, part_offset)
				new_mark.set_spawn(6)
			WEAP_08_R:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(1, 1, 7)
			WEAP_08_O:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(2, 1, 7)
			WEAP_08_B:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(3, 1, 7)
			WEAP_08_I:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(4, 1, 7)
			WEAP_08_T:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(5, 1, 7)
			WEAP_08_S:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(6, 1, 7)
			WEAP_08_BANG:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(7, 1, 7)
			WEAP_08_HOLDER:
				var new_mark = spawn_part(cell, 17, part_offset)
				new_mark.set_spawn(7)

			NADE_01_HOLDER:
				var new_mark = spawn_part(cell, 18, part_offset)
				new_mark.set_spawn(0)
			NADE_02_HOLDER:
				var new_mark = spawn_part(cell, 18, part_offset)
				new_mark.set_spawn(1)
			NADE_03_HOLDER:
				var new_mark = spawn_part(cell, 18, part_offset)
				new_mark.set_spawn(2)
			NADE_04_HOLDER:
				var new_mark = spawn_part(cell, 18, part_offset)
				new_mark.set_spawn(3)
			POWERUP_01_HOLDER:
				var new_mark = spawn_part(cell, 19, part_offset)
				new_mark.set_spawn(0)
			POWERUP_02_HOLDER:
				var new_mark = spawn_part(cell, 19, part_offset)
				new_mark.set_spawn(1)
			POWERUP_03_HOLDER:
				var new_mark = spawn_part(cell, 19, part_offset)
				new_mark.set_spawn(2)
			POWERUP_04_HOLDER:
				var new_mark = spawn_part(cell, 19, part_offset)
				new_mark.set_spawn(3)



func spawn_part(pos, mp_num, offset):
	self.set_cell(pos.x, pos.y, -1)
	var sp = Map_Hand.get_map_part(mp_num).instance()
	add_part_to_map(sp)
	sp.global_position = self.map_to_world(pos) + offset
	return sp

func add_part_to_map(part):
	Map_Hand.add_part_to_map(part)