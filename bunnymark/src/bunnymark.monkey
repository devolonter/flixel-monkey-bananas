Strict

Import flixel
Import playstate
Import flixel.flxtext.driver.angelfont

Class BunnyMark Extends FlxGame
	
	Method New()
		Super.New(640, 480, GetClass("PlayState"), 1, 60)
	End Method
	
	Method OnContentInit:Void()
		FlxAssetsManager.AddImage("grass", "grass.png")
		FlxAssetsManager.AddImage("pirate", "pirate.png")
		FlxAssetsManager.AddImage("bunny", "wabbit_alpha.png")
		
		FlxTextAngelFontDriver.Init()
		FlxText.SetDefaultDriver(ClassInfo(FlxTextAngelFontDriver.ClassObject))
	End Method

End Class