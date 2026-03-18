extends Control

var temp_evil_value = 0

func _ready():
	if AudioHandler.hitboxes == true:
		$ColorRect/hitboxes.button_pressed = true
	if AudioHandler.no_death_skulls == true:
		$ColorRect/death_skulls.button_pressed = true
	if AudioHandler.diff_cheat == true:
		$ColorRect/diff.set_value_no_signal(AudioHandler.cheat_diff)
		$"ColorRect/diff/diff off/AnimatedSprite2D".frame = 1
	else:
		$ColorRect/diff.set_value_no_signal(AudioHandler.difficulty)
		$"ColorRect/diff/diff off/AnimatedSprite2D".frame = 0
	if AudioHandler.mult_cheat == true:
		$"ColorRect/score mult".set_value_no_signal(AudioHandler.cheat_mult)
		$"ColorRect/score mult/mult off/AnimatedSprite2D".frame = 1
	else:
		$"ColorRect/score mult".set_value_no_signal(AudioHandler.challenge_mult)
		$"ColorRect/score mult/mult off/AnimatedSprite2D".frame = 0
	if AudioHandler.health_cheat == true:
		$ColorRect/health.set_value_no_signal(AudioHandler.cheat_health)
		$"ColorRect/health/health off/AnimatedSprite2D".frame = 1
	else:
		$ColorRect/health.set_value_no_signal(AudioHandler.health)
		$"ColorRect/health/health off/AnimatedSprite2D".frame = 0
	if AudioHandler.speed_cheat == true:
		$ColorRect/speed.set_value_no_signal(AudioHandler.cheat_speed)
		$"ColorRect/speed/speed off/AnimatedSprite2D".frame = 1
	else:
		$ColorRect/speed.set_value_no_signal(AudioHandler.SPEED)
		$"ColorRect/speed/speed off/AnimatedSprite2D".frame = 0
	if AudioHandler.zoom_cheat == true:
		$ColorRect/zoom.set_value_no_signal(AudioHandler.cheat_zoom)
		$"ColorRect/zoom/zoom off/AnimatedSprite2D".frame = 1
	else:
		$ColorRect/zoom.set_value_no_signal(0.5)
		$"ColorRect/zoom/zoom off/AnimatedSprite2D".frame = 0
	if AudioHandler.evil_cheat == true:
		if AudioHandler.evil_chance != AudioHandler.cheat_evil:
			$"ColorRect/evil chance".set_value_no_signal(AudioHandler.cheat_evil)
			$"ColorRect/evil chance/evil off/AnimatedSprite2D".frame = 1
		else:
			$"ColorRect/evil chance".set_value_no_signal(AudioHandler.evil_chance)
			$"ColorRect/evil chance/evil off/AnimatedSprite2D".frame = 0
	else:
		$"ColorRect/evil chance".set_value_no_signal(AudioHandler.evil_chance)
		$"ColorRect/evil chance/evil off/AnimatedSprite2D".frame = 0
	if AudioHandler.spawn_cheat == true:
		$"ColorRect/spawn rate".set_value_no_signal(AudioHandler.cheat_spawn)
		$"ColorRect/spawn rate/AnimatedSprite2D".frame = 1
	else:
		$"ColorRect/spawn rate".set_value_no_signal(0.5)
		$"ColorRect/spawn rate/AnimatedSprite2D".frame = 0
	if AudioHandler.amount_cheat == true:
		$"ColorRect/spawn amount".set_value_no_signal(AudioHandler.cheat_amount)
		$"ColorRect/spawn amount/amount off/AnimatedSprite2D".frame = 1
	else:
		$"ColorRect/spawn amount".set_value_no_signal(AudioHandler.spawn_rate)
		$"ColorRect/spawn amount/amount off/AnimatedSprite2D".frame = 0

func _process(_delta: float) -> void:
	if AudioHandler.cheat_amount >= 25:
		$"ColorRect/spawn amount/Label".visible = true
	if AudioHandler.cheat_amount < 25:
		$"ColorRect/spawn amount/Label".visible = false

func _on_button_3_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://challenges.tscn")

func _on_diff_value_changed(value: float) -> void:
	AudioHandler.cheat_diff = value
	AudioHandler.diff_cheat = true
	if value == AudioHandler.difficulty:
		$"ColorRect/diff/diff off/AnimatedSprite2D".frame = 0
		AudioHandler.diff_cheat = false
	else:
		$"ColorRect/diff/diff off/AnimatedSprite2D".frame = 1

func _on_score_mult_value_changed(value: float) -> void:
	AudioHandler.cheat_mult = value
	AudioHandler.mult_cheat = true
	if value == AudioHandler.challenge_mult:
		$"ColorRect/score mult/mult off/AnimatedSprite2D".frame = 0
		AudioHandler.mult_cheat = false
	else:
		$"ColorRect/score mult/mult off/AnimatedSprite2D".frame = 1

func _on_health_value_changed(value: float) -> void:
	AudioHandler.cheat_health = value
	AudioHandler.health_cheat = true
	if value == AudioHandler.health:
		$"ColorRect/health/health off/AnimatedSprite2D".frame = 0
		AudioHandler.health_cheat = false
	else:
		$"ColorRect/health/health off/AnimatedSprite2D".frame = 1

func _on_speed_value_changed(value: float) -> void:
	AudioHandler.cheat_speed = value
	AudioHandler.speed_cheat = true
	if value == AudioHandler.SPEED:
		$"ColorRect/speed/speed off/AnimatedSprite2D".frame = 0
		AudioHandler.speed_cheat = false
	else:
		$"ColorRect/speed/speed off/AnimatedSprite2D".frame = 1
	
func _on_spawn_amount_value_changed(value: float) -> void:
	AudioHandler.cheat_amount = value
	AudioHandler.amount_cheat = true
	if value == AudioHandler.spawn_rate:
		$"ColorRect/spawn amount/amount off/AnimatedSprite2D".frame = 0
		AudioHandler.amount_cheat = false
	else:
		$"ColorRect/spawn amount/amount off/AnimatedSprite2D".frame = 1

func _on_zoom_drag_ended(_value_changed: bool) -> void:
	AudioHandler.cheat_zoom = $ColorRect/zoom.value
	AudioHandler.zoom_cheat = true
	if AudioHandler.cheat_zoom == 0.5:
		$"ColorRect/zoom/zoom off/AnimatedSprite2D".frame = 0
		AudioHandler.zoom_cheat = false
	else:
		$"ColorRect/zoom/zoom off/AnimatedSprite2D".frame = 1

func _on_spawn_rate_drag_ended(_value_changed: bool) -> void:
	AudioHandler.cheat_spawn = $"ColorRect/spawn rate".value
	AudioHandler.spawn_cheat = true
	if AudioHandler.cheat_spawn == 0.5:
		$"ColorRect/spawn rate/AnimatedSprite2D".frame = 0
		AudioHandler.spawn_cheat = false
	else:
		$"ColorRect/spawn rate/AnimatedSprite2D".frame = 1

func _on_evil_chance_drag_ended(_value_changed: bool) -> void:
	temp_evil_value = AudioHandler.cheat_evil
	AudioHandler.cheat_evil = $"ColorRect/evil chance".value
	AudioHandler.evil_cheat = true
	if AudioHandler.cheat_evil > 0 and AudioHandler.evil_drops == false:
		AudioHandler.evil_drops = true
		AudioHandler.evil_chance = 1
		AudioHandler.challenge_mult = AudioHandler.challenge_mult + 1
		$"ColorRect/score mult".set_value_no_signal(AudioHandler.challenge_mult)
	if AudioHandler.cheat_evil == 0:
		AudioHandler.evil_cheat = false
		AudioHandler.evil_chance = 0
		$"ColorRect/evil chance/evil off/AnimatedSprite2D".frame = 0
		AudioHandler.evil_drops = false
		if temp_evil_value != 0:
			AudioHandler.challenge_mult = AudioHandler.challenge_mult - 1
			if AudioHandler.challenge_mult > 50:
				AudioHandler.challenge_mult = AudioHandler.challenge_mult - 50
			if AudioHandler.challenge_mult == 50:
				AudioHandler.challenge_mult = 100
			$"ColorRect/score mult".set_value_no_signal(AudioHandler.challenge_mult)
			if AudioHandler.hard_mode == true:
				AudioHandler.hard_mode = false
				AudioHandler.challenge_mult = AudioHandler.challenge_mult - 5
				if AudioHandler.challenge_mult > 50:
					AudioHandler.challenge_mult = AudioHandler.challenge_mult - 50
				if AudioHandler.challenge_mult == 50:
					AudioHandler.challenge_mult = 100
				$"ColorRect/score mult".set_value_no_signal(AudioHandler.challenge_mult) 
	if AudioHandler.cheat_evil == AudioHandler.evil_chance:
		AudioHandler.evil_cheat = false
		$"ColorRect/evil chance/evil off/AnimatedSprite2D".frame = 0
	else:
		$"ColorRect/evil chance/evil off/AnimatedSprite2D".frame = 1

func _on_hitboxes_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.hitboxes = true
	if toggled_on == false:
		AudioHandler.hitboxes = false
		
func _on_death_skulls_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioHandler.no_death_skulls = true
	if toggled_on == false:
		AudioHandler.no_death_skulls = false

func _on_button_4_pressed() -> void:
	AudioHandler.health_cheat = false
	AudioHandler.cheat_health = AudioHandler.health
	AudioHandler.diff_cheat = false
	AudioHandler.cheat_diff = AudioHandler.difficulty
	AudioHandler.zoom_cheat = false
	AudioHandler.cheat_zoom = 0.5
	AudioHandler.mult_cheat = false
	AudioHandler.cheat_mult = AudioHandler.challenge_mult
	AudioHandler.spawn_cheat = false
	AudioHandler.cheat_spawn = 0.5
	AudioHandler.hitboxes = false
	AudioHandler.no_death_skulls = false
	AudioHandler.speed_cheat = false
	AudioHandler.cheat_speed = AudioHandler.SPEED
	AudioHandler.amount_cheat = false
	AudioHandler.cheat_amount = AudioHandler.spawn_rate
	AudioHandler.evil_cheat = false
	AudioHandler.cheat_evil = AudioHandler.evil_chance
	$ColorRect/diff.set_value_no_signal(AudioHandler.difficulty)
	$"ColorRect/score mult".set_value_no_signal(AudioHandler.challenge_mult)
	$ColorRect/health.set_value_no_signal(AudioHandler.health)
	$ColorRect/speed.set_value_no_signal(AudioHandler.SPEED)
	$"ColorRect/spawn amount".set_value_no_signal(AudioHandler.spawn_rate)
	$ColorRect/zoom.set_value_no_signal(0.5)
	$"ColorRect/spawn rate".set_value_no_signal(0.5)
	$"ColorRect/evil chance".set_value_no_signal(AudioHandler.evil_chance)
	$ColorRect/hitboxes.button_pressed = false
	$ColorRect/death_skulls.button_pressed = false
	$"ColorRect/diff/diff off/AnimatedSprite2D".frame = 0
	$"ColorRect/score mult/mult off/AnimatedSprite2D".frame = 0
	$"ColorRect/health/health off/AnimatedSprite2D".frame = 0
	$"ColorRect/speed/speed off/AnimatedSprite2D".frame = 0
	$"ColorRect/spawn amount/amount off/AnimatedSprite2D".frame = 0
	$"ColorRect/zoom/zoom off/AnimatedSprite2D".frame = 0
	$"ColorRect/spawn rate/AnimatedSprite2D".frame = 0
	$"ColorRect/evil chance/evil off/AnimatedSprite2D".frame = 0
	$"ColorRect/score mult".set_value_no_signal(AudioHandler.challenge_mult)

func _on_diff_off_pressed() -> void:
	AudioHandler.diff_cheat = false
	AudioHandler.cheat_diff = AudioHandler.difficulty
	$ColorRect/diff.set_value_no_signal(AudioHandler.difficulty)
	$"ColorRect/diff/diff off/AnimatedSprite2D".frame = 0

func _on_mult_off_pressed() -> void:
	AudioHandler.mult_cheat = false
	AudioHandler.cheat_mult = AudioHandler.challenge_mult
	$"ColorRect/score mult".set_value_no_signal(AudioHandler.challenge_mult)
	$"ColorRect/score mult/mult off/AnimatedSprite2D".frame = 0

func _on_health_off_pressed() -> void:
	AudioHandler.health_cheat = false
	AudioHandler.cheat_health = AudioHandler.health
	$ColorRect/health.set_value_no_signal(AudioHandler.health)
	$"ColorRect/health/health off/AnimatedSprite2D".frame = 0

func _on_speed_off_pressed() -> void:
	AudioHandler.speed_cheat = false
	AudioHandler.cheat_speed = AudioHandler.SPEED
	$ColorRect/speed.set_value_no_signal(AudioHandler.SPEED)
	$"ColorRect/speed/speed off/AnimatedSprite2D".frame = 0
	
func _on_amount_off_pressed() -> void:
	AudioHandler.amount_cheat = false
	AudioHandler.cheat_amount = AudioHandler.spawn_rate
	$"ColorRect/spawn amount".set_value_no_signal(AudioHandler.spawn_rate)
	$"ColorRect/spawn amount/amount off/AnimatedSprite2D".frame = 0

func _on_zoom_off_pressed() -> void:
	AudioHandler.zoom_cheat = false
	AudioHandler.cheat_zoom = 0.5
	$ColorRect/zoom.set_value_no_signal(0.5)
	$"ColorRect/zoom/zoom off/AnimatedSprite2D".frame = 0

func _on_spawn_rate_off_pressed() -> void:
	AudioHandler.spawn_cheat = false
	AudioHandler.cheat_spawn = 0.5
	$"ColorRect/spawn rate".set_value_no_signal(0.5)
	$"ColorRect/spawn rate/AnimatedSprite2D".frame = 0
	
func _on_evil_off_pressed() -> void:
	AudioHandler.evil_cheat = false
	AudioHandler.cheat_evil = AudioHandler.evil_chance
	$"ColorRect/evil chance".set_value_no_signal(AudioHandler.evil_chance)
	$"ColorRect/evil chance/evil off/AnimatedSprite2D".frame = 0
