extends VBoxContainer

export var start_pos = 1

var pos = 1

func _ready():
	pos = start_pos
	char_vis(pos)

func up():
	pos -= 1
	if pos == -1:
		pos = 40
	char_vis(pos)

func down():
	pos += 1
	if pos == 41:
		pos = 0
	char_vis(pos)

func char_vis(_char):
	all_out()
	get_child(_char).visible = true
	pass

func all_out():
	for i in get_child_count():
		get_child(i).visible = false

func select():
	return get_child(pos).text

func reset():
	pos = start_pos
	char_vis(pos)
