extends BTAction

@export var is_attacking : bool

func tick(actor:Node, blackboard:BTBlackboard):
	actor.animation_tree["parameters/conditions/attacking"] = is_attacking
	return BTTickResult.SUCCESS

