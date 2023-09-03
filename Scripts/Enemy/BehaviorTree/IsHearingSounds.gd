extends BTCondition

func tick(actor:Node, blackboard:BTBlackboard):
	if actor.hearing_sounds:
		return BTTickResult.SUCCESS
	
	return BTTickResult.FAILURE

