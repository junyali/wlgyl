extends StaticBody2D

@export var harvest_cue: bool = true
@export var cue_range: float = 32.0
@export var cue_colour: Color = Color(1.5, 1.5, 1,5)

@onready var sprite: Sprite2D = $Sprite
@onready var cue_sprite: Sprite2D = $CueSprite
@onready var tool_hint_sprite: Sprite2D = $ToolHintSprite
@onready var cue_area: CollisionShape2D = $CueArea/Detect

func _ready() -> void:
	add_to_group("crop")
	if cue_area.shape is CircleShape2D:
		cue_area.shape.radius = cue_range
		
	setup_cue()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func setup_cue() -> void:
	if harvest_cue:
		cue_sprite.modulate.a = 0
		tool_hint_sprite.modulate.a = 0

		var start_pos: Vector2 = tool_hint_sprite.position
		var hint_tween: Tween  = create_tween().set_loops()
		hint_tween.tween_property(tool_hint_sprite, "position:y", start_pos.y - 1.0, 0.5)
		hint_tween.tween_property(tool_hint_sprite, "position:y", start_pos.y, 0.5)
		
func fade_out(time: float = 1.0) -> void:
	var tween: Tween = create_tween().set_parallel()
	tween.tween_property(cue_sprite, "modulate:a", 0.0, time * 0.3)
	tween.tween_property(tool_hint_sprite, "modulate:a", 0.0, time * 0.3)
	tween.tween_property(sprite, "modulate", Color(1, 1, 1, 0), time)
	await tween.finished
	queue_free()

func show_cue() -> void:
	if harvest_cue:
		tween_sprite(cue_colour)
		
		var tween: Tween = create_tween()
		tween.tween_property(cue_sprite, "modulate:a", 1.0, 0.3)
		tween.parallel().tween_property(tool_hint_sprite, "modulate:a", 1.0, 0.3)

func hide_cue() -> void:
	tween_sprite(Color(1, 1, 1))
	var tween: Tween = create_tween()
	tween.tween_property(cue_sprite, "modulate:a", 0.0, 0.3)
	tween.parallel().tween_property(tool_hint_sprite, "modulate:a", 0.0, 0.3)

func tween_sprite(colour: Color, duration: float = 1.0) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(sprite, "modulate", colour, duration)

func _on_cue_area_body_entered(body: Node2D) -> void:
	var player: bool = body.is_in_group("player")
	if player:
		show_cue()

func _on_cue_area_body_exited(body: Node2D) -> void:
	var player: bool = body.is_in_group("player")
	if player:
		hide_cue()
