@tool 
class_name  LevelTransition extends Area2D

enum SIDE { Left, Right, Top, Bottom }

@export_file( "*.tscn" ) var level
@export var target_transition_area : String = "LevelTransition"

@export_category("Collision Area Settings")

@export_range(1,12,1, "or_greater") var size : int = 2 :
	set(_v):
		size = _v
		_update_area()

@export var side : SIDE = SIDE.Left :
	set(_v):
		side = _v
		_update_area()

@export var snap_to_grid : bool = false :
	set(_v):
		_snap_to_grid()

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_area()
	
	if Engine.is_editor_hint():
		return
		
	#monitoring = false
	
	body_entered.connect( _player_entered )


func _player_entered(_p : Node2D) -> void:
	LevelManager.load_new_level(level, target_transition_area, Vector2.ZERO)
	pass

func _place_player() -> void:
	if name != LevelManager.target_transition:
		return	
	GlobalPlayerManager.set_player_position( global_position + LevelManager.position_offset )
	
# func get_offset() -> Vector2:
	

func _update_area() -> void:
	var new_rect : Vector2 = Vector2(32,32) 
	var new_pos : Vector2 = Vector2.ZERO
	
	if side == SIDE.Top:
		new_rect.x *= size
		new_pos.y -= 16
	elif side == SIDE.Bottom:
		new_rect.x *= size
		new_pos.y += 16
	elif side == SIDE.Left:
		new_rect.y *= size
		new_pos.x -= 16
	elif side == SIDE.Right:
		new_rect.y *= size
		new_pos.x += 16
		
	if collision_shape == null:
		collision_shape = get_node("CollisionShape2D")
		
	collision_shape.shape.size = new_rect
	collision_shape.position = new_pos


func _snap_to_grid() -> void:
	position.x = round( position.x / 16 ) * 16
	position.y = round( position.y / 16 ) * 16
