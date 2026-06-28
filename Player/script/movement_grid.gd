
extends CharacterBody2D

const TILE_SIZE = 32          
const MOVE_DURATION = 0.5

var is_moving: bool = false

func _ready():
	position = position.snapped(Vector2(TILE_SIZE, TILE_SIZE))

func _process(_delta):
	if is_moving:
		return  
	var direction = Vector2.ZERO

	if Input.is_action_pressed("Right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("Left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("Up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("Down"):
		direction = Vector2.DOWN

	if direction != Vector2.ZERO:
		_move(direction)

func _move(dir: Vector2):
	var target_pos = position + dir * TILE_SIZE
	is_moving = true

	var tween = create_tween()
	tween.tween_property(self, "position", target_pos, MOVE_DURATION)
	tween.tween_callback(func(): is_moving = false)
