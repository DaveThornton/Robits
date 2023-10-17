extends Node2D

var playing = false
var voice_que = []
var is_spelling = false

func play(voice_num:int):
	if playing:
		add_to_que(voice_num)
	else:
		playing = true
		if (self.get_child_count()-1) >= voice_num:
			self.get_child(voice_num).play()
		else:
			print_debug("error in SFX Voice invalid voice_num ", voice_num, " it should be less than ", self.get_child_count(), "  it will play ROBITS instead")
			self.get_child(0).play()

func add_to_que(voice_num:int):
	if !voice_que.has(voice_num) || is_spelling:
		voice_que.append(voice_num)
		

func voice_finished():
	playing = false
	if !voice_que.empty():
		play(voice_que.pop_front())

func spell(word:String):
	var l = word.length()
	is_spelling = true
	for p in l:
		print(word.substr(p,1))
		play(letter_number_look_up(word.substr(p,1)))
	is_spelling = false

func read_number(num:int):
	print_debug(num)
	is_spelling = true
	var my_num = num
	var s_num = str(num)
	var a = []
	var l = s_num.length()
	while l > 3:
		print_debug(l," length   ", a, " array ", s_num, "  num")
		
		var n = s_num.right(s_num.length()- 3)
		a.append(n)
		my_num = (my_num - int(n)) / 1000
		s_num = str(my_num)
		l -= 3
	
	if s_num.length() > 0:
		a.append(s_num)
	
	print_debug(a)
	if a.size() == 3:
		speak_hundred(a.pop_back())
		play(85)
	if a.size() == 2:
		speak_hundred(a.pop_back())
		play(84)
	if a.size() == 1:
		speak_hundred(a.pop_back())

	is_spelling = false
	
func speak_hundred(num:String):
	print_debug(num, "hund")
	var my_num = num
	var this_num = int(my_num)
	if this_num > 99:
		# print_debug(my_num.substr(0,1),my_num.substr(1,1),my_num.substr(2,1),my_num.substr(3,1)," this")
		var n = int(my_num.substr(0,1))
		play(letter_number_look_up(my_num.substr(0,1)))
		play(83)
		my_num = str(this_num - (n * 100))
		speak_tens(my_num)
		# this_num = int(my_num) - int(letter_number_look_up(my_num.substr(0,1)) * 100)
		my_num = str(this_num)
	elif this_num > 0:
		speak_tens(my_num)

func speak_tens(num:String):
	print_debug(num, "tens")
	var my_num = num
	if my_num.length() == 2:
		var this_num = int(my_num)
		if this_num < 20:
			if this_num > 9:
				match this_num:
					19:
						play(letter_number_look_up(str(9)))
						play(82)
					18:
						play(letter_number_look_up(str(8)))
						play(82)
					17:
						play(letter_number_look_up(str(7)))
						play(82)
					16:
						play(letter_number_look_up(str(6)))
						play(82)
					15:
						play(letter_number_look_up(str(5)))
						play(82)
					14:
						play(letter_number_look_up(str(4)))
						play(82)
					13:play(73)
					12:play(72)
					11:play(71)
					10:play(70)


		else:
			print(my_num.substr(0,1))
			match my_num.substr(0,1):
				"2": play(74)
				"3": play(75)
				"4": play(76)
				"5": play(77)
				"6": play(78)
				"7": play(79)
				"8": 
					play(80)
				"9": play(81)
			speak_single(my_num.substr(1,1))
	else:speak_single(num)

func speak_single(num:String):
	print_debug(num, " single")
	play(letter_number_look_up(num))


		# play(letter_number_look_up(my_num.substr(1,1)))
		# play(83)
		# this_num = int(my_num) - int(letter_number_look_up(my_num.substr(1,1)) * 100)
		# my_num = str(this_num)


func letter_number_look_up(letter:String):
	letter = letter.to_upper()
	match letter:
		"A": return 30
		"B": return 31
		"C": return 32
		"D": return 33
		"E": return 34
		"F": return 35
		"G": return 36
		"H": return 37
		"I": return 38
		"J": return 39
		"K": return 40
		"L": return 41
		"M": return 42
		"N": return 43
		"O": return 44
		"P": return 45
		"Q": return 46
		"R": return 47
		"S": return 48
		"T": return 49
		"U": return 50
		"V": return 51
		"W": return 52
		"X": return 53
		"Y": return 54
		"Z": return 55
		"*": return 56
		"!": return 57
		"#": return 58
		"%": return 59
		"0": return 60
		"1": return 61
		"2": return 62
		"3": return 63
		"4": return 64
		"5": return 65
		"6": return 66
		"7": return 67
		"8": return 68
		"9": return 69
		_:return 28
