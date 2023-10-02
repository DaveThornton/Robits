extends TileMap

var spawn_bg_cam_part_num = 16
var spawn_bg_start_part_num = 16

const PLAYER_SPAWN_CELL_NUM = 0
const PLAYER_SPAWN_CAMP_CELL_NUM = 1

const BG_SPAWN_CAM_00 = 101
const BG_SPAWN_CAM_01 = 2
const BG_SPAWN_CAM_02 = 3
const BG_SPAWN_CAM_03 = 4
const BG_SPAWN_CAM_04 = 5
const BG_SPAWN_CAM_05 = 6
const BG_SPAWN_CAM_06 = 7
const BG_SPAWN_CAM_07 = 8
const BG_SPAWN_CAM_08 = 9
const BG_SPAWN_CAM_09 = 10
const BG_SPAWN_CAM_10 = 11
# const BG_SPAWN_CAM_11 = 12
# const BG_SPAWN_CAM_12 = 13
# const BG_SPAWN_CAM_13 = 14
# const BG_SPAWN_CAM_14 = 15
# const BG_SPAWN_CAM_15 = 16
# const BG_SPAWN_CAM_16 = 17
# const BG_SPAWN_CAM_17 = 18
# const BG_SPAWN_CAM_18 = 19
# const BG_SPAWN_CAM_19 = 20
# const BG_SPAWN_CAM_20 = 21
# const BG_SPAWN_CAM_21 = 22
# const BG_SPAWN_CAM_22 = 23
# const BG_SPAWN_CAM_23 = 24
# const BG_SPAWN_CAM_24 = 25
# const BG_SPAWN_CAM_25 = 26
# const BG_SPAWN_CAM_26 = 27
# const BG_SPAWN_CAM_27 = 28
# const BG_SPAWN_CAM_28 = 29
# const BG_SPAWN_CAM_29 = 30
# const BG_SPAWN_CAM_30 = 31
# const BG_SPAWN_CAM_31 = 32
# const BG_SPAWN_CAM_32 = 33
# const BG_SPAWN_CAM_33 = 34
# const BG_SPAWN_CAM_34 = 35
# const BG_SPAWN_CAM_35 = 36
# const BG_SPAWN_CAM_36 = 37
# const BG_SPAWN_CAM_37 = 38
# const BG_SPAWN_CAM_38 = 39
# const BG_SPAWN_CAM_39 = 40
# const BG_SPAWN_CAM_40 = 41
# const BG_SPAWN_CAM_41 = 42
# const BG_SPAWN_CAM_42 = 43
# const BG_SPAWN_CAM_43 = 44
# const BG_SPAWN_CAM_44 = 45
# const BG_SPAWN_CAM_45 = 46
# const BG_SPAWN_CAM_46 = 47
# const BG_SPAWN_CAM_47 = 48
# const BG_SPAWN_CAM_48 = 49
# const BG_SPAWN_CAM_49 = 50
# const BG_SPAWN_CAM_50 = 51
# const BG_SPAWN_CAM_51 = 52
# const BG_SPAWN_CAM_52 = 53
# const BG_SPAWN_CAM_53 = 54
# const BG_SPAWN_CAM_54 = 55
# const BG_SPAWN_CAM_55 = 56
# const BG_SPAWN_CAM_56 = 57
# const BG_SPAWN_CAM_57 = 58
# const BG_SPAWN_CAM_58 = 59
# const BG_SPAWN_CAM_59 = 60
# const BG_SPAWN_CAM_60 = 61
# const BG_SPAWN_CAM_61 = 62
# const BG_SPAWN_CAM_62 = 63
# const BG_SPAWN_CAM_63 = 64
# const BG_SPAWN_CAM_64 = 65
# const BG_SPAWN_CAM_65 = 66
# const BG_SPAWN_CAM_66 = 67
# const BG_SPAWN_CAM_67 = 68
# const BG_SPAWN_CAM_68 = 69
# const BG_SPAWN_CAM_69 = 70
# const BG_SPAWN_CAM_70 = 71
# const BG_SPAWN_CAM_71 = 72
# const BG_SPAWN_CAM_72 = 73
# const BG_SPAWN_CAM_73 = 74
# const BG_SPAWN_CAM_74 = 75
# const BG_SPAWN_CAM_75 = 76
# const BG_SPAWN_CAM_76 = 77
# const BG_SPAWN_CAM_77 = 78
# const BG_SPAWN_CAM_78 = 79
# const BG_SPAWN_CAM_79 = 80
# const BG_SPAWN_CAM_80 = 81
# const BG_SPAWN_CAM_81 = 82
# const BG_SPAWN_CAM_82 = 83
# const BG_SPAWN_CAM_83 = 84
# const BG_SPAWN_CAM_84 = 85
# const BG_SPAWN_CAM_85 = 86
# const BG_SPAWN_CAM_86 = 87
# const BG_SPAWN_CAM_87 = 88
# const BG_SPAWN_CAM_88 = 89
# const BG_SPAWN_CAM_89 = 90
# const BG_SPAWN_CAM_90 = 91
# const BG_SPAWN_CAM_91 = 92
# const BG_SPAWN_CAM_92 = 93
# const BG_SPAWN_CAM_93 = 94
# const BG_SPAWN_CAM_94 = 95
# const BG_SPAWN_CAM_95 = 96
# const BG_SPAWN_CAM_96 = 97
# const BG_SPAWN_CAM_97 = 98
# const BG_SPAWN_CAM_98 = 99
# const BG_SPAWN_CAM_99 = 100

const BG_SPAWN_START_00 = 201
const BG_SPAWN_START_01 = 102
const BG_SPAWN_START_02 = 103
const BG_SPAWN_START_03 = 104
const BG_SPAWN_START_04 = 105
const BG_SPAWN_START_05 = 106
const BG_SPAWN_START_06 = 107
const BG_SPAWN_START_07 = 108
const BG_SPAWN_START_08 = 109
const BG_SPAWN_START_09 = 110
const BG_SPAWN_START_10 = 111
# const BG_SPAWN_START_11 = 112
# const BG_SPAWN_START_12 = 113
# const BG_SPAWN_START_13 = 114
# const BG_SPAWN_START_14 = 115
# const BG_SPAWN_START_15 = 116
# const BG_SPAWN_START_16 = 117
# const BG_SPAWN_START_17 = 118
# const BG_SPAWN_START_18 = 119
# const BG_SPAWN_START_19 = 120
# const BG_SPAWN_START_20 = 121
# const BG_SPAWN_START_21 = 122
# const BG_SPAWN_START_22 = 123
# const BG_SPAWN_START_23 = 124
# const BG_SPAWN_START_24 = 125
# const BG_SPAWN_START_25 = 126
# const BG_SPAWN_START_26 = 127
# const BG_SPAWN_START_27 = 128
# const BG_SPAWN_START_28 = 129
# const BG_SPAWN_START_29 = 130
# const BG_SPAWN_START_30 = 131
# const BG_SPAWN_START_31 = 132
# const BG_SPAWN_START_32 = 133
# const BG_SPAWN_START_33 = 134
# const BG_SPAWN_START_34 = 135
# const BG_SPAWN_START_35 = 136
# const BG_SPAWN_START_36 = 137
# const BG_SPAWN_START_37 = 138
# const BG_SPAWN_START_38 = 139
# const BG_SPAWN_START_39 = 140
# const BG_SPAWN_START_40 = 141
# const BG_SPAWN_START_41 = 142
# const BG_SPAWN_START_42 = 143
# const BG_SPAWN_START_43 = 144
# const BG_SPAWN_START_44 = 145
# const BG_SPAWN_START_45 = 146
# const BG_SPAWN_START_46 = 147
# const BG_SPAWN_START_47 = 148
# const BG_SPAWN_START_48 = 149
# const BG_SPAWN_START_49 = 150
# const BG_SPAWN_START_50 = 151
# const BG_SPAWN_START_51 = 152
# const BG_SPAWN_START_52 = 153
# const BG_SPAWN_START_53 = 154
# const BG_SPAWN_START_54 = 155
# const BG_SPAWN_START_55 = 156
# const BG_SPAWN_START_56 = 157
# const BG_SPAWN_START_57 = 158
# const BG_SPAWN_START_58 = 159
# const BG_SPAWN_START_59 = 160
# const BG_SPAWN_START_60 = 161
# const BG_SPAWN_START_61 = 162
# const BG_SPAWN_START_62 = 163
# const BG_SPAWN_START_63 = 164
# const BG_SPAWN_START_64 = 165
# const BG_SPAWN_START_65 = 166
# const BG_SPAWN_START_66 = 167
# const BG_SPAWN_START_67 = 168
# const BG_SPAWN_START_68 = 169
# const BG_SPAWN_START_69 = 170
# const BG_SPAWN_START_70 = 171
# const BG_SPAWN_START_71 = 172
# const BG_SPAWN_START_72 = 173
# const BG_SPAWN_START_73 = 174
# const BG_SPAWN_START_74 = 175
# const BG_SPAWN_START_75 = 176
# const BG_SPAWN_START_76 = 177
# const BG_SPAWN_START_77 = 178
# const BG_SPAWN_START_78 = 179
# const BG_SPAWN_START_79 = 180
# const BG_SPAWN_START_80 = 181
# const BG_SPAWN_START_81 = 182
# const BG_SPAWN_START_82 = 183
# const BG_SPAWN_START_83 = 184
# const BG_SPAWN_START_84 = 185
# const BG_SPAWN_START_85 = 186
# const BG_SPAWN_START_86 = 187
# const BG_SPAWN_START_87 = 188
# const BG_SPAWN_START_88 = 189
# const BG_SPAWN_START_89 = 190
# const BG_SPAWN_START_90 = 191
# const BG_SPAWN_START_91 = 192
# const BG_SPAWN_START_92 = 193
# const BG_SPAWN_START_93 = 194
# const BG_SPAWN_START_94 = 195
# const BG_SPAWN_START_95 = 196
# const BG_SPAWN_START_96 = 197
# const BG_SPAWN_START_97 = 198
# const BG_SPAWN_START_98 = 199
# const BG_SPAWN_START_99 = 200

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

			BG_SPAWN_CAM_00:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(0)
			BG_SPAWN_CAM_01:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(1)
			BG_SPAWN_CAM_02:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(2)
			BG_SPAWN_CAM_03:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(3)
			BG_SPAWN_CAM_04:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(4)
			BG_SPAWN_CAM_05:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(5)
			BG_SPAWN_CAM_06:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(6)
			BG_SPAWN_CAM_07:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(7)
			BG_SPAWN_CAM_08:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(8)
			BG_SPAWN_CAM_09:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(9)
			BG_SPAWN_CAM_10:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(10)

			BG_SPAWN_START_00:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(0)
				my_bg.set_spawn_at_start(true)
			BG_SPAWN_START_01:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(1)
				my_bg.set_spawn_at_start(true)
			BG_SPAWN_START_02:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(2)
				my_bg.set_spawn_at_start(true)
			BG_SPAWN_START_03:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(3)
				my_bg.set_spawn_at_start(true)
			BG_SPAWN_START_04:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(4)
				my_bg.set_spawn_at_start(true)
			BG_SPAWN_START_05:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(5)
				my_bg.set_spawn_at_start(true)
			BG_SPAWN_START_06:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(6)
				my_bg.set_spawn_at_start(true)
			BG_SPAWN_START_07:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(7)
				my_bg.set_spawn_at_start(true)
			BG_SPAWN_START_08:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(8)
				my_bg.set_spawn_at_start(true)
			BG_SPAWN_START_09:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(9)
				my_bg.set_spawn_at_start(true)
			BG_SPAWN_START_10:
				part_offset = Vector2(16,30)
				var my_bg = spawn_part(cell, spawn_bg_cam_part_num, part_offset, true)
				my_bg.set_bad_guy(10)
				my_bg.set_spawn_at_start(true)

func spawn_player_spawn(pos, mp_num, offset, _return):
	self.set_cell(pos.x, pos.y, -1)
	var sp = Map_Hand.get_map_part(mp_num).instance()
	if pos.x >= 60:
		add_part_to_map(sp)
	elif pos.x >= 0:
		add_to_player_spawns(sp)
	else:
		print_debug("error in adding player spawn in TM 10 PLayer NPC SPAWN 00. pos.x = ",pos.x , " .  should be more than 0 or add ability otherwise")
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