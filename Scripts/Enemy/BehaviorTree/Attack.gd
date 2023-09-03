extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	if blackboard.get_data("player_in_range"):
		return BTTickResult.SUCCESS

	return BTTickResult.SUCCESS
	

