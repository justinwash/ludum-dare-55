extends Node2D

var selected_units = []
var active_ability = null

@onready var player = get_node("Player")

signal selection_changed(selected_units)

func _ready():
  Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _process(delta):
  # Listen for left mouse button click
  if Input.is_action_just_pressed("r_click"):
    if selected_units == []:
      selected_units = [player]
    # Set the target position to the global mouse position
    for unit in selected_units:
      unit.target_position = get_global_mouse_position()
      
  if Input.is_action_just_pressed("space"):
    selected_units = [$Player]
    selection_changed.emit(selected_units)
    
  if Input.is_action_just_pressed("tab"):
    selected_units = get_tree().get_nodes_in_group("friendly_actor")
    selection_changed.emit(selected_units)
  if Input.is_action_just_pressed("1"):
    selected_units = get_tree().get_nodes_in_group("friendly_skeleton")
    selection_changed.emit(selected_units)
  if Input.is_action_just_pressed("2"):
    selected_units = get_tree().get_nodes_in_group("friendly_bowman")
    selection_changed.emit(selected_units)
  if Input.is_action_just_pressed("3"):
    selected_units = get_tree().get_nodes_in_group("friendly_ghoul")
    selection_changed.emit(selected_units)
    
      
var dragging: bool = false
var selected: Array = []  # Array of selected units
var drag_start: Vector2 = Vector2.ZERO
var select_rect: RectangleShape2D = RectangleShape2D.new()  # Collision shape for drag box

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
      if active_ability == null:
        if event.pressed && !dragging:
          dragging = true
          drag_start = event.position
          update(event)
        elif dragging:
            # End the drag when button is released
            dragging = false
      elif event.pressed:
        if active_ability.required_unit_name == "Player":
          player.abilities.call(active_ability.ability_name, event.position, active_ability.cost)
        for unit in selected_units:
          if unit.abilities.has_method(active_ability.ability_name) && unit.mp >= active_ability.cost:
            unit.abilities.call(active_ability.ability_name, event.position, active_ability.cost)
        active_ability = null
            
    if event is InputEventMouseMotion and dragging:
        update(event)

func _draw() -> void:
    if dragging:
        # Draw the selection rectangle during dragging
        draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start), Color(1, 1, 1), false)

func update(event) -> void:
    # Calculate the drag end position
    var drag_end: Vector2 = event.position
    var rect_min: Vector2 = Vector2(min(drag_start.x, drag_end.x), min(drag_start.y, drag_end.y))
    var rect_max: Vector2 = Vector2(max(drag_start.x, drag_end.x), max(drag_start.y, drag_end.y))
    select_rect.extents = (rect_max - rect_min) / 2

    # Query the physics space to find units inside the selection box
    var space = get_world_2d().direct_space_state
    var query = PhysicsShapeQueryParameters2D.new()
    query.set_shape(select_rect)
    query.transform = Transform2D(0, (drag_end + drag_start) / 2)
    selected = space.intersect_shape(query)
    
    selected_units = [] 
    
    for item in selected:
      if item.collider is CharacterBody2D:
        selected_units.append(item.collider)
    
    selection_changed.emit(selected_units)
      
