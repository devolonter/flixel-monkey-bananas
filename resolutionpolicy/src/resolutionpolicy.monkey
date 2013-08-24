Strict

Import flixel
Import playstate

Class ResolutionPolicy Extends FlxGame
	
	Method New()
		Super.New(640, 480, GetClass("PlayState"))
	End Method
	
	Method OnContentInit:Void()
		FlxAssetsManager.AddImage("bg", "bg.png")
		FlxAssetsManager.AddImage("ship", "ship.png")
	End Method

End Class