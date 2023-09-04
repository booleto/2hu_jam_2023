extends HBoxContainer

@onready var frames: Array = [%Selected] + %Frames.get_children()
var cd_tween: Tween

func _process(_delta):
	%UsesLeft.text = str(PlayerData.uses_left)
	var start = PlayerData.selected
	for i in range(PlayerData.fairies.size()):
		var texture: Texture2D
		match PlayerData.fairies[(start + i) % PlayerData.fairies.size()]:
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

	for i in range(PlayerData.fairies.size(), 5):
		frames[i].texture = null
	
	for i in range(min(PlayerData.uses_left, 5)):
		frames[i].modulate = Color.WHITE
	for i in range(min(PlayerData.uses_left, 5), 5):
		frames[i].modulate = Color.GRAY
	
	check_activate()

func check_activate():
	if PlayerData.fairy_active && cd_tween == null:
		cd_tween = create_tween()
		var tweener = cd_tween.tween_property(%Cooldown, "value", 0, PlayerData.cooldown_times[PlayerData.fairies[PlayerData.selected]]).from(100)
		await tweener.finished
		cd_tween.kill()
		cd_tween = null
		PlayerData.fairy_active = false
