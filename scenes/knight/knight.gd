extends CharacterBody2D

##################################################
const MOVING_SPEED = 100.0
const JUMP_VELOCITY = -300.0

var animated_sprite_node: AnimatedSprite2D
var camera_node: Camera2D
var zoom_tween: Tween

##################################################
func _ready() -> void:
	animated_sprite_node = $AnimatedSprite2D
	camera_node = $Camera2D

##################################################
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_node.play("jump")
		'''▼▼▼ 바닥에 착지해 있지 않다면 시간을 느리게 흐르도록 설정 ▼▼▼'''
		Engine.time_scale = 0.35
		SM.bgm_player.pitch_scale = 0.75
		
		'''▼▼▼ 느리게 흐르는 시간을 더욱 효과적으로 보이게 확대 ▼▼▼'''
		zoom_tween = create_tween()
		zoom_tween.tween_property(camera_node, "zoom", Vector2(2.0, 2.0), 0.3)
	else:
		'''▼▼▼ 바닥에 착지해 있다면 시간을 원래대로 흐르도록 설정 ▼▼▼'''
		Engine.time_scale = 1.0
		SM.bgm_player.pitch_scale = 1.0
		
		'''▼▼▼ 원래대로 흐르는 시간에 맞춰 원래대로 축소 ▼▼▼'''
		zoom_tween = create_tween()
		zoom_tween.tween_property(camera_node, "zoom", Vector2(1.0, 1.0), 0.3)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_direction: float = Input.get_axis("ui_left", "ui_right")
	if input_direction:
		velocity.x = input_direction * MOVING_SPEED
		if is_on_floor():
			animated_sprite_node.play("run")
		
		if input_direction > 0:
			animated_sprite_node.flip_h = false
		elif input_direction < 0:
			animated_sprite_node.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, MOVING_SPEED)
		
		if is_on_floor():
			animated_sprite_node.play("idle")

	move_and_slide()
