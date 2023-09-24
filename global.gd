extends Node


func _ready():
	randomize()

func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	
