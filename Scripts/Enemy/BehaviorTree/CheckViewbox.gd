extends BTCondition

func tick(actor:Node, blackboard:BTBlackboard):
	if blackboard.get_data("player_in_view_box") == "true":
		return BTTickResult.SUCCESS
	
	return BTTickResult.FAILURE

