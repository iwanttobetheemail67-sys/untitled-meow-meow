extends Node

@onready var label: Label = $Player/Camera2D/scaling_spirt/Label
@onready var score_text: Label = $Player/Camera2D/scaling_spirt/SCORE
@onready var diff: Label = $Player/Camera2D/scaling_spirt/diff
@onready var mult: Label = $Player/Camera2D/scaling_spirt/Mult
@onready var time: Label = $Player/Camera2D/scaling_spirt/time
@onready var camera_2d: Camera2D = $Player/Camera2D
@onready var panel: Panel = $Player/Camera2D/scaling_spirt/Panel

var goober = preload("res://falling_goober.tscn")
var fall_health = preload("res://falling_health.tscn")
var falling_speed = preload("res://falling_speed.tscn")
var fall_slow = preload("res://falling_slow.tscn")
var anger_goober = preload("res://anger_goober.tscn")
var death_skull = preload("res://death_skull.tscn")
var angel = preload("res://angel.tscn")
var fish = preload("res://fish.tscn")
var frozen_fish = preload("res://frozen_fish.tscn")
var gold = preload("res://gold_bar.tscn")
var poison = preload("res://poison.tscn")
var upside_down = preload("res://upside_down.tscn")

var time_mult = 0
var spawn_seed = 0
var evil_seed = 0
var object = "null"
var x_pos = 0
var y_pos = 0
var meow = "null"

var challenge_multipler = AudioHandler.challenge_mult
var evil_chance = AudioHandler.evil_chance

func _ready():
	panel.visible = false
	AudioHandler.false_score = 0
	if AudioHandler.hard_mode == false:
		AudioHandler.play_bg_music()
	get_tree().call_group("kill_me", "queue_free")
	AudioHandler.difficulty = 250
	$Player/Camera2D/scaling_spirt/ColorRect.visible = false
	AudioHandler.min_elapased = 0
	AudioHandler.sec_elapased = 0
	AudioHandler.ms_elapased = 0
	camera_2d.zoom = Vector2(0.5, 0.5)
	if AudioHandler.fast_fall == true:
		AudioHandler.difficulty = AudioHandler.difficulty * 2
	if AudioHandler.super_gravity == true:
		AudioHandler.difficulty = AudioHandler.difficulty * 5
	if AudioHandler.show_diff == false:
		diff.hide()
	if AudioHandler.show_time == false:
		time.hide()
	if AudioHandler.frail == true:
		AudioHandler.health = 1
	if AudioHandler.hyper == true:
		AudioHandler.spawn_rate = 3
	if AudioHandler.hyper == false:
		AudioHandler.spawn_rate = 1
	if AudioHandler.blind == true:
		$Player/Camera2D/scaling_spirt/ColorRect.visible = true
		$"Player/Camera2D/scaling_spirt/Score is".add_theme_color_override("font_color", Color.WHITE)
		$Player/Camera2D/scaling_spirt/SCORE.add_theme_color_override("font_color", Color.WHITE)
		$Player/Camera2D/scaling_spirt/diff.add_theme_color_override("font_color", Color.WHITE)
		$Player/Camera2D/scaling_spirt/Mult.add_theme_color_override("font_color", Color.WHITE)
		$Player/Camera2D/scaling_spirt/time.add_theme_color_override("font_color", Color.WHITE)
		$Player/Camera2D/scaling_spirt/Panel.add_theme_color_override("bg_color", Color.WHITE)
		$Player/Camera2D/scaling_spirt/Panel/resume.add_theme_color_override("bg_color", Color.WHITE)
		$Player/Camera2D/scaling_spirt/Panel/restart.add_theme_color_override("bg_color", Color.BLACK)
		$Player/Camera2D/scaling_spirt/Panel/perish.add_theme_color_override("bg_color", Color.BLACK)
		$Player/Camera2D/scaling_spirt/Panel/exit.add_theme_color_override("bg_color", Color.BLACK)
	if AudioHandler.diff_cheat == true:
		AudioHandler.difficulty = int(AudioHandler.cheat_diff)
	if AudioHandler.mult_cheat == true:
		challenge_multipler = AudioHandler.cheat_mult
	if AudioHandler.health_cheat == true:
		AudioHandler.health = int(AudioHandler.cheat_health)
	if AudioHandler.speed_cheat == true:
		AudioHandler.SPEED = AudioHandler.cheat_speed
	if AudioHandler.zoom_cheat == true:
		camera_2d.zoom = Vector2(AudioHandler.cheat_zoom, AudioHandler.cheat_zoom)
		if AudioHandler.cheat_zoom == 0.05:
			$Player/Camera2D/scaling_spirt.scale = Vector2(7, 7)
		if AudioHandler.cheat_zoom == 0.1:
			$Player/Camera2D/scaling_spirt.scale = Vector2(3.5, 3.5)
		if AudioHandler.cheat_zoom == 0.15:
			$Player/Camera2D/scaling_spirt.scale = Vector2(2.34, 2.34)
		if AudioHandler.cheat_zoom == 0.2:
			$Player/Camera2D/scaling_spirt.scale = Vector2(1.75, 1.75)
		if AudioHandler.cheat_zoom == 0.25:
			$Player/Camera2D/scaling_spirt.scale = Vector2(1.4, 1.4)
		if AudioHandler.cheat_zoom == 0.3:
			$Player/Camera2D/scaling_spirt.scale = Vector2(1.17, 1.17)
		if AudioHandler.cheat_zoom > 0.3:
			$Player/Camera2D/scaling_spirt.scale = Vector2(1, 1)
	else:
		$Player/Camera2D/scaling_spirt.scale = Vector2(1, 1)
		$Player/Camera2D.zoom = Vector2(0.5, 0.5)
	if AudioHandler.hitboxes == true:
		$Player/ColorRect.visible = true
	if AudioHandler.amount_cheat == true:
		AudioHandler.spawn_rate = AudioHandler.cheat_amount
	if AudioHandler.evil_cheat == true:
		evil_chance = AudioHandler.cheat_evil

func _on_kill_box_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().call_group("kill_me", "queue_free")
		AudioHandler.nightmare.stop()
		AudioHandler.play_bg_music()
		AudioHandler.play_death()
		get_tree().call_deferred("change_scene_to_file", "res://control.tscn")
	
func _process(_delta: float) -> void:
	label.text = str(AudioHandler.health)
	score_text.text = str(int(AudioHandler.false_score))
	diff.text = str("Fall Speed: ", AudioHandler.difficulty)
	mult.text = str("Mult: ", (float(challenge_multipler + time_mult)))
	if AudioHandler.health == 1:
		$Player/Camera2D/scaling_spirt/Label.add_theme_color_override("font_color", Color.RED)
	elif AudioHandler.health == 2:
		$Player/Camera2D/scaling_spirt/Label.add_theme_color_override("font_color", Color.YELLOW)
	else:
		$Player/Camera2D/scaling_spirt/Label.add_theme_color_override("font_color", Color.GREEN)

func _on_timer_timeout() -> void:
	if AudioHandler.score_freeze == false:
		AudioHandler.false_score = AudioHandler.false_score + (challenge_multipler + time_mult) * 100
	if AudioHandler.score_freeze == true:
		AudioHandler.false_score = AudioHandler.false_score - (challenge_multipler + time_mult) * 100
	if AudioHandler.fish_mode == false:
		if AudioHandler.hard_mode == true:
			AudioHandler.difficulty = AudioHandler.difficulty + 30
		elif AudioHandler.fast_fall == true:
			AudioHandler.difficulty = AudioHandler.difficulty + 20
		else:
			AudioHandler.difficulty = AudioHandler.difficulty + 10

func _on_timer_2_timeout() -> void:
	time_mult = time_mult + 0.1

func _on_timer_3_timeout() -> void:
	AudioHandler.ms_elapased = AudioHandler.ms_elapased + 1
	if AudioHandler.ms_elapased >= 100:
		AudioHandler.ms_elapased = 0
		AudioHandler.sec_elapased = AudioHandler.sec_elapased + 1
	if AudioHandler.sec_elapased >= 60:
		AudioHandler.sec_elapased = 0
		AudioHandler.min_elapased = AudioHandler.min_elapased + 1
		
	if AudioHandler.min_elapased >= 10:
		if AudioHandler.sec_elapased >= 10:
			if AudioHandler.ms_elapased < 10:
				time.text = str("Time: ", int(AudioHandler.min_elapased), ":", int(AudioHandler.sec_elapased), ":0", int(AudioHandler.ms_elapased))
			else:
				time.text = str("Time: ", int(AudioHandler.min_elapased), ":", int(AudioHandler.sec_elapased), ":", int(AudioHandler.ms_elapased))
		else:
			if AudioHandler.ms_elapased < 10:
				time.text = str("Time: ", int(AudioHandler.min_elapased), ":0", int(AudioHandler.sec_elapased), ":0", int(AudioHandler.ms_elapased))
			else:
				time.text = str("Time: ", int(AudioHandler.min_elapased), ":0", int(AudioHandler.sec_elapased), ":", int(AudioHandler.ms_elapased))
	else:
		if AudioHandler.sec_elapased >= 10:
			if AudioHandler.ms_elapased < 10:
				time.text = str("Time: 0", int(AudioHandler.min_elapased), ":", int(AudioHandler.sec_elapased), ":0", int(AudioHandler.ms_elapased))
			else:
				time.text = str("Time: 0", int(AudioHandler.min_elapased), ":", int(AudioHandler.sec_elapased), ":", int(AudioHandler.ms_elapased))
		else:
			if AudioHandler.ms_elapased < 10:
				time.text = str("Time: 0", int(AudioHandler.min_elapased), ":0", int(AudioHandler.sec_elapased), ":0", int(AudioHandler.ms_elapased))
			else:
				time.text = str("Time: 0", int(AudioHandler.min_elapased), ":0", int(AudioHandler.sec_elapased), ":", int(AudioHandler.ms_elapased))


func _on_home_protal_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().call_group("kill_me", "queue_free")
		AudioHandler.nightmare.stop()
		AudioHandler.play_bg_music()
		get_tree().call_deferred("change_scene_to_file", "res://control.tscn")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if panel.visible == false:
			panel.visible = true
			get_tree().paused = true


func _on_resume_pressed() -> void:
	get_tree().paused = false
	panel.visible = false

func _on_restart_pressed() -> void:
	get_tree().paused = false
	panel.visible = false
	get_tree().call_group("kill_me", "queue_free")
	AudioHandler.nightmare.stop()
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
	if AudioHandler.slow == true:
		if AudioHandler.snail == true:
			AudioHandler.SPEED = 250
		else:
			AudioHandler.SPEED = 750
	elif AudioHandler.snail == true:
		AudioHandler.SPEED = 500
	else:
		AudioHandler.SPEED = 1000
	get_tree().reload_current_scene()

func _on_perish_pressed() -> void:
	get_tree().paused = false
	panel.visible = false
	get_tree().call_group("kill_me", "queue_free")
	AudioHandler.nightmare.stop()
	AudioHandler.play_bg_music()
	AudioHandler.play_death()
	get_tree().call_deferred("change_scene_to_file", "res://control.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
