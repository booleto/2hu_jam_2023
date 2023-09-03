extends MarginContainer

func _process(_delta):
    $SegmentedBar.set_value(PlayerData.danger)
