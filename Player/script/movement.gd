class_name Player extends CharacterBody2D

var move_speed : float = 70.0


func _physics_process( delta ):
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	velocity = (direction.normalized() * move_speed).round()
	move_and_slide()
