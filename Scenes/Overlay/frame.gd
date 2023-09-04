@tool
extends MarginContainer
@export var texture: Texture2D
@export var frame_color: Color = Color.WHITE

func init_data():
	if texture != null:
		var atlas = AtlasTexture.new()
		atlas.atlas = texture
		atlas.region = Rect2i(8, 2, 16, 16)
		%Image.texture = atlas
	if frame_color != null:
		$NinePatchRect.modulate = frame_color

func _ready():
	init_data()

func _process(_delta):
	if Engine.is_editor_hint():
		init_data()
