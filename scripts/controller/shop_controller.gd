extends Node2D

func _ready():
	$CanvasLayer/DeviationHint.text = "Total deviation: " + str(PersistentData.total_deviation)
	$CanvasLayer/MoneyHint.text = "Money: " + str(PersistentData.money)
