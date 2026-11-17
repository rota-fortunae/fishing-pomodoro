extends Control

@onready var fish_list = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_root().size_changed.connect(_on_window_resized)
	$RightWall.position.x = get_viewport_rect().size.x - 3
	print("wallpos = "+ str(get_viewport_rect().size.x - 3))
	spawn_one_fish("brook_trout")
	spawn_one_fish("sunfish")
	

func _on_window_resized() -> void:
	var new_size: Vector2i = get_viewport_rect().size
	$RightWall.position.x = new_size.x - 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func get_random_fish():
	
	
func spawn_one_fish(fish_name : String):
	var window = get_viewport_rect().size
	var fish = load("res://aquarium/aquarium_fish.tscn").instantiate()
	
	
	fish.get_node("Sprite2D").texture = load("res://art/fish/" + fish_name + ".png")
	var sprite_size = fish.get_node("Sprite2D").get_rect().size
	
	fish.visible = true

	#spawnposition varied on y axis and confined to border on right x axis
	fish.position = Vector2(window.x - 4 - sprite_size.x, randi_range(6 + sprite_size.y, window.y - sprite_size.y - 13))
	print(str(fish.position) + "is the position of the fish ") 
	
	#randomized speed (varies in 20% in either direction)
	fish.speed = randi_range(Globals.fish_speed - int(Globals.fish_speed /5), Globals.fish_speed + int(Globals.fish_speed /5))
	
	fish.get_node("CollisionShape2D").shape.size = sprite_size
	
	fish_list.append(fish)
	add_child(fish)
	
	
	
