extends Control

func _ready() -> void:
	AudioHandler.nightmare.stop()
	AudioHandler.bg_music.stop()
	$AudioStreamPlayer.play()

func _physics_process(delta: float) -> void:
	$ColorRect.position.y += delta * 175
	if $ColorRect.position.y >= 0:
		$AudioStreamPlayer.stop()
		get_tree().call_deferred("change_scene_to_file", "res://control.tscn")


func _on_button_pressed() -> void:
	$AudioStreamPlayer.stop()
	get_tree().call_deferred("change_scene_to_file", "res://control.tscn")
