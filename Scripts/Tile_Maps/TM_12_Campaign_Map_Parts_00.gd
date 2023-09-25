extends TileMap

const MP_15_LEVEL_CHANGE_01 = 0
const MP_15_LEVEL_CHANGE_02 = 1
const MP_15_LEVEL_CHANGE_03 = 2
const MP_15_AREA_LEVEL_CHANGE_01 = 3
const MP_15_AREA_LEVEL_CHANGE_02 = 4
const MP_15_AREA_LEVEL_CHANGE_03 = 5
const MP_23_AREA_WORLD_SELECT = 6

func _ready():
	Map_Hand.map.connect("start",self,"start_spawning_parts")

func start_spawning_parts():
	var part_offset = Vector2(0,0)
	var cells = self.get_used_cells()
	for cell in cells:
		part_offset = Vector2(0,0)
		var index = self.get_cell(cell.x, cell.y)
		# print("index :   ",index)
		match index:
			MP_15_LEVEL_CHANGE_01:
				part_offset = Vector2(0,32)
				var part = spawn_part(cell, 15, part_offset, true)
				part.set_map_to_load(1)
			MP_15_LEVEL_CHANGE_02:
				part_offset = Vector2(0,32)
				var part = spawn_part(cell, 15, part_offset, true)
				part.set_map_to_load(2)
			MP_15_LEVEL_CHANGE_03:
				part_offset = Vector2(0,32)
				var part = spawn_part(cell, 15, part_offset, true)
				part.set_map_to_load(3)

			MP_15_AREA_LEVEL_CHANGE_01:
				# part_offset = Vector2(0,32)
				var part = spawn_part(cell, 15.1, part_offset, true)
				part.set_map_to_load(1)
			MP_15_AREA_LEVEL_CHANGE_02:
				# part_offset = Vector2(0,32)
				var part = spawn_part(cell, 15.1, part_offset, true)
				part.set_map_to_load(2)
			MP_15_AREA_LEVEL_CHANGE_03:
				# part_offset = Vector2(0,32)
				var part = spawn_part(cell, 15.1, part_offset, true)
				part.set_map_to_load(3)
			MP_23_AREA_WORLD_SELECT:
				spawn_part(cell, 23, part_offset, false)


func spawn_part(pos, mp_num, offset, _return):
	self.set_cell(pos.x, pos.y, -1)
	var sp = Map_Hand.get_map_part(mp_num).instance()
	add_part_to_map(sp)
	sp.global_position = self.map_to_world(pos) + offset
	if _return:
		return sp

func add_part_to_map(part):
	Map_Hand.add_part_to_map(part)