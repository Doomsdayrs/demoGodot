extends KinematicBody2D

const PLAYERSPEED:int = 200
const GRAVITY:int = 50
const UPHEIGHT:int = 1000

const UP:Vector2 = Vector2(0,-1)
var motion:Vector2 = Vector2()

var doubleJumpCount:int = 0
var cooldown:int = 0

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = PLAYERSPEED
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -PLAYERSPEED
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		motion.x = 0
	jump()
	
	if !is_on_floor():
		$Sprite.play("Jump")
		
	if (!Input.is_action_pressed("ui_left")&&!Input.is_action_pressed("ui_right")&&(!Input.is_action_pressed("ui_up") || is_on_floor())&&is_on_floor()):
		$Sprite.play("Idle")
		
	motion = move_and_slide(motion, UP)
	pass
	
	
func jump():
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -UPHEIGHT
			$Sprite.play("Jump")
			
		if (cooldown < 0):
			cooldown=+1
			if cooldown == 1:
				cooldown = 0
	else:
		if Input.is_action_just_pressed("ui_up"):
			if (cooldown == 0):
				if doubleJumpCount < 2:
					doubleJumpCount+=1
					motion.y = -(PLAYERSPEED*4)
				else:
					cooldown = -200
					doubleJumpCount = 0
	pass