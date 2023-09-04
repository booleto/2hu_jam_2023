extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	var target = actor.designated_alarm.position
	actor.move_towards(target)
	return BTTickResult.SUCCESS

