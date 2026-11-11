extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.fish_caught.connect(_on_fish_caught)

func _on_fish_caught(fish: String, new_fish: bool) -> void:
	$FishedScreen.visible = true
	$Surprise.visible = true
	print("IM MAKING IT VISIBLE AHHHH ")
	$Surprise/NewSticker.visible = new_fish
	$Surprise/FishSprite.texture = load("res://art/fish/" + fish + ".png")
	$Surprise/FishName.text = fish.replace("_", " ")

	await Globals.any_key_pressed
	print("keypressed")
	
	$FishedScreen.visible = false
	$Surprise.visible = false
	
