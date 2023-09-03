extends BTAction

@export var key : String

func tick(actor:Node, blackboard:BTBlackboard):
	if actor.player_in_view_box:
		blackboard.set_data(key, "true")
	else:
		blackboard.set_data(key, "false")
	return BTTickResult.SUCCESS

