extends TileMap

const FX_09_LOG_FULL = 0
const FX_09_LOG_HALF = 1
const FX_09_LOG_QUART = 2
const FX_09_LOG_BOARD = 3

func _ready():
	Map_Hand.map.connect("start",self,"start_spawning_parts")

func start_spawning_parts():
	var part_offset = Vector2(0,0)
	var cells = self.get_used_cells()
	for cell in cells:
		part_offset = Vector2(0,0)
		var index = self.get_cell(cell.x, cell.y)
		match index:
			FX_09_LOG_FULL:
				part_offset = Vector2(64,-17)
				var part = spawn_part(cell, 9, part_offset, true)
				part.set_frame(0)
			FX_09_LOG_HALF:
				part_offset = Vector2(64,-17)
				var part = spawn_part(cell, 9, part_offset, true)
				part.set_frame(1)
			FX_09_LOG_QUART:
				part_offset = Vector2(64,-17)
				var part = spawn_part(cell, 9, part_offset, true)
				part.set_frame(2)
			FX_09_LOG_BOARD:
				part_offset = Vector2(64,-17)
				var part = spawn_part(cell, 9, part_offset, true)
				part.set_frame(3)

func spawn_part(pos, fx_num, offset, _return):
	self.set_cell(pos.x, pos.y, -1)
	var sp = FX.get_part(fx_num).instance()
	add_part_to_map(sp)
	sp.global_position = self.map_to_world(pos) + offset
	if _return:
		return sp

func add_part_to_map(part):
	Map_Hand.add_part_to_map(part)
