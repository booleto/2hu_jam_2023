extends BTAction

@export var is_moving : bool

func tick(actor:Node, blackboard:BTBlackboard):
	actor.animation_tree["parameters/conditions/moving"] = is_moving
	return BTTickResult.SUCCESS

