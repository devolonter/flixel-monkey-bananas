Strict

Import flixel
Import playstate
Import assets

Import flixel.flxtext.driver.angelfont

Class Collisions Extends FlxGame

	Method New()
		Super.New(400, 300, GetClass("PlayState"))
	End Method
	
	Method OnContentInit:Void()
		FlxAssetsManager.AddImage(Assets.CRATE, "crate.png")
		FlxAssetsManager.AddImage(Assets.ELEVATOR, "elevator.png")
		FlxAssetsManager.AddImage(Assets.FLIXEL_LOGO, "flixel_logo.png")
		
		FlxTextAngelFontDriver.Init()
		FlxText.SetDefaultDriver(ClassInfo(FlxTextAngelFontDriver.ClassObject))
	End Method

End Class