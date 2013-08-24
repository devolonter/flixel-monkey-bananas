Strict

Import flixel
Import playstate
Import assets

Class PathFinding Extends FlxGame

	Method New()
		Super.New(400, 300, GetClass("PlayState"))
	End Method
	
	Method OnContentInit:Void()
		FlxAssetsManager.AddImage(Assets.TILES, "tiles.png")
		FlxAssetsManager.AddString(Assets.MAP, "pathfinding_map.txt")
	End Method

End Class