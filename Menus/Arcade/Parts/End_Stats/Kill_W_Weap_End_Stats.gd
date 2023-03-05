extends VBoxContainer

export(PackedScene) var weap_label

func update_stats(_player):
	var stats = Player_Stats.get_killed_w(_player)
	var stat_key = stats.keys()
	var stat_val = stats.values()
	if stat_key.size() > 0:
		self.visible = true
		for i in stat_key.size():
			var w = weap_label.instance()
			self.add_child(w)
			var s1 = Equipment.get_weap_name(stat_key[i])
			var s2 = String(stat_val[i])
			w.update_strings(s1, s2)
	else:
		self.visible = false
