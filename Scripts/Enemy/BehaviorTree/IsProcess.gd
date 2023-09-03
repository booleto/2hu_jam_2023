extends BTCondition

func tick(actor:Node, blackboard:BTBlackboard):
	if actor.is_stunned:
		return BTTickResult.SUCCESS
	
	return BTTickResult.FAILURE

