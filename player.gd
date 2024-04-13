extends CharacterBody2D

# Player movement speed
var speed: float = 75

# Target position for movement
var target_position: Vector2

func _physics_process(delta: float) -> void:
    if get_tree().root.get_node("Game").selected_units.has(self):
      $SelectIndicator.visible = true
    else:
      $SelectIndicator.visible = false
    if target_position:
      var move_direction: Vector2 = (target_position - position).normalized()

      velocity = move_direction * speed
      move_and_slide()


func _on_area_2d_input_event(viewport, event, shape_idx):
  if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
    get_tree().root.get_node("Game").selected_units = [self]
