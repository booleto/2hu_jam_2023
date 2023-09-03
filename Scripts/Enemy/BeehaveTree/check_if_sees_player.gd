extends ActionLeaf

@export var prop_name : String

func tick(actor: Node, blackboard: Blackboard):
	#blackboard.set(prop_name, actor.sees_player)
	blackboard.set_value("seeplayer", actor.sees_player, "seeplayer")
	
	print(blackboard.keys())
	return SUCCESS

