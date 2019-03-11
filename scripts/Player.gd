extends KinematicBody2D

export(float) var speed = 100

var dir = Vector2()
var game_bounds

func _ready():
	if get_parent().game_bounds:
		game_bounds = get_parent().game_bounds
	else:
		game_bounds = Rect2(0, 0, 1000, 1000)

func _process(delta):
	# Input
	dir = Vector2()
	if Input.is_action_pressed("left"):
		dir.x += -1
	if Input.is_action_pressed("right"):
		dir.x += 1
	if Input.is_action_pressed("up"):
		dir.y += -1
	if Input.is_action_pressed("down"):
		dir.y += 1
	dir = dir.normalized()

	# Animation
	if dir.length() > 0:
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.play("idle")
	if dir.x < 0:
		$Sprite.flip_h = true
	elif dir.x > 0:
		$Sprite.flip_h = false
	
	# Z-index
	$Sprite.z_index = position.y
	

func _physics_process(delta):
	move_and_slide(dir*speed)
	position.x = clamp(position.x, game_bounds.position.x, game_bounds.end.x)
	position.y = clamp(position.y, game_bounds.position.y, game_bounds.end.y)