extends CharacterBody2D

var speed = 1
var max_speed = 100
var rotate_speed = 0.03

func _init():
	pass
func _process(delta):
	pass
func _physics_process(delta):
	if Input.is_action_pressed("Rotate Left"):
		rotation = rotation - rotate_speed
	if Input.is_action_pressed("Rotate Right"):
		rotation = rotation + rotate_speed
	if Input.is_action_pressed("Forward"):
		velocity = velocity + Vector2(0,-speed).rotated(rotation)
	if Input.is_action_pressed("Backward"):
		velocity = velocity + Vector2(0,speed).rotated(rotation)
	if Input.is_action_pressed("Left"):
		velocity = velocity + Vector2(-speed,0).rotated(rotation)
	if Input.is_action_pressed("Right"):
		velocity = velocity + Vector2(speed,0).rotated(rotation)
	
	position.x = wrapf(position.x, 0 , 1152)
	position.y = wrapf(position.y,0,648) 
	velocity = velocity.normalized() * clamp(velocity.length(),0,max_speed)
	#if position.x > 1152:
	#	position.x = 0
	#if position.x < 0:
	#	position.x = 1152
	#if position.y > 648:
	#	position.y = 0
	#if position.y < 0:
	#	position.y = 648
		
	move_and_slide()
