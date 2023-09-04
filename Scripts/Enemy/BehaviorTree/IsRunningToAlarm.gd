extends BTCondition

func tick(actor:Node, blackboard:BTBlackboard):
	if actor.running_to_alarm:
		return BTTickResult.SUCCESS
		
	return BTTickResult.FAILURE

