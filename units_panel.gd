extends PanelContainer

@onready var game = get_tree().root.get_node("Game")
@onready var grid = $UnitsScroller/UnitsGrid

var unit_stat_box = preload("res://unit_stat_box.tscn")

func _ready():
  game.selection_changed.connect(_on_selection_changed)
  
func _on_selection_changed(selected_units):
  for item in grid.get_children():
    item.queue_free()
  for unit in selected_units:
    if !unit.name.contains("Player"):
      var new_unit_stat_box = unit_stat_box.instantiate()
      new_unit_stat_box.unit = unit
      
      if unit.name.contains("Skeleton"):
        new_unit_stat_box.get_node("Label").text = "Skeleton"
      if unit.name.contains("Bowman"):
        new_unit_stat_box.get_node("Label").text = "Bowman"
      if unit.name.contains("Ghoul"):
        new_unit_stat_box.get_node("Label").text = "Ghoul"
        
      grid.add_child(new_unit_stat_box)
      
  
