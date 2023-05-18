extends TileMap

const MP_51_SAW = 0
const MP_13_SPIKE_BLOCK = 1
const MP_05_DOOR_DN_128 = 2
const MP_05_DOOR_UP_128 = 3
const MP_05_DOOR_DN_96 = 4
const MP_05_DOOR_UP_96 = 5
const MP_05_DOOR_DN_64 = 6
const MP_05_DOOR_UP_64 = 7
const MP_27_BARREL_SPAWNER = 8
const MP_06_TRAP_DOOR_128 = 9
const MP_06_TRAP_DOOR_96 = 10
const MP_06_TRAP_DOOR_64 = 11
const MP_43_WOW = 12
const MP_29_TRASH= 13


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
			MP_51_SAW:
				spawn_part(cell, 51, part_offset)
			MP_13_SPIKE_BLOCK:
				part_offset = Vector2(16,16)
				spawn_part(cell, 13, part_offset)
			MP_05_DOOR_DN_128:
				part_offset = Vector2(16,32)
				spawn_part(cell, 05.1, part_offset)
			MP_05_DOOR_UP_128:
				part_offset = Vector2(16,32)
				spawn_part(cell, 05.2, part_offset)
			MP_05_DOOR_DN_96:
				part_offset = Vector2(16,32)
				spawn_part(cell, 05.3, part_offset)
			MP_05_DOOR_UP_96:
				part_offset = Vector2(16,32)
				spawn_part(cell, 05.4, part_offset)
			MP_05_DOOR_DN_64:
				part_offset = Vector2(16,32)
				spawn_part(cell, 05.5, part_offset)
			MP_05_DOOR_UP_64:
				part_offset = Vector2(16,32)
				spawn_part(cell, 05.6, part_offset)
			MP_27_BARREL_SPAWNER:
				part_offset = Vector2(16,30)
				spawn_part(cell, 27, part_offset)				
			MP_06_TRAP_DOOR_128:
				# part_offset = Vector2(0,0)
				spawn_part(cell, 06.1, part_offset)
			MP_06_TRAP_DOOR_96:
				# part_offset = Vector2(0,0)
				spawn_part(cell, 06.2, part_offset)
			MP_06_TRAP_DOOR_64:
				# part_offset = Vector2(0,0)
				spawn_part(cell, 06.3, part_offset)
			MP_43_WOW:
				part_offset = Vector2(16,16)
				spawn_part(cell, 43, part_offset)
			MP_29_TRASH:
				part_offset = Vector2(16,16)
				spawn_part(cell, 29, part_offset)


func spawn_part(pos, mp_num, offset):
	self.set_cell(pos.x, pos.y, -1)
	var sp = Map_Hand.get_map_part(mp_num).instance()
	add_part_to_map(sp)
	sp.global_position = self.map_to_world(pos) + offset

func add_part_to_map(part):
	Map_Hand.add_part_to_map(part)
