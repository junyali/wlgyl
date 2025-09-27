extends CharacterBody2D

@export var max_speed: float = 40.0 # Maximum speed player is capped at walking
@export var acceleration: float = 500.0 # From stationary to max speed
@export var friction: float = 1500.0 # From max speed to stationary

var current_velocity: Vector2 = Vector2.ZERO
var move_direction: Vector2 = Vector2.ZERO
var is_action: bool = false
var last_hit_time: float = 0.0
var lemon_types = ["super_healing", "valuable", "hard", "spiky", "tasty", "normal"]
var lemon_amounts = [0, 0, 0, 0, 0, 0]
var lemon_index = 0;

@onready var sprite: Sprite2D = $Sprite
@onready var action_area: Area2D = $Range
@onready var action_timer: Timer = $Action

func _ready() -> void:
	add_to_group("player")
	sprite.modulate = Color.WHITE

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_action()
	
func _process(_delta: float) -> void:
	pass
	
func handle_movement(delta: float) -> void:
	var h_dir: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var v_dir: float = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	var input_dir: Vector2 = Vector2(h_dir, v_dir).normalized()
	
	if abs(h_dir) > abs(v_dir):
		input_dir = Vector2(sign(h_dir), 0)
	elif abs(v_dir) > 0:
		input_dir = Vector2(0, sign(v_dir))
	
	# Accelerative speed (was that even a word??)
	if input_dir != Vector2.ZERO:
		move_direction = input_dir
	else:
		move_direction = Vector2.ZERO # Instant stop
		
	# Update facing direction when moving
	if move_direction != Vector2.ZERO and not is_action:
		var target_speed: float = max_speed
		current_velocity = velocity.move_toward(move_direction * target_speed, acceleration * delta)
	else:
		current_velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	velocity = current_velocity
	move_and_slide()
	
func handle_action() -> void:
	if Input.is_action_just_pressed("action") and not is_action:
		is_action = true
		action_timer.start()
		sprite.modulate = Color(1.5, 1.5, 1.5)
		fade_out(1)
		var nearest_body = get_nearest_harvestable_body()
		if nearest_body:
			pass
			lemon_amounts[lemon_index] += nearest_body.harvest()
		else:
			for body in action_area.get_overlapping_bodies():
				pass
				lemon_amounts[lemon_index] += body.harvest()
				
	if Input.is_action_just_pressed("action_secondary"):
		var nearest_body = get_nearest_harvestable_body()
		if nearest_body:
			var seed = randi() % lemon_types.size()
			lemon_index = seed
			nearest_body.plant(lemon_types[lemon_index])

func get_nearest_harvestable_body() -> Node:
	var nearest_body = null
	var min_distance = 9999
	var player_pos = global_position
	for body in action_area.get_overlapping_bodies():
		if body.is_in_group("crop"):
			var distance = player_pos.distance_to(body.global_position)
			if distance < min_distance:
				min_distance = distance
				nearest_body = body
	return nearest_body
	
func fade_out(time: float = 1.0) -> void:
	var tween: Tween = create_tween().set_parallel()
	tween.tween_property(sprite, "modulate", Color(1, 1, 1), time)
	await tween.finished

func _on_action_timeout() -> void:
	is_action = false

func _on_range_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.

func _on_range_body_exited(_body: Node2D) -> void:
	pass # Replace with function body.
