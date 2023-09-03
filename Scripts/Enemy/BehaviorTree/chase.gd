extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	if blackboard.get_data("sees_player") == true:
		actor.animation_tree["parameters/conditions/attacking"] = true
		actor.move_speed = actor.run_speed
		return BTTickResult.SUCCESS
	
	actor.animation_tree["parameters/conditions/attacking"] = false
	actor.move_speed = actor.walk_speed
	return BTTickResult.FAILURE

