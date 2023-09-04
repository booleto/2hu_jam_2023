extends AnimatedSprite2D

var damage = 1
var shooting : bool = false
var spread : float = 0.1
var theta : float = 0.0
var min_dtheta : float = PI/6
var max_dtheta : float = 2*PI
var max_speed : int = 15
var min_speed : int = 5
var spawn_delay : int = 3
var player : Player


func _process(_delta):
	position = player.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not shooting:
		return
	if spawn_delay <= 0:
		spawn_delay = 3
		return

	spawn_delay -= 1	
	var game_entities = get_parent()
	if game_entities is GameEntities:
		var direction = Vector2(cos(theta), sin(theta)).normalized()
		var spawn_pos = position + direction * 40
		var speed = randi_range(min_speed, max_speed)
		
		theta += randf_range(min_dtheta, max_dtheta)
		game_entities.spawn_danmaku(spawn_pos, direction, damage, speed)
		
		
func _on_effect_delay_timeout():
	shooting = true


func _on_effect_end_timeout():
	player.process_mode = Node.PROCESS_MODE_INHERIT
	queue_free()
