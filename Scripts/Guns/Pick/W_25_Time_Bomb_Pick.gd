extends 'res://Scripts/Guns/Pick/W_00_Bomb_Pick.gd'

func call_end_of_set_dir(): 
    label.right(is_right)
    # pass


func set_right():
	# label.right(true)
	label.up(true)
func set_left():
    # label.right(false)
	label.up(false)