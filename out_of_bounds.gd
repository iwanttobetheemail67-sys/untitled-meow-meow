extends Node2D

@onready var panel: Sprite2D = $panels

var gold = 1

func _ready() -> void:
	get_tree().call_group("kill_me", "queue_free")
	gold = 1
	AudioHandler.nightmare.stop()
	AudioHandler.bg_music.stop()
	panel.visible = false
	$AudioStreamPlayer.play()
	if AudioHandler.dead == true:
		$death.visible = true
		AudioHandler.dead = false
		await get_tree().create_timer(0.5).timeout
	$death.visible = false
	if AudioHandler.hard_mode == false:
		$Super_hard_mode_spikes.queue_free()
	if AudioHandler.super_hard_mode == true:
		$"lower cam".rotation_degrees = 180
		$null_man/void.visible = true
	else:
		$"lower cam".rotation_degrees = 0
		$null_man/void.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "null_man":
		$death.visible = true
		AudioHandler.null_death_play()
		AudioHandler.dead = true
		get_tree().call_deferred("reload_current_scene")

func _on_poral_body_entered(body: Node2D) -> void:
	if body.name == "null_man":
		AudioHandler.score = randi_range(-99999, 9999999)
		if AudioHandler.hard_mode == true:
			AudioHandler.score += 99999
		AudioHandler.score = AudioHandler.score * gold
		if AudioHandler.super_hard_mode == true:
			AudioHandler.score = AudioHandler.score * 9
		get_tree().call_deferred("change_scene_to_file", "res://game_over.tscn")


func _on_timer_timeout() -> void:
	AudioHandler.ms_elapased = AudioHandler.ms_elapased + 1
	if AudioHandler.ms_elapased >= 100:
		AudioHandler.ms_elapased = 0
		AudioHandler.sec_elapased = AudioHandler.sec_elapased + 1
	if AudioHandler.sec_elapased >= 60:
		AudioHandler.sec_elapased = 0
		AudioHandler.min_elapased = AudioHandler.min_elapased + 1


func _on_upper_level_body_entered(body: Node2D) -> void:
	if body.name == "null_man":
		$"lower cam".enabled = false
		$null_man/void.visible = false
		$"lower cam".rotation_degrees = 0
		AudioHandler.seeing_it = true
		$"upper cam".enabled = true


func _on_upper_level_body_exited(body: Node2D) -> void:
	if body.name == "null_man":
			$"lower cam".enabled = true
			if AudioHandler.super_hard_mode == true:
				$null_man/void.visible = true
				$"lower cam".rotation_degrees = 180
			AudioHandler.seeing_it = false
			$"upper cam".enabled = false


func _on_goldfenm_body_entered(body: Node2D) -> void:
	if body.name == "null_man":
		gold += 1
		$golds/gold_1.queue_free()


func _on_goldfenm_2_body_entered(body: Node2D) -> void:
		if body.name == "null_man":
			gold += 1
			$golds/gold_2.queue_free()

func _on_goldfenm_3_body_entered(body: Node2D) -> void:
		if body.name == "null_man":
			gold += 1
			$golds/gold_3.queue_free()


func _on_ture_end_body_entered(body: Node2D) -> void:
	if body.name == "null_man":
		if gold == 4:
			get_tree().call_deferred("change_scene_to_file", "res://true_ending_all_gold.tscn")
		else:
			get_tree().call_deferred("change_scene_to_file", "res://true_ending.tscn")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if panel.visible == false:
			if AudioHandler.super_hard_mode == true:
				$"lower cam".rotation_degrees = 0
			panel.visible = true
			if AudioHandler.seeing_it == true:
				$panels/Sprite2D2.visible = false
			get_tree().paused = true


func _on_resume_pressed() -> void:
	if AudioHandler.super_hard_mode == true:
		$"lower cam".rotation_degrees = 180
	get_tree().paused = false
	panel.visible = false

func _on_restart_pressed() -> void:
	get_tree().paused = false
	panel.visible = false
	$death.visible = true
	AudioHandler.null_death_play()
	AudioHandler.dead = true
	get_tree().call_deferred("reload_current_scene")

func _on_perish_pressed() -> void:
	get_tree().paused = false
	panel.visible = false
	AudioHandler.score = -9999999
	if AudioHandler.hard_mode == true:
		AudioHandler.score += 10000000
	AudioHandler.score = AudioHandler.score * gold
	if AudioHandler.super_hard_mode == true:
		AudioHandler.score += gold
		AudioHandler.score = AudioHandler.score ** 9
	get_tree().call_deferred("change_scene_to_file", "res://game_over.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
