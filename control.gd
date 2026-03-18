extends Node

var meow = 1

func _ready() -> void:
	AudioHandler.play_bg_music()
	$eyes.visible = false
	$"cookie 1".visible = false
	$"cookie 2".visible = false
	$"cookie 3".visible = false
	$"Game Won".visible = false
	if AudioHandler.cookie_1 == true:
		$"cookie 1".visible = true
	if AudioHandler.cookie_2 == true:
		$"cookie 2".visible = true
	if AudioHandler.cookie_3 == true:
		$"cookie 3".visible = true
	if AudioHandler.true_end == true:
		$"Game Won".visible = true
	
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
	AudioHandler.health = 3
	if AudioHandler.frail == true:
		AudioHandler.health = 1
	if AudioHandler.hard_mode == true:
		get_tree().call_deferred("change_scene_to_file", "res://true_nightmare_start.tscn")
	else:
		get_tree().call_deferred("change_scene_to_file", "res://Untitled_Meow_Meow.tscn")
	
func _on_button_3_pressed() -> void:
	get_tree().quit()
	
func _on_button_2_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://settings.tscn")
	

func _on_button_4_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://tutorial_world.tscn")


func _on_button_5_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://credits.tscn")


func _on_timer_timeout() -> void:
	meow = randi_range(1, 100)
	if meow == 12:
		$eyes.visible = true
		AudioHandler.null_death_play()
		await get_tree().create_timer(0.25).timeout
		$eyes.visible = false
