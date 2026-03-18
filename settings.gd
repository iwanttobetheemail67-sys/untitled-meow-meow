extends Node

var Music = AudioServer.get_bus_index("Music")

func _ready():
	$ColorRect/HSlider.value = db_to_linear(AudioServer.get_bus_volume_db(Music))
	if AudioHandler.show_diff == true:
		$ColorRect/CheckButton2.button_pressed = true
	if AudioHandler.show_time == true:
		$ColorRect/CheckButton3.button_pressed = true

func _on_button_3_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://control.tscn")

func _on_h_slider_drag_ended(_value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(Music, linear_to_db($ColorRect/HSlider.value))


func _on_check_button_2_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.show_diff = true
	if toggled_on == false:
		AudioHandler.show_diff = false


func _on_button_4_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://challenges.tscn")


func _on_check_button_3_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.show_time = true
	if toggled_on == false:
		AudioHandler.show_time = false
