extends Label

func _process(_delta):
    text = "%s / %s" % [PlayerData.hp, PlayerData.MAX_HP]