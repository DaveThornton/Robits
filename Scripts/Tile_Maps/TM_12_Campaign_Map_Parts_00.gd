extends TileMap

const MP_15_LEVEL_CHANGE_01 = 0
const MP_15_LEVEL_CHANGE_02 = 1
const MP_15_LEVEL_CHANGE_03 = 2
const MP_15_AREA_LEVEL_CHANGE_01 = 3
const MP_15_AREA_LEVEL_CHANGE_02 = 4
const MP_15_AREA_LEVEL_CHANGE_03 = 5
const MP_23_AREA_WORLD_SELECT = 6
const MP_25_TURRET_ACT_01 = 7
const MP_25_TURRET_ACT_02 = 8
const MP_25_TURRET_ACT_03 = 9
const MP_25_TURRET_ACT_04 = 10
const MP_25_TURRET_CAMERA = 11
const MP_25_TURRET_START = 12
const MP_72_STOP_CAMERA = 13



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

			MP_25_TURRET_ACT_01:
				var bg = spawn_bg(cell, 25, part_offset, true)
				bg.set_activation_num(1)
			MP_25_TURRET_ACT_02:
				var bg = spawn_bg(cell, 25, part_offset, true)
				bg.set_activation_num(2)
			MP_25_TURRET_ACT_03:
				var bg = spawn_bg(cell, 25, part_offset, true)
				bg.set_activation_num(3)
			MP_25_TURRET_ACT_04:
				var bg = spawn_bg(cell, 25, part_offset, true)
				bg.set_activation_num(4)
			MP_25_TURRET_CAMERA:
				# print_debug("spawning camera activated turret in campaign map parts")
				var bg = spawn_bg(cell, 25, part_offset, true)
				bg.set_camera_activation(true)
			MP_25_TURRET_START:
				var bg = spawn_bg(cell, 25, part_offset, true)
				bg.call_deferred("activate",0)
			MP_72_STOP_CAMERA:
				spawn_part(cell, 72, part_offset, false)



func spawn_part(pos, mp_num, offset, _return):
	self.set_cell(pos.x, pos.y, -1)
	var sp = Map_Hand.get_map_part(mp_num).instance()
	add_part_to_map(sp)
	sp.global_position = self.map_to_world(pos) + offset
	if _return:
		return sp

func spawn_bg(pos, bg_num, offset, _return):
	self.set_cell(pos.x, pos.y, -1)
	var new_bg = Campaign.get_bad_guy(bg_num).instance()
	Map_Hand.add_bg_to_map(new_bg)
	new_bg.global_position = self.map_to_world(pos) + offset
	if _return:
		return new_bg

func add_part_to_map(part):
	Map_Hand.add_part_to_map(part)