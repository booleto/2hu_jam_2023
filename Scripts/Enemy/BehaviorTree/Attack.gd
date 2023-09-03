extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	if blackboard.get_data("player_in_range"):
		var knockback_dir = (actor.raycast_target.position - actor.position).normalized()
		actor.raycast_target.take_damage(1, knockback_dir)
		actor.attack_delay.start()
		return BTTickResult.SUCCESS

	return BTTickResult.SUCCESS
	

