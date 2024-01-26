extends Node2D
@export var Splashcreen: Node2D
@export var panelClose: Panel
@export var panelMenu: Panel
@export var panelRules:Panel
@export var panelOption:Panel
@export var buttonContinue :Button
@export var audioBackground : AudioStreamPlayer2D
signal reset 
var firstTime = true


# Called when the node enters the scene tree for the first time.
func _ready():
	#panelClose.set_process(false)
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	panelClose.hide()
	var tween = get_tree().create_tween()
	tween.tween_property($Node2D/Label, "modulate", Color(1,1,1,0), 1)
	tween.tween_property($Node2D/Label, "modulate", Color(1,1,1,1), 1)
	tween.set_loops()
	#tween.tween_property($Label, "scale", Vector2(), 1)
	
	
func _unhandled_input(event):
	if firstTime:
		if event is InputEventKey or event is InputEventMouseButton and event.is_pressed():
			Splashcreen.hide()
			panelMenu.show()
			firstTime = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_new_game_pressed():
	get_tree().paused = false
	buttonContinue.show()
	panelMenu.hide()
	reset.emit()
	


func _on_continue_game_pressed():
	get_tree().paused = false
	panelMenu.hide()


func _on_option_buttons_pressed():
	panelOption.show()


func _on_quit_buttons_pressed():
	panelClose.show()
	#panelClose.set_process(true)


func _on_btn_no_pressed():
	panelClose.hide()


func _on_btn_yes_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_button_rules_close_pressed():
	panelRules.hide()


func _on_rules_button_pressed():
	panelRules.show()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE :
			panelMenu.show()
			get_tree().paused = true
		


func _on_check_box_music_pressed():
	audioBackground.playing = !audioBackground.playing


func _on_button_close_option_pressed():
	panelOption.hide()
