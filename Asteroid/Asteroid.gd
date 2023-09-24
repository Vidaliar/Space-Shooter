extends CharacterBody2D

var initial_speed = 125.0
var health = 100

func _ready():
	velocity = Vector2(0,initial_speed*randf()).rotated(2*PI*randf()) 

func _physics_process(delta):
	
	move_and_slide()
	position.x = wrapf(position.x,0,Global.VP.x)
	position.y = wrapf(position.y,0,Global.VP.y)
func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(1)
		queue_free()
