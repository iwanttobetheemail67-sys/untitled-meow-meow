extends Control

@onready var the_score: Label = $"ColorRect/THE SCORE"
@onready var the_score_2: Label = $"ColorRect/THE SCORE2"
@onready var new_best_text: Label = $"ColorRect/new best"
@onready var time: Label = $ColorRect/time


var new_best = false

func _ready() -> void:
	get_tree().call_group("kill_me", "queue_free")
	AudioHandler.nightmare.stop()
	$AudioStreamPlayer.play()
	AudioHandler.play_bg_music()
	AudioHandler.super_hard_mode = false
	if AudioHandler.game_won == false:
		if AudioHandler.score > AudioHandler.high_score:
			AudioHandler.high_score = AudioHandler.score
			new_best = true
	else:
		new_best = false
	if AudioHandler.game_won == true:
		if AudioHandler.victory == false:
			the_score.text = str("Score: ", int(AudioHandler.score))
			the_score_2.text = str("High Score: ", AudioHandler.final_score)
	else:
		the_score.text = str("Score: ", int(AudioHandler.score))
		the_score_2.text = str("High Score: ", int(AudioHandler.high_score))
	if new_best == true:
		new_best_text.visible = true
	else:
		new_best_text.visible = false
	if AudioHandler.victory == true:
		the_score.text = str("Score: 999999999999999999999999999999999999999999999999")
		the_score_2.text = str("High Score: ", AudioHandler.final_score)
		new_best_text.visible = true
	if AudioHandler.victory_2 == true:
		the_score.text = str("Score: ∞")
		the_score_2.text = str("High Score: ", AudioHandler.final_score)
		new_best_text.visible = true
	if AudioHandler.victory_3 == true:
		the_score.text = str("Score: ∞²")
		the_score_2.text = str("High Score: ", AudioHandler.final_score)
		new_best_text.visible = true
	AudioHandler.victory = false
	AudioHandler.victory_2 = false
	AudioHandler.victory_3 = false
	AudioHandler.score = 0
	AudioHandler.fast_mode = false
	AudioHandler.slow_mode = false
	AudioHandler.score_freeze = false
	AudioHandler.freeze = false
	AudioHandler.fish_mode = false
	AudioHandler.health = 3
	if AudioHandler.frail == true:
		AudioHandler.health = 1
	AudioHandler.difficulty = 250
	if AudioHandler.fast_fall == true:
		AudioHandler.difficulty = 500
		if AudioHandler.super_gravity == true:
			AudioHandler.difficulty = 2500
	elif AudioHandler.super_gravity == true:
		AudioHandler.difficulty = 1250
	AudioHandler.SPEED = 1000
	if AudioHandler.slow == true:
		AudioHandler.SPEED = 750
		if AudioHandler.snail == true:
			AudioHandler.SPEED = 250
	elif AudioHandler.snail == true:
		AudioHandler.SPEED = 500
	AudioHandler.spawn_rate = 1
	if AudioHandler.hard_mode == true:
		AudioHandler.spawn_rate = 2
	if AudioHandler.hyper == true:
		AudioHandler.spawn_rate = 3
	if AudioHandler.show_time == false:
		time.hide()
	if AudioHandler.min_elapased >= 10:
		if AudioHandler.sec_elapased >= 10:
			if AudioHandler.ms_elapased < 10:
				time.text = str("Time survived: ", int(AudioHandler.min_elapased), ":", int(AudioHandler.sec_elapased), ":0", int(AudioHandler.ms_elapased))
			else:
				time.text = str("Time survived: ", int(AudioHandler.min_elapased), ":", int(AudioHandler.sec_elapased), ":", int(AudioHandler.ms_elapased))
		else:
			if AudioHandler.ms_elapased < 10:
				time.text = str("Time survived: ", int(AudioHandler.min_elapased), ":0", int(AudioHandler.sec_elapased), ":0", int(AudioHandler.ms_elapased))
			else:
				time.text = str("Time survived: ", int(AudioHandler.min_elapased), ":0", int(AudioHandler.sec_elapased), ":", int(AudioHandler.ms_elapased))
	else:
		if AudioHandler.sec_elapased >= 10:
			if AudioHandler.ms_elapased < 10:
				time.text = str("Time survived: 0", int(AudioHandler.min_elapased), ":", int(AudioHandler.sec_elapased), ":0", int(AudioHandler.ms_elapased))
			else:
				time.text = str("Time survived: 0", int(AudioHandler.min_elapased), ":", int(AudioHandler.sec_elapased), ":", int(AudioHandler.ms_elapased))
		else:
			if AudioHandler.ms_elapased < 10:
				time.text = str("Time survived: 0", int(AudioHandler.min_elapased), ":0", int(AudioHandler.sec_elapased), ":0", int(AudioHandler.ms_elapased))
			else:
				time.text = str("Time survived: 0", int(AudioHandler.min_elapased), ":0", int(AudioHandler.sec_elapased), ":", int(AudioHandler.ms_elapased))
	AudioHandler.ms_elapased = 0
	AudioHandler.sec_elapased = 0
	AudioHandler.min_elapased = 0
func _on_button_pressed() -> void:
	if AudioHandler.slow == true:
		if AudioHandler.snail == true:
			AudioHandler.SPEED = 250
		else:
			AudioHandler.SPEED = 750
	elif AudioHandler.snail == true:
		AudioHandler.SPEED = 500
	else:
		AudioHandler.SPEED = 1000
	if AudioHandler.hard_mode == true:
		get_tree().call_deferred("change_scene_to_file", "res://true_nightmare_start.tscn")
	else:
		get_tree().call_deferred("change_scene_to_file", "res://Untitled_Meow_Meow.tscn")
	

func _on_button_2_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://control.tscn")
	

func _on_button_3_pressed() -> void:
	get_tree().quit()
