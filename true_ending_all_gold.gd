extends Node2D

func _ready() -> void:
	if AudioHandler.super_hard_mode == true:
		$"ColorRect/all challenges cookie".visible = true
		$"ColorRect/all challengez".visible = true
		$"ColorRect/hard mode".visible = true
		$"ColorRect/hard cookie". visible = true
	elif AudioHandler.hard_mode == true:
		$"ColorRect/hard mode".visible = true
		$"ColorRect/hard cookie". visible = true
		$"ColorRect/all challenges cookie".visible = false
		$"ColorRect/all challengez".visible = false
		$ColorRect/Sprite2D2.position = Vector2(414, 530)
		$"ColorRect/hard cookie".position = Vector2(714, 530)
	else:
		$"ColorRect/all challenges cookie".visible = false
		$"ColorRect/all challengez".visible = false
		$"ColorRect/hard mode".visible = false
		$"ColorRect/hard cookie". visible = false


func _on_button_pressed() -> void:
	AudioHandler.game_won = true
	if AudioHandler.super_hard_mode == true:
		AudioHandler.victory_3 = true
		AudioHandler.score = "∞²"
		AudioHandler.final_score = "∞²"
		AudioHandler.cookie_3 = true
		AudioHandler.true_end = true
	elif AudioHandler.hard_mode == true:
		AudioHandler.cookie_2 = true
		AudioHandler.victory_2 = true
		AudioHandler.score = "∞"
		if AudioHandler.final_score != "∞²":
			AudioHandler.final_score = "∞"
	else:
		AudioHandler.cookie_1 = true
		AudioHandler.victory = true
		AudioHandler.score = "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"
		if AudioHandler.final_score != "∞²":
			if AudioHandler.final_score != "∞":
				AudioHandler.final_score = "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"
	get_tree().call_deferred("change_scene_to_file", "res://game_over.tscn")
