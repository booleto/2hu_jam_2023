# 2hu Game Jăm 2023

### Cấu trúc file

Cấu trúc file được phân theo định dạng >> chức năng >> đối tượng.

VD: `Player.tscn` sẽ nằm trong `/Scenes/Objects/Player/Player.tscn`

- **Assets**: Các file được import vào engine (`.png`, `.mp3`, `.svg`,...)
	- **Sprite**: Sprite 2d
	- **Sounds**: SFX
	- **Music**: nhạc
- **Resources**: Các tài nguyên được tạo trong engine (`.tres`)
- **Scenes**: Các file `.tscn`
	- **Levels**: Các level của game
	- **Objects**: Các đối tượng của game
- **Scripts**: Các file `.gd`


### Kiến trúc phần mềm

Làm việc trên scene `level_template.tscn` trước để test tính năng, sau đó làm level bằng cách copy template.

##### Level

Mỗi level có 1 node `Main`

Node main chứa các node utils.

- GameStateService: Quản lý state game (pause, thắng, thua,...)
- Utils: Hàm chức năng
- GameEntities: Chứa các object trong game. Quản lý và instance object.

Các node khác:

- UI: giao diện người dùng
- Tilemap: Bộ tile chính của game


