extends BTAction

@export var state : Enemy.State

func tick(actor:Node, blackboard:BTBlackboard):
	actor.current_state = state
	return BTTickResult.SUCCESS

