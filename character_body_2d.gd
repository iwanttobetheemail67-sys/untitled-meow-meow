extends CharacterBody2D


const JUMP_VELOCITY = -800.0

@onready var object = CharacterBody2D


var current_fast = false
var current_slow = false
var current_fish = false
var current_froze = false
var fish_freeze = false
var hurt = false
var upside_down = false
var teleported = false
var x_pos = 0
var y_pos = 0


func _ready() -> void:
	$Camera2D.rotation = 0

func _process(_delta: float) -> void:
	if AudioHandler.fast_mode == true:
		if current_fast == false:
			current_fast = true
			await get_tree().create_timer(5.0).timeout
			current_fast = false
			AudioHandler.fast_mode = false
	if AudioHandler.slow_mode == true:
		if current_slow == false:
			current_slow = true
			await get_tree().create_timer(5.0).timeout
			current_slow = false
			AudioHandler.slow_mode = false
	if AudioHandler.fish_mode == true:
		if current_fish == false:
			current_fish = true
			await get_tree().create_timer(3.0).timeout
			current_fish = false
			AudioHandler.fish_mode = false
	if AudioHandler.score_freeze == true:
		if current_froze == false:
			current_froze = true
			$Camera2D/scaling_spirt/poisin.visible = true
			await get_tree().create_timer(5.0).timeout
			current_froze = false
			$Camera2D/scaling_spirt/poisin.visible = false
			AudioHandler.score_freeze = false
	if AudioHandler.freeze == true:
		if fish_freeze == false:
			fish_freeze = true
			$Camera2D/scaling_spirt/froze.visible = true
			await get_tree().create_timer(5.0).timeout
			$Camera2D/scaling_spirt/froze.visible = false
			fish_freeze = false
			AudioHandler.freeze = false
	if AudioHandler.hurt == true:
		if hurt == false:
			hurt = true
			$Camera2D/scaling_spirt/hurt_box.visible = true
			await get_tree().create_timer(0.1).timeout
			hurt = false
			$Camera2D/scaling_spirt/hurt_box.visible = false
			AudioHandler.hurt = false
	if AudioHandler.upside_down == true:
		if upside_down == false:
			upside_down = true
			$Camera2D.rotate(deg_to_rad(180))
			upside_down = false
			AudioHandler.upside_down = false
	if AudioHandler.teleport == true:
		if teleported == false:
			teleported = true
			x_pos = randi_range(-5000, 5000)
			y_pos = randi_range(-2000, 0)
			global_position = Vector2(x_pos, y_pos)
			global_position = Vector2(x_pos, y_pos)
			global_position = Vector2(x_pos, y_pos)
			teleported = false
			AudioHandler.teleport = false
	if abs(global_position.x) > 20000:
		get_tree().call_deferred("change_scene_to_file", "res://out_of_bounds.tscn")

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	
	if direction == -1:
		$AnimatedSprite2D.frame = 0
	elif direction == 1:
		$AnimatedSprite2D.frame = 1
	
	if AudioHandler.freeze == true:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction:
		if AudioHandler.fast_mode == true:
			velocity.x = direction * AudioHandler.SPEED * 2
			if AudioHandler.slow_mode == true:
				velocity.x = direction * AudioHandler.SPEED
		elif AudioHandler.slow_mode == true:
			velocity.x = direction * AudioHandler.SPEED / 2
		else:
			velocity.x = direction * AudioHandler.SPEED
	else:
		if AudioHandler.fast_mode == true:
			velocity.x = move_toward(velocity.x, 0, AudioHandler.SPEED * 2)
			if AudioHandler.slow_mode == true:
				velocity.x = move_toward(velocity.x, 0, AudioHandler.SPEED)
		elif AudioHandler.slow_mode == true:
			@warning_ignore("integer_division")
			velocity.x = move_toward(velocity.x, 0, AudioHandler.SPEED / 2)
		else:
			velocity.x = move_toward(velocity.x, 0, AudioHandler.SPEED)
		
	
		
	move_and_slide()
