extends KinematicBody2D

export(float) var speed = 100

var dir = Vector2()
var golden_knife

func _ready():
	golden_knife = get_node("../GoldenKnife")

func _process(delta):
	dir = (golden_knife.position - position).normalized()

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