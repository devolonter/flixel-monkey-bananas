Strict

Import flixel
Import playstate
Import assets

Import flixel.flxtext.driver.angelfont

Class Replay Extends FlxGame

	Method New()
		Super.New(400, 300, GetClass("PlayState"))
	End Method
	
	Method OnContentInit:Void()
		FlxAssetsManager.AddImage(Assets.TILES, "tiles.png")
		FlxAssetsManager.AddString(Assets.MAP, "simple_map.txt")
		
		FlxTextAngelFontDriver.Init()
		FlxText.SetDefaultDriver(ClassInfo(FlxTextAngelFontDriver.ClassObject))
	End Method

End Class