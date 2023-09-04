extends MarginContainer
@export var texture: Texture2D:
	set (value):
		if value != null:
			var atlas = AtlasTexture.new()
			atlas.atlas = value
			atlas.region = Rect2i(8, 2, 16, 16)
			%Image.texture = atlas
		else:
			%Image.texture = null
	get: 
		return %Image.texture.atlas if %Image.texture != null else null
@export var frame_color: Color = Color.WHITE:
	set (value):
		$NinePatchRect.modulate = value
	get: 
		return $NinePatchRect.modulate
