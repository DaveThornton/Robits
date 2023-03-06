extends VBoxContainer

export(PackedScene) var power_label

func update_stats(_player):
	var ammo_count = Player_Stats.get_ammo_box_count(_player)
	var wow_count = Player_Stats.get_wow_count(_player)
	var jump_count = Player_Stats.get_jump_up_count(_player)
	var shield_count = Player_Stats.get_shield_up_count(_player)
	var speed_count = Player_Stats.get_speed_up_count(_player)
	var nrg_count = Player_Stats.get_nrg_regen_count(_player)
	var battery_count = Player_Stats.get_battery_count(_player)
	var coin_count = Player_Stats.get_coin_count(_player)
	var dot_count = Player_Stats.get_dot_count(_player)
	var back_shield_count = Player_Stats.get_back_shield_count(_player)
	var balloon_count = Player_Stats.get_balloon_count(_player)

	var c = self.get_child_count()

	if ammo_count > 0:
		make_label("Ammo Boxes",str(ammo_count))
	if wow_count > 0:
		make_label("WOWs Hit",str(wow_count))
	if jump_count > 0:
		make_label("Super Jump",str(jump_count))
	if shield_count > 0:
		make_label("Shields",str(shield_count))
	if speed_count > 0:
		make_label("Speed Up",str(speed_count))
	if nrg_count > 0:
		make_label("NRG Power Up",str(nrg_count))
	if battery_count > 0:
		make_label("Batteries",str(battery_count))
	if coin_count > 0:
		make_label("Coins",str(coin_count))
	if dot_count > 0:
		make_label("Dots",str(dot_count))
	if back_shield_count > 0:
		make_label("Back Shield",str(back_shield_count))
	if balloon_count > 0:
		make_label("Balloons",str(balloon_count))

	if c == self.get_child_count():
		self.visible = false
	else:
		self.visible = true

func make_label(s1,s2):
	var w = power_label.instance()
	self.add_child(w)
	w.update_strings(s1, s2)
