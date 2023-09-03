extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	var target = actor.raycast_target.position
	actor.move_towards(target)
	actor.look_towards(target)
	return BTTickResult.SUCCESS

