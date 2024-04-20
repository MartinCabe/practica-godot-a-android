extends Area2D

signal hit
@export var speed = 400
var direction = Vector2.ZERO
var screen_size
var canMove = false

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play("idle-loop")

func _process(delta):
	if canMove:
		if direction.length() > 0:
			direction = direction.normalized() * speed
		position += direction * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_up_button_button_up():
	canMove = false
	$AnimatedSprite2D.animation = "idle-loop"

func _on_up_button_button_down():
	canMove = true
	direction = Vector2.UP
	$AnimatedSprite2D.animation = "up-loop"

func _on_left_button_button_up():
	canMove = false
	$AnimatedSprite2D.animation = "idle-loop"

func _on_left_button_button_down():
	canMove = true
	direction = Vector2.LEFT
	$AnimatedSprite2D.animation = "left-loop"

func _on_right_button_button_up():
	canMove = false
	$AnimatedSprite2D.animation = "idle-loop"

func _on_right_button_button_down():
	canMove = true
	direction = Vector2.RIGHT
	$AnimatedSprite2D.animation = "right-loop"

func _on_down_button_button_up():
	canMove = false
	$AnimatedSprite2D.animation = "idle-loop"

func _on_down_button_button_down():
	canMove = true
	direction = Vector2.DOWN
	$AnimatedSprite2D.animation = "down-loop"

func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
