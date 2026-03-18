extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.frame = 1
	if AudioHandler.blind == true:
		if AudioHandler.super_gravity == true:
			if AudioHandler.hyper == true:
				if AudioHandler.snail == true:
						AudioHandler.super_hard_mode = true
						$AnimatedSprite2D.frame = 0

func _on_timer_timeout() -> void:
	AudioHandler.nightmare.stop()
	AudioHandler.bg_music.stop()
	AudioHandler.play_nightmare()
	get_tree().call_deferred("change_scene_to_file", "res://Untitled_Meow_Meow.tscn")
