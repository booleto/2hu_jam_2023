extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	actor.designated_to_alarm = false
	return BTTickResult.SUCCESS

