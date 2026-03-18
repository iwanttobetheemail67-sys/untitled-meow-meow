extends Control


func _ready():
	AudioHandler.nightmare.stop()
	AudioHandler.bg_music.stop()
	AudioHandler.play_nightmare()
	if AudioHandler.super_gravity == true:
		$ColorRect/CheckButton.button_pressed = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 10
	if AudioHandler.blind == true:
		$ColorRect/CheckButton2.button_pressed = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 10
	if AudioHandler.snail == true:
		$ColorRect/CheckButton3.button_pressed = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 10
	if AudioHandler.hyper == true:
		$ColorRect/CheckButton4.button_pressed = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 10

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.super_gravity = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult + 10
		if AudioHandler.fast_fall == true:
			AudioHandler.difficulty = 2500
		else:
			AudioHandler.difficulty = 1250
	if toggled_on == false:
		AudioHandler.super_gravity = false
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 10
		if AudioHandler.fast_fall == true:
			AudioHandler.difficulty = 500
		else:
			AudioHandler.difficulty = 250

func _on_check_button_2_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.blind = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult + 10
	if toggled_on == false:
		AudioHandler.blind = false
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 10

func _on_check_button_3_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.snail = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult + 10
		if AudioHandler.slow == true:
			AudioHandler.SPEED = 250
		else:
			AudioHandler.SPEED = 500
	if toggled_on == false:
		AudioHandler.snail = false
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 10
		if AudioHandler.slow == true:
			AudioHandler.SPEED = 750
		else:
			AudioHandler.SPEED = 1000

func _on_check_button_4_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.hyper = true
		AudioHandler.challenge_mult = AudioHandler.challenge_mult + 10
		AudioHandler.spawn_rate = 3
	if toggled_on == false:
		AudioHandler.hyper = false
		AudioHandler.challenge_mult = AudioHandler.challenge_mult - 10
		AudioHandler.spawn_rate = 1

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
	AudioHandler.nightmare.stop()
	AudioHandler.play_bg_music()
	get_tree().call_deferred("change_scene_to_file", "res://challenges.tscn")
