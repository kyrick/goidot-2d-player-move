extends KinematicBody2D

export var speed: = 200.0

var _velocity: = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var direction: = get_normalized_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	animate_move(direction)
	_velocity = move_and_slide(_velocity)


func animate_move(direction: Vector2) -> void:
	if direction.y >= 0.707:
		$PlayerAnimations.play("walk_down")
	elif direction.y <= -0.707:
		$PlayerAnimations.play("walk_up")
	elif direction.x >= 0.707:
		$PlayerAnimations.play("walk_right")
	elif direction.x <= -0.707:
		$PlayerAnimations.play("walk_left")
	else:
		$PlayerAnimations.stop()


func get_normalized_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		).normalized()


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: float
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed * direction.x
	out.y = speed * direction.y
	return out
