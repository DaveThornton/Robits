extends TileMap

const PLAYER_SPAWN_CELL_NUM = 0
const PLAYER_SPAWN_CAMP_CELL_NUM = 1

func _ready():
	Map_Hand.map.connect("start",self,"start_spawning_parts")

func start_spawning_parts():
	var part_offset = Vector2(0,0)
	var cells = self.get_used_cells()
	for cell in cells:
		part_offset = Vector2(0,0)
		var index = self.get_cell(cell.x, cell.y)
		match index:
			PLAYER_SPAWN_CELL_NUM:
				part_offset = Vector2(16,30)
				spawn_player_spawn(cell, 11, part_offset, false)
			PLAYER_SPAWN_CAMP_CELL_NUM:
				part_offset = Vector2(16,30)
				spawn_player_spawn(cell, 11.1, part_offset, false)

func spawn_player_spawn(pos, mp_num, offset, _return):
	self.set_cell(pos.x, pos.y, -1)
	var sp = Map_Hand.get_map_part(mp_num).instance()
	add_to_player_spawns(sp)
	sp.global_position = self.map_to_world(pos) + offset

func spawn_part(pos, mp_num, offset, _return):
	self.set_cell(pos.x, pos.y, -1)
	var sp = Map_Hand.get_map_part(mp_num).instance()
	add_part_to_map(sp)
	sp.global_position = self.map_to_world(pos) + offset
	if _return:
		return sp

func add_part_to_map(part):
	Map_Hand.add_part_to_map(part)

func add_to_player_spawns(part):
	Map_Hand.add_player_spawn(part)