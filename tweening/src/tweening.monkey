Strict

Import flixel
Import playstate
Import flixel.flxtext.driver.angelfont

Class Tweening Extends FlxGame

	Method New()
		Super.New(640, 480, GetClass("PlayState"), 1, 60, 60)
	End Method
	
	Method OnContentInit:Void()
		FlxTextAngelFontDriver.Init()
		FlxText.SetDefaultDriver(ClassInfo(FlxTextAngelFontDriver.ClassObject))
	End Method

End Class