extends Node2D

func _ready() -> void:
	if AudioHandler.super_hard_mode == true:
		$"ColorRect/hard cookie".visible = true
		$ColorRect/super_cookie.visible = true
		$ColorRect/hard.visible = true
		$ColorRect/super_hard. visible = true
	elif AudioHandler.hard_mode == true:
		$"ColorRect/hard cookie".visible = true
		$ColorRect/hard. visible = true
		$ColorRect/super_hard.visible = false
		$ColorRect/super_cookie.visible = false
		$"ColorRect/hard cookie".position = Vector2(550, 525)
	else:
		$"ColorRect/hard cookie".visible = false
		$ColorRect/super_cookie.visible = false
		$ColorRect/hard.visible = false
		$ColorRect/super_hard. visible = false

func _on_button_pressed() -> void:
	AudioHandler.score = 9999999999
	if AudioHandler.hard_mode == true:
		AudioHandler.score = 9999999999999
		AudioHandler.cookie_2 = true
	if AudioHandler.super_hard_mode == true:
		AudioHandler.cookie_3 = true
		AudioHandler.score = 9223372036854775806
	get_tree().call_deferred("change_scene_to_file", "res://game_over.tscn")
