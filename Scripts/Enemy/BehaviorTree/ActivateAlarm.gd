extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	actor.designated_alarm.activate()
	actor.running_to_alarm = false
	return BTTickResult.SUCCESS

