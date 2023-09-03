extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	var target = actor.sound_position
	actor.animation_tree
	actor.move_towards(target)
	actor.look_towards(target)
	return BTTickResult.SUCCESS
