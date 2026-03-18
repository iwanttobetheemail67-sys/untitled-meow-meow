extends Node2D

func _ready():
	if AudioHandler.hitboxes == true:
		$ColorRect.visible = true

func _physics_process(delta: float) -> void:
	if AudioHandler.fish_mode == true:
		return
	position.y += delta * AudioHandler.difficulty
	if position.y >= 5000:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()
	if body.name == "Player":
		AudioHandler.fish_mode = true
