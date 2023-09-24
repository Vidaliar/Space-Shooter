extends Node2D

var Enemy = load("res://Enemy/enemy.tscn")

func _physics_process(_delta):
	if get_child_count() == 0:
		var enemy = Enemy.instantiate()
		enemy.position = Vector2(-200, -324)
		add_child(enemy)
