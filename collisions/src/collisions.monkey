Strict

Import flixel
Import playstate
Import assets

Class Collisions Extends FlxGame

	Method New()
		Super.New(400, 300, GetClass("PlayState"))
	End Method
	
	Method OnContentInit:Void()
		FlxAssetsManager.AddImage(Assets.CRATE, "crate.png")
		FlxAssetsManager.AddImage(Assets.ELEVATOR, "elevator.png")
		FlxAssetsManager.AddImage(Assets.FLIXEL_LOGO, "flixel_logo.png")
	End Method

End Class