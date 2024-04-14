extends Camera2D

var scrolling_left = false
var scrolling_right = false
var scrolling_up = false
var scrolling_down = false

@export var scroll_speed = 20


func _physics_process(_delta):
  if scrolling_left:
    self.position.x -= scroll_speed
  if scrolling_right:
    self.position.x += scroll_speed
  if scrolling_up:
    self.position.y -= scroll_speed
  if scrolling_down:
    self.position.y += scroll_speed



func _on_scroll_area_left_mouse_entered():
  scrolling_left = true
  
func _on_scroll_area_left_mouse_exited():
 scrolling_left = false


func _on_scroll_area_right_mouse_entered():
  scrolling_right = true
  
func _on_scroll_area_right_mouse_exited():
  scrolling_right = false


func _on_scroll_area_top_mouse_entered():
  scrolling_up = true
  
func _on_scroll_area_top_mouse_exited():
  scrolling_up = false


func _on_scroll_area_bottom_mouse_entered():
  scrolling_down = true

func _on_scroll_area_bottom_mouse_exited():
  scrolling_down = false

