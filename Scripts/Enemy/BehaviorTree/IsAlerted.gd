extends BTCondition

func tick(actor:Node, blackboard:BTBlackboard):
	if actor.investigating:
		return BTTickResult.SUCCESS
	
	return BTTickResult.FAILURE
