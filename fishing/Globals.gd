extends Node2D

@export var saving = false

# "name": [regular, gold, shiny]
#@onready var inventory_fish = {
	#
#}
@onready var inventory_fish = { "seaweed": [2, 0, 0], "humuhumunukunukuapua\'a": [2, 0, 0], "spotted_eagle_ray": [1, 0, 0], "brook_trout": [2, 0, 0], "deep_sea_isopod": [1, 0, 0], "horseshoe_crab": [2, 0, 0], "regal_blue_tang": [3, 0, 0], "sunfish": [3, 0, 0], "butterfish": [1, 0, 0] }

 
@onready var timer_settings = {"study": 25, "short_break": 5, "long_break":15}

@onready var window_size: Vector2i = Vector2i(640, 640)

signal any_key_pressed

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		any_key_pressed.emit()



@onready var fishing_streak = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

signal fish_caught(fish_name: String, is_new: bool)

func caught_fish(fish: String, new_fish: bool):
	if new_fish:
		inventory_fish[fish] = [1, 0, 0]
		
	else:
		inventory_fish[fish][0] += 1 
	
	fishing_streak += 1

	print(inventory_fish)
	fish_caught.emit(fish, new_fish)

	
	
