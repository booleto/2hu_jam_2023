extends HBoxContainer

@onready var frames: Array = [%UsesLeft] + %Frames.get_children()


func _process(_delta):
	%UsesLeft.text = str(PlayerData.uses_left)
	for i in range(PlayerData.fairies.size()):
		var texture: Texture2D
		match PlayerData.fairies[i]:
			PlayerData.FAIRIES.BAKA:
				texture = preload("res://Assets/Sprites/Fairies/Cirnoidle.png")
			PlayerData.FAIRIES.CLOWNPISS:
				texture = preload("res://Assets/Sprites/Fairies/Clownidle.png")
			PlayerData.FAIRIES.STAR:
				texture = preload("res://Assets/Sprites/Fairies/Staridle.png")
			PlayerData.FAIRIES.SUNNY:
				texture = preload("res://Assets/Sprites/Fairies/SunnyIdle.png")
			PlayerData.FAIRIES.LUNA:
				texture = preload("res://Assets/Sprites/Fairies/Lunaidle.png")
		frames[i].texture = texture
	
	for i in range(PlayerData.uses_left):
		frames[i].modulate = Color.WHITE
	for i in range(PlayerData.uses_left, 5):
		frames[i].modulate = Color.GRAY
