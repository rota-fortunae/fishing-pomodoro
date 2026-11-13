extends Node


var directions = {1: "up", 2: "down", 3: "right", 4: "left"}
@onready var new_fish_display = $FishDisplay
var fisher_location = Vector2(32, 72)
var fishing = false
var sprite_list = []
var arrow_list = []
var fish_difficulty = 10

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	if fishing:
		go_fishing()
		
	if not fishing && Input.is_action_just_pressed("up"):
		fishing = true
		start_fishing()
		
	
func start_fishing():
	arrow_list = []
	sprite_list = []
	
	fish_difficulty = randi_range(2, 10)
	
	for i in range(fish_difficulty):
		arrow_list.append(directions[randi_range(1, 4)])
	print(arrow_list)
	
	for arrow_index in range(arrow_list.size()):
		var new_sprite = Sprite2D.new()
		sprite_list.append(new_sprite)
		$ArrowLayer.add_child(new_sprite)
		
		new_sprite.texture = load("res://art/" + arrow_list[arrow_index] + "_arrow.png")
		new_sprite.position = fisher_location + Vector2(18 * (arrow_index + 1), 0)
		new_sprite.visible = true
		new_sprite.z_as_relative = 0

func go_fishing():
	if arrow_list.size() > 0:
		var pressed = ""
		if Input.is_action_just_pressed("up"): pressed = "up"
		elif Input.is_action_just_pressed("down"): pressed = "down"
		elif Input.is_action_just_pressed("left"): pressed = "left"
		elif Input.is_action_just_pressed("right"): pressed = "right"
			
		if pressed != "":
			if arrow_list[0] == pressed:
				$AudioStreamPlayer.stream=load("res://art/ding.mp3")
				$AudioStreamPlayer.play()
				arrow_list.pop_at(0)
				var correct_sprite = sprite_list.pop_at(0)
				correct_sprite.queue_free()
				
				if sprite_list.size() > 0:
					var tween = create_tween().set_parallel(true)
					for i in range(sprite_list.size()):
						tween.tween_property(sprite_list[i], "position", sprite_list[i].position - Vector2(18, 0), 0.15).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			else: #failed game
				$AudioStreamPlayer.stream=load("res://art/fail.mp3")
				$AudioStreamPlayer.play()
				Globals.fishing_streak = 0
				fishing = false
				for i in range (len(arrow_list)):
					arrow_list.pop_at(0)
					sprite_list.pop_at(0).queue_free()

	elif arrow_list.size() == 0: # won game
		
		fishing = false
		var newfish = select_fish(fish_difficulty)
		
		Globals.caught_fish(newfish, (newfish not in Globals.inventory_fish.keys()))
		

func select_fish(difficulty):
	var trash = ["seaweed"]
	var basic = ["butterfish", "brook_trout", "coral_trout", "regal_blue_tang", "flounder", "koi"]
	var uncommon = ["moon_jellyfish", "horseshoe_crab", "humuhumunukunukuapua'a", "spotted_eagle_ray", "sockeye_salmon"]
	var legendary = ["leafy_seadragon", "deep_sea_isopod", "sunfish"]
	
	if difficulty < 8:
		if randi_range(1,10) == 5:
			return trash[randi_range(0,trash.size()-1)]
		else:
			if difficulty < 6:
				return basic[randi_range(0, basic.size()-1)]
			else:
				return uncommon[randi_range(0, uncommon.size()-1)]
	else:
		if randi_range(1,20) == 20:
			return trash[randi_range(0,trash.size()-1)]
		else:
			return legendary[randi_range(0, legendary.size()-1)]
