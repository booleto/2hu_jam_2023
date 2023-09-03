extends BTCondition

func tick(actor:Node, blackboard:BTBlackboard):
	if actor.attack_delay.is_stopped():
		return BTTickResult.SUCCESS
	return BTTickResult.FAILURE

