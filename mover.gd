extends Node

@onready var parent = get_node("../")

func _physics_process(_delta):
  if parent.target_position:
      var move_direction: Vector2 = (parent.target_position - parent.position).normalized()

      parent.velocity = move_direction * parent.speed
      parent.move_and_slide()
