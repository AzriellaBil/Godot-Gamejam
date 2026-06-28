extends Node

const SAVE_PATH =  "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	player = {
		money = 100,
		pos_x = 0,
		pos_y = 0,
		robot = ""
	},
	
	item = {},
	craft_unlock = [],
	quest = [],
}

func save_game() -> void:
	update_player_data()
	var file := FileAccess.open( SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify( current_save)
	file.store_line( save_json )
	game_saved.emit()
	pass
	
func load_game() -> void:
	var file := FileAccess.open( SAVE_PATH + "save.sav", FileAccess.READ )
	var json := JSON.new()
	json.parse( file.get_line() )
	var save_dict : Dictionary = json.get_data() as Dictionary
	current_save = save_dict
	
	
	GlobalPlayerManager.set_player_position( Vector2(current_save.player.pos_x , current_save.player.pos_y ))
	
	game_loaded.emit()
	
	pass
	
	
func update_player_data() -> void:
	var p : Player = GlobalPlayerManager.player
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y
	pass
	
func update_scene_path() -> void:
	var p : String = ""
	for c in get_tree().root.get_children():
		#if c is Level:
		pass
			
