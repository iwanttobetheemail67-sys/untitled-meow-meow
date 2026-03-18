extends Node


func _ready():
	AudioHandler.play_bg_music()
	get_tree().call_deferred("change_scene_to_file", "res://control.tscn")
	
