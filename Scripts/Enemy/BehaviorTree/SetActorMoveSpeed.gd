extends BTAction

@export var is_run_speed : bool

func tick(actor:Node, blackboard:BTBlackboard):
	if is_run_speed:
		actor.move_speed = actor.run_speed
	else:
		actor.move_speed = actor.walk_speed
	
	return BTTickResult.SUCCESS

