extends TileMap

const MP_02_KILL_ZONE = 0
const MP_24_EQUIP_START_WEAP = 1
const MP_59_BLOCK_PLAYER = 2
# const MP_13_SPIKE_BLOCK = 1
# const MP_05_DOOR_DN_128 = 2



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
			MP_02_KILL_ZONE:
				spawn_part(cell, 2, part_offset, false)
			MP_24_EQUIP_START_WEAP:
				spawn_part(cell, 24, part_offset, false)
			MP_59_BLOCK_PLAYER:
				part_offset = Vector2(16,16)
				spawn_part(cell, 59, part_offset, false)




func spawn_part(pos, mp_num, offset, _return):
	self.set_cell(pos.x, pos.y, -1)
	var sp = Map_Hand.get_map_part(mp_num).instance()
	add_part_to_map(sp)
	sp.global_position = self.map_to_world(pos) + offset
	if _return:
		return sp


func add_part_to_map(part):
	Map_Hand.add_part_to_map(part)