extends Control

@onready var fish_list = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_root().size_changed.connect(_on_window_resized)
	$RightWall.position.x = get_viewport_rect().size.x - 3
	spawn_fish()
	#spawn_fish()

func _on_window_resized() -> void:
	var new_size: Vector2i = get_viewport_rect().size
	print("Window new size: ", new_size)
	$RightWall.position.x = new_size.x - 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_fish():
	var DELETELATER = ["brook_trout", "flounder", "sunfish"]
	get_window()
	
	#fish_list.append(load("res://aquarium/aquarium_fish.tscn"))
	var fish = load("res://aquarium/aquarium_fish.tscn").instantiate()
	fish.position = Vector2(20, 20 )
	#spawnposition varied on y axis and confined to border on x axis
	#randomized speed
	
	fish.get_node("Sprite2D").texture = load("res://art/fish/" + DELETELATER[randi_range(0, 2)] + ".png")
	var sprite_size = fish.get_node("Sprite2D").get_rect().size
	fish.get_node("CollisionShape2D").shape.radius = sprite_size.y/2
	fish.get_node("CollisionShape2D").shape.height = sprite_size.x
	
	fish_list.append(fish)
	add_child(fish)
	
