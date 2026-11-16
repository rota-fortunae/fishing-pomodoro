extends Control

@onready var fish_list = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#spawn_fish()
	#spawn_fish()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_fish():
	var DELETELATER = ["brook_trout", "flounder", "sunfish"]
	get_window()
	
	fish_list.append(Sprite2D.new())
	fish_list[-1].position = Vector2(20, 20 )
	fish_list[-1].texture = load("res://art/fish/" + DELETELATER[randi_range(0, 2)] + ".png")
	add_child(fish_list[-1])
	
