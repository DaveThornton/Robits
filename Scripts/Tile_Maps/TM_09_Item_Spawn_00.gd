extends TileMap

const WEAP_01_R = 0

func _ready():
	Map_Hand.map.connect("start",self,"start_spawning_parts")

func start_spawning_parts():
	var part_offset = Vector2(0,0)
	var cells = self.get_used_cells()
	for cell in cells:
		part_offset = Vector2(0,0)
		var index = self.get_cell(cell.x, cell.y)
		print("index :   ",index)
		match index:
			WEAP_01_R:
				var new_mark = spawn_part(cell, 10, part_offset)
				new_mark.set_spawn(1, 1, 0)

func spawn_part(pos, mp_num, offset):
	self.set_cell(pos.x, pos.y, -1)
	var sp = Map_Hand.get_map_part(mp_num).instance()
	add_part_to_map(sp)
	sp.global_position = self.map_to_world(pos) + offset
	return sp

func add_part_to_map(part):
	Map_Hand.add_part_to_map(part)