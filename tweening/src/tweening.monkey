Strict

Import flixel
Import playstate

Class Tweening Extends FlxGame

	Method New()
		Super.New(640, 480, GetClass("PlayState"))
	End Method

End Class