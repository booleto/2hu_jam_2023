extends BTAction

@export var running_to_alarm : bool

func tick(actor:Node, blackboard:BTBlackboard):
	if actor.designated_to_alarm:
		actor.running_to_alarm = running_to_alarm
		return BTTickResult.FAILURE
		
	return BTTickResult.SUCCESS

