extends Control

@onready var current_fish_list = []
@onready var possible_fish_list = []
@onready var fish_nodes = []
@onready var inventory_fish = Globals.inventory_fish

func flatten_fish():
	for i in inventory_fish.keys():
		
		for j in 3:
			for x in range(int(inventory_fish[i][j])):
				possible_fish_list.append([i, j])
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_viewport_rect().size.x*get_viewport_rect().size.y)
	get_tree().get_root().size_changed.connect(_on_window_resized)
	$RightWall.position.x = get_viewport_rect().size.x - 3
	print("wallpos = "+ str(get_viewport_rect().size.x - 3))
	flatten_fish()
	
	spawn_one_fish(get_random_fish())
	#spawn_one_fish(get_random_fish())
	#spawn_one_fish(get_random_fish())
	#spawn_one_fish(get_random_fish())
	#spawn_one_fish(get_random_fish())
	#spawn_one_fish(get_random_fish())
	

func _on_window_resized() -> void:
	var new_size: Vector2i = get_viewport_rect().size
	$RightWall.position.x = new_size.x - 3
	
	if len(current_fish_list) * 5500 > new_size.x*new_size.y:
		despawn_one_fish()
		print("too small")
	elif len(current_fish_list) * 5000 > new_size.x*new_size.y:
		print("to big!")
		spawn_one_fish(get_random_fish())
	else:
		print(new_size.x*new_size.y)
		print(len(current_fish_list))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_random_fish():
	var index = randi_range(0, len(possible_fish_list)-1)
	#remember that this doesn't return information about shiny types!
	
	var f = possible_fish_list[index]
	print(f)
	possible_fish_list.pop_at(index)
	current_fish_list.append([f])
	return f[0]
	
	
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
	
	fish.name = fish_name
	
	fish_nodes.append(fish)
	add_child(fish)
	
func despawn_one_fish():
	var farthest_fish = current_fish_list[0].x
	var ind = 0
	for i in current_fish_list:
		if current_fish_list[i].position.x > farthest_fish:
			ind = i 
			farthest_fish = current_fish_list[i].position.x
	
	possible_fish_list.append(current_fish_list[ind].name) 
	current_fish_list.pop_at(ind).queue_free()
	

	
