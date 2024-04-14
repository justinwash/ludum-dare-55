extends Node

@onready var parent = get_node("../")

func barrage(target, cost):
  print('barrage called on ', parent, ' targeting ', target)
  parent.mp -= cost
