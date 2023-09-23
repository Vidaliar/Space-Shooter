extends CharacterBody2D

var speed = 3.0
var max_speed = 500
var rotate_speed = 0.03
var nose = Vector2(0,-60)
var Bullet = load("res://Player/bullet.tscn")

func _init():
	pass
func _process(delta):
	pass
func _physics_process(delta):
	velocity += get_input() * speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	position.x = wrapf(position.x, 0 , 1152)
	position.y = wrapf(position.y,0,648) 
	move_and_slide()
	if Input.is_action_pressed("Fire"):
		var Effects = get_node_or_null("/root/Game/Effects")
		var bullet = Bullet.instantiate()
		bullet.global_position = global_position + nose.rotated(rotation)
		bullet.rotation = rotation
		if Effects != null:
			Effects.add_child(bullet)

func get_input():
	var to_return = Vector2.ZERO
	$Exhaust.hide()
	if Input.is_action_pressed("Forward"):
		to_return += Vector2(0,-1)
		$Exhaust.show()
	if Input.is_action_pressed("Rotate Left"):
		rotation -= rotate_speed
	if Input.is_action_pressed("Rotate Right"):
		rotation += rotate_speed
	if Input.is_action_pressed("Backward"):
		velocity = velocity + Vector2(0,speed).rotated(rotation)
	if Input.is_action_pressed("Left"):
		velocity = velocity + Vector2(-speed,0).rotated(rotation)
	if Input.is_action_pressed("Right"):
		velocity = velocity + Vector2(speed,0).rotated(rotation)
	return to_return.rotated(rotation) 
