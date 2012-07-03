Strict

Import flixel
Import playstate

Import flixel.flxtext.driver.angelfont

Class Particles Extends FlxGame

	Method New()
		Super.New(400, 300, GetClass("PlayState"))
	End Method
	
	Method OnContentInit:Void()
		FlxTextAngelFontDriver.Init()
		FlxText.SetDefaultDriver(ClassInfo(FlxTextAngelFontDriver.ClassObject))
	End Method

End Class