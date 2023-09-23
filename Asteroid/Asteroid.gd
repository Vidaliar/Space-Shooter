extends CharacterBody2D

var initial_speed = 125.0


func _ready():
	velocity = Vector2(0,initial_speed*randf()).rotated(2*PI*randf()) 

func _physics_process(delta):
	
	move_and_slide()
	position.x = wrapf(position.x,0,1152)
	position.y = wrapf(position.y,0,648)
