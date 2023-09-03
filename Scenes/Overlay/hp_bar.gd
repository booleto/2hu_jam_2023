extends ProgressBar

func _ready():
    max_value = PlayerData.MAX_HP

func _process(_delta):
    value = PlayerData.hp