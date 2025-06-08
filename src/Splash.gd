extends Control

func _ready() -> void:
	var isSupported = DisplayServer.is_dark_mode_supported()
	var isDarkMode = DisplayServer.is_dark_mode()
	
	var duration = .5
	var targetBGColor: Color
	
	if isSupported && isDarkMode:
		targetBGColor = Color.from_rgba8(24, 24, 24)
		%LogoTransition.texture = load("res://src/assets/images/logo_mono_white.png")
	else:
		targetBGColor = Color.from_rgba8(250, 250, 250)
		%LogoTransition.texture = load("res://src/assets/images/logo_colorful.png")
	
	var tween = get_tree().create_tween()
		
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_parallel()
	tween.tween_method(
		func (x): RenderingServer.set_default_clear_color(x),
		Color.BLACK, targetBGColor, duration
	)
	tween.tween_method(
		func (x): %LogoTransition.modulate = x,
		Color.TRANSPARENT, Color.WHITE, duration
	)
	tween.tween_method(
		func (x): %Logo.modulate = x,
		Color.WHITE, Color.TRANSPARENT, duration
	)
