extends CharacterBody2D

var speed = 2.0
var max_speed = 300
var rotate_speed = 0.03
var nose = Vector2(0,-60)
var Bullet = load("res://Player/bullet.tscn")
var Effects = null
var Explosion = load("res://Effects/explosion.tscn")
var health = 100

func _init():
	pass
func _process(delta):
	pass
func _physics_process(delta):
	velocity += get_input() * speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	position.x = wrapf(position.x, 0 , Global.VP.x)
	position.y = wrapf(position.y,0,Global.VP.y) 
	move_and_slide()
	if Input.is_action_just_pressed("Fire"):
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
	
func damage(d):
	health -= d
	if health <= 0:
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instantiate()
			Effects.add_child(explosion)
			explosion.global_position = global_position
			hide()
			await explosion.animation_finished
		Global.update_lives(-1)
		queue_free()

func _on_area_2d_body_entered(body):
	if body.name != "Player":
		damage(100)
