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
const MP_29_TRASH = 13
const MP_50_THWOMP_PROX = 14
const MP_50_THWOMP_ODD = 15
const MP_50_THWOMP_EVEN = 16
const MP_50_THWOMP_ALL = 17
const MP_50_THWOMP_1OF4 = 18
const MP_50_THWOMP_2OF4 = 19
const MP_50_THWOMP_3OF4 = 20
const MP_50_THWOMP_4OF4 = 21
const MP_31_FALLING_BLOCK= 22
const MP_33_BELT_MOVE_RIGHT = 23
const MP_33_BELT_MOVE_LEFT = 24
const MP_45_MOVE_PLAT_L = 25
const MP_45_MOVE_PLAT_R = 26
const MP_45_MOVE_PLAT_U = 27
const MP_45_MOVE_PLAT_D = 28
const MP_55_BLASTDOOR = 29
const MP_39_PE_064 = 30
const MP_39_PE_128 = 31
const MP_39_PE_256 = 32
const MP_39_PE_512 = 33
const MP_55_BLASTDOOR_DEAD = 34

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
			MP_51_SAW:
				spawn_part(cell, 51, part_offset, false)
			MP_13_SPIKE_BLOCK:
				part_offset = Vector2(16,16)
				spawn_part(cell, 13, part_offset, false)
			MP_05_DOOR_DN_128:
				part_offset = Vector2(16,32)
				spawn_part(cell, 05.1, part_offset, false)
			MP_05_DOOR_UP_128:
				part_offset = Vector2(16,32)
				spawn_part(cell, 05.2, part_offset, false)
			MP_05_DOOR_DN_96:
				part_offset = Vector2(16,32)
				spawn_part(cell, 05.3, part_offset, false)
			MP_05_DOOR_UP_96:
				part_offset = Vector2(16,32)
				spawn_part(cell, 05.4, part_offset, false)
			MP_05_DOOR_DN_64:
				part_offset = Vector2(16,32)
				spawn_part(cell, 05.5, part_offset, false)
			MP_05_DOOR_UP_64:
				part_offset = Vector2(16,32)
				spawn_part(cell, 05.6, part_offset, false)
			MP_27_BARREL_SPAWNER:
				part_offset = Vector2(16,30)
				spawn_part(cell, 27, part_offset, false)				
			MP_06_TRAP_DOOR_128:
				spawn_part(cell, 06.1, part_offset, false)
			MP_06_TRAP_DOOR_96:
				spawn_part(cell, 06.2, part_offset, false)
			MP_06_TRAP_DOOR_64:
				spawn_part(cell, 06.3, part_offset, false)
			MP_43_WOW:
				part_offset = Vector2(16,16)
				spawn_part(cell, 43, part_offset, false)
			MP_29_TRASH:
				part_offset = Vector2(16,16)
				spawn_part(cell, 29, part_offset, false)
			MP_50_THWOMP_PROX:
				part_offset = Vector2(16,16)
				spawn_part(cell, 50, part_offset, false)#(_trigger_on_prox, _hit_on_second, _count_to_second, _wait_time)
			MP_50_THWOMP_ODD:
				part_offset = Vector2(16,16)
				var part = spawn_part(cell, 50, part_offset, true)
				part.setup(false, 1, 2, 1)
			MP_50_THWOMP_EVEN:
				part_offset = Vector2(16,16)
				var part = spawn_part(cell, 50, part_offset, true)
				part.setup(false, 2, 2, 1)
			MP_50_THWOMP_ALL:
				part_offset = Vector2(16,16)
				var part = spawn_part(cell, 50, part_offset, true)
				part.setup(false, 1, 1, 0.1)
			MP_50_THWOMP_1OF4:
				part_offset = Vector2(16,16)
				var part = spawn_part(cell, 50, part_offset, true)
				part.setup(false, 1, 4, 1)
			MP_50_THWOMP_2OF4:
				part_offset = Vector2(16,16)
				var part = spawn_part(cell, 50, part_offset, true)
				part.setup(false, 2, 4, 1)
			MP_50_THWOMP_3OF4:
				part_offset = Vector2(16,16)
				var part = spawn_part(cell, 50, part_offset, true)
				part.setup(false, 3, 4, 1)
			MP_50_THWOMP_4OF4:
				part_offset = Vector2(16,16)
				var part = spawn_part(cell, 50, part_offset, true)
				part.setup(false, 4, 4, 1)
			MP_31_FALLING_BLOCK:
				spawn_part(cell, 31, part_offset, true)
			MP_33_BELT_MOVE_RIGHT:
				part_offset = Vector2(16,16)
				var autopart = self.get_cell_autotile_coord(cell.x,cell.y)
				var autopart_x = autopart.x
				print("autopart = ", autopart_x)
				# spawn_belt_part(cell,autopart_x, true)
				var part = spawn_part(cell, 33, part_offset, true)
				if autopart_x == 1:
					part.setup(1, true)
				elif autopart_x == 0:
					part.setup(0, true)
				elif autopart_x == 2:
					part.setup(2, true)
				elif autopart_x == 3:
					part.setup(3, true)
			MP_33_BELT_MOVE_LEFT:
				part_offset = Vector2(16,16)
				var autopart = self.get_cell_autotile_coord(cell.x,cell.y)
				var autopart_x = autopart.x
				print("autopart = ", autopart_x)
				var part = spawn_part(cell, 33, part_offset, true)
				if autopart_x == 1:
					part.setup(1, false)
				elif autopart_x == 0:
					part.setup(0, false)
				elif autopart_x == 2:
					part.setup(2, false)
				elif autopart_x == 3:
					part.setup(3, false)
			MP_45_MOVE_PLAT_L:
				part_offset = Vector2(48,0)
				var part = spawn_part(cell, 45, part_offset, true)#(_up_down, _left_right, _going_up, _going_right)
				part.change_dir(false, true, false, false)
			MP_45_MOVE_PLAT_R:
				part_offset = Vector2(48,0)
				var part = spawn_part(cell, 45, part_offset, true)
				part.change_dir(false, true, true, true)
			MP_45_MOVE_PLAT_U:
				part_offset = Vector2(48,0)
				var part = spawn_part(cell, 45, part_offset, true)
				part.change_dir(true, false, true, true)
			MP_45_MOVE_PLAT_D:
				part_offset = Vector2(48,0)
				var part = spawn_part(cell, 45, part_offset, true)
				part.change_dir(true, false, false, true)
			MP_55_BLASTDOOR:
				part_offset = Vector2(16,-32)
				spawn_part(cell, 55, part_offset, false)
			MP_39_PE_064:
				part_offset = Vector2(16,32)
				var part = spawn_part(cell, 39, part_offset, true)
				part.setup(64)
			MP_39_PE_128:
				part_offset = Vector2(16,32)
				var part = spawn_part(cell, 39, part_offset, true)
				part.setup(128)
			MP_39_PE_256:
				part_offset = Vector2(16,32)
				var part = spawn_part(cell, 39, part_offset, true)
				part.setup(256)
			MP_39_PE_512:
				part_offset = Vector2(16,32)
				var part = spawn_part(cell, 39, part_offset, true)
				part.setup(512)
			MP_55_BLASTDOOR_DEAD:
				part_offset = Vector2(16,-32)
				var part = spawn_part(cell, 55, part_offset, true)
				part.already_dead()


func spawn_part(pos, mp_num, offset, _return):
	self.set_cell(pos.x, pos.y, -1)
	var sp = Map_Hand.get_map_part(mp_num).instance()
	add_part_to_map(sp)
	sp.global_position = self.map_to_world(pos) + offset
	if _return:
		return sp

func add_part_to_map(part):
	Map_Hand.add_part_to_map(part)
