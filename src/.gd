extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var motion = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	motion.x += 10
	move_and_slide(motion)
	motion.x += 10
	move_and_slide(motion)
	motion.x += 10
	move_and_slide(motion)
	motion.x += 10
	move_and_slide(motion)
	motion.x -= 10
	move_and_slide(motion)
	motion.x -= 10
	move_and_slide(motion)
	motion.x -= 10
	move_and_slide(motion)
	motion.x -= 10
	move_and_slide(motion)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
