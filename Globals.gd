extends Node2D

@export var saving = false

# "name": [regular, gold, shiny]
#@onready var inventory_fish = {
	#
#}
@onready var inventory_fish = { }
@onready var timer_settings = {"study": 25, "short_break": 5, "long_break":15}
@onready var window_size: Vector2i = Vector2i(640, 640)
@onready var fishing_streak = 0
@onready var fish_speed = 100

#could possibly add fish spawn frequency? 
#adjust spawn and despawn ratios in aquarium.gd

@onready var save_dict = {
	"inventory_fish": inventory_fish,
	"timer_settings": timer_settings,
	"window_size": window_size,
	"fishing_streak": fishing_streak,
	"fish_speed" : fish_speed
}

const SAVE_DIR = "user://save_data/"
const SAVE_PATH = "user://save_data/savegame.json"

signal any_key_pressed


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
		get_tree().quit() # default behavior

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		any_key_pressed.emit()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().set_auto_accept_quit(false)
	load_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func save_game() -> void:
	if not DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_dir_recursive_absolute(SAVE_DIR)

	var save_dict = {
		"inventory_fish": inventory_fish,
		"timer_settings": timer_settings,
		"window_size": {"x": window_size.x, "y": window_size.y},
		"fishing_streak": fishing_streak,
		"fish_speed" : fish_speed
	}

	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if save_file:
		save_file.store_line(JSON.stringify(save_dict))	

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var save_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not save_file:
		return

	var json_string = save_file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	print("loaded data:")
	print(json.data)

	if parse_result == OK and typeof(json.data) == TYPE_DICTIONARY:
		var saved_data = json.data
		
		inventory_fish = saved_data.get("inventory_fish", inventory_fish)
		timer_settings = saved_data.get("timer_settings", timer_settings)
		fishing_streak = int(saved_data.get("fishing_streak", fishing_streak))
		fish_speed = int(saved_data.get("fish_speed", fish_speed))
		
		if saved_data.has("window_size"):
			var ws = saved_data["window_size"]
			window_size = Vector2i(int(ws["x"]), int(ws["y"]))


signal fish_caught(fish_name: String, is_new: bool)

func caught_fish(fish: String, new_fish: bool):
	if new_fish:
		inventory_fish[fish] = [1, 0, 0]
		
	else:
		inventory_fish[fish][0] += 1 
	
	fishing_streak += 1

	print(inventory_fish)
	fish_caught.emit(fish, new_fish)

	
	
