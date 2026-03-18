extends Control


func _ready():
	if AudioHandler.hard_mode == true:
		$ColorRect/hard.button_pressed = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 5
	if AudioHandler.fast_fall == true:
		$ColorRect/CheckButton.button_pressed = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 1
	if AudioHandler.frail == true:
		$ColorRect/CheckButton2.button_pressed = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 1
	if AudioHandler.slow == true:
		$ColorRect/CheckButton3.button_pressed = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 1
	if AudioHandler.evil_drops == true:
		$ColorRect/CheckButton4.button_pressed = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 1

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.fast_fall = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult + 1
		if AudioHandler.super_gravity == true:
			AudioHandler.difficulty = 2500
		else:
			AudioHandler.difficulty = 500
	if toggled_on == false:
		AudioHandler.fast_fall = false
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 1
		if AudioHandler.super_gravity == true:
			AudioHandler.difficulty = 1250
		else:
			AudioHandler.difficulty = 250

func _on_check_button_2_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.frail = true
		AudioHandler.health = 1
		AudioHandler.challenge_mult = AudioHandler.challenge_mult + 1
	if toggled_on == false:
		AudioHandler.frail = false
		AudioHandler.health = 3
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 1

func _on_check_button_3_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.slow = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult + 1
		if AudioHandler.snail == true:
			AudioHandler.SPEED = 250
		else:
			AudioHandler.SPEED = 750
	if toggled_on == false:
		AudioHandler.slow = false
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 1
		if AudioHandler.snail == true:
			AudioHandler.SPEED = 500
		else:
			AudioHandler.SPEED = 1000

func _on_check_button_4_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.evil_drops = true
		AudioHandler.evil_chance = 1
		AudioHandler.challenge_mult = AudioHandler.challenge_mult + 1
	if toggled_on == false:
		AudioHandler.evil_drops = false
		AudioHandler.evil_chance = 0
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 1

func _on_hard_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.hard_mode = true
		AudioHandler.frail = true
		$ColorRect/CheckButton2.button_pressed = true
		AudioHandler.slow = true
		$ColorRect/CheckButton3.button_pressed = true
		AudioHandler.evil_drops = true
		$ColorRect/CheckButton4.button_pressed = true
		AudioHandler.fast_fall = true
		$ColorRect/CheckButton.button_pressed = true
		$ColorRect/CheckButton.disabled = true
		$ColorRect/CheckButton2.disabled = true
		$ColorRect/CheckButton3.disabled = true
		$ColorRect/CheckButton4.disabled = true
		if AudioHandler.hyper == false:
			AudioHandler.spawn_rate = 2
		AudioHandler.evil_chance = 5
		AudioHandler.challenge_mult = AudioHandler.challenge_mult + 5
	if toggled_on == false:
		AudioHandler.hard_mode = false
		$ColorRect/CheckButton.disabled = false
		$ColorRect/CheckButton2.disabled = false
		$ColorRect/CheckButton3.disabled = false
		$ColorRect/CheckButton4.disabled = false
		if AudioHandler.hyper == false:
			AudioHandler.spawn_rate = 1
		AudioHandler.evil_chance = 1
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 5
		
func _input(_event: InputEvent) -> void:
	if AudioHandler.challenge_mult > 50:
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 50
	if AudioHandler.challenge_mult == 50:
		AudioHandler.challenge_mult = 100
	if AudioHandler.mult_cheat == false:
		$ColorRect/Label2/Label.text = str("Scorce Multiplier: ", AudioHandler.challenge_mult)
	else:
		$ColorRect/Label2/Label.text = str("Scorce Multiplier: ", int(AudioHandler.cheat_mult))

func _on_button_3_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://settings.tscn")

func _on_button_4_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://super_challenges.tscn")

func _on_button_5_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://cheats.tscn")
