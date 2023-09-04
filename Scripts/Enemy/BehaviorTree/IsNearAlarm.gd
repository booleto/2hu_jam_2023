extends BTCondition

func tick(actor:Node, blackboard:BTBlackboard):
	if actor.position.distance_to(actor.designated_alarm.position) < 100:
		return BTTickResult.SUCCESS
		
	return BTTickResult.FAILURE
