Strict

Import flixel
Import playstate
Import assets
Class Replay Extends FlxGame

	Method New()
		Super.New(400, 300, GetClass("PlayState"))
	End Method
	
	Method OnContentInit:Void()
		FlxAssetsManager.AddImage(Assets.TILES, "tiles.png")
		FlxAssetsManager.AddString(Assets.MAP, "simple_map.txt")
	End Method

End Class