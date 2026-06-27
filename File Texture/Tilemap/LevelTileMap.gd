class_name LevelTileMap extends TileMapLayer

func _ready() -> void:
	call_deferred("_init_bounds")

func _init_bounds() -> void:
	LevelManager.ChangeTilemapBounds(GetTilemapBounds())

func GetTilemapBounds() -> Array[Vector2]:
	var bounds: Array[Vector2] = []
	var tile_size = Vector2(tile_set.tile_size)
	
	bounds.append(Vector2(get_used_rect().position) * tile_size + global_position)
	bounds.append(Vector2(get_used_rect().end) * tile_size + global_position)
	
	return bounds
