Strict

Import flixel
Import playstate

Class Particles Extends FlxGame

	Method New()
		Super.New(400, 300, GetClass("PlayState"))
	End Method

End Class