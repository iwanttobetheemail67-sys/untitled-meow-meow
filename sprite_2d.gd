extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

func _process(_delta):
	if Input.is_action_pressed("left"):
		_animated_sprite.play("look_left")
	elif Input.is_action_pressed("right"):
		_animated_sprite.play("look_right")
