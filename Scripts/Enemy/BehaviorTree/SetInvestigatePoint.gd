extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	print("investigate pointe set")
	actor.investigate_position = actor.raycast_target.position
	return BTTickResult.FAILURE

