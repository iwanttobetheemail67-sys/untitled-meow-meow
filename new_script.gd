extends Sprite2D

func turn(Input):
	if Input.is("left"):
		$Sprite2D.hframes = 0
		$Sprite2D.vframes = 0
	if Input.is("right"):
		$Sprite2D.hframes = 1
		$Sprite2D.vframes = 1
	
