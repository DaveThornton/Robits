extends TileMap

const MP_51_SAW = 0

func _ready():
	Map_Hand.map.connect("start",self,"start_spawning_parts")

func start_spawning_parts():
	var cells = self.get_used_cells()
	for cell in cells:
		var index = self.get_cell(cell.x, cell.y)
		print("index :   ",index)
		match index:
			MP_51_SAW:
				spawn_part(cell, 51)

func spawn_part(pos, mp_num):
	self.set_cell(pos.x, pos.y, -1)
	var sp = Map_Hand.get_map_part(mp_num).instance()
	add_part_to_map(sp)
	sp.global_position = self.map_to_world(pos)

func add_part_to_map(part):
	Map_Hand.add_part_to_map(part)
