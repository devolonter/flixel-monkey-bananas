Strict

Import flixel
Import flixel.flxtext.driver.angelfont

Import playstate
Import playership
Import alien
Import assets

Class FlxInvaders Extends FlxGame
	
	Method New()		
		Super.New(320, 240, GetClass("PlayState"))
		ShowMouse()
	End Method
	
	Method OnContentInit:Void()
		FlxTextAngelFontDriver.Init()
		FlxText.SetDefaultDriver(ClassInfo(FlxTextAngelFontDriver.ClassObject))
		
		'Register assets
		FlxAssetsManager.AddImage(Assets.IMAGE_PLAYER_SHIP, "ship.png")
		FlxAssetsManager.AddImage(Assets.IMAGE_ALIEN_SHIP, "alien.png")
		
		#If TARGET = "html5"
			FlxAssetsManager.AddImage(Assets.IMAGE_ALIEN_SHIP + Abs(FlxG.BLUE), "alien" + Abs(FlxG.BLUE) + ".png")
			FlxAssetsManager.AddImage(Assets.IMAGE_ALIEN_SHIP + Abs(FlxG.BLUE | FlxG.GREEN), "alien" + Abs(FlxG.BLUE | FlxG.GREEN) + ".png")
			FlxAssetsManager.AddImage(Assets.IMAGE_ALIEN_SHIP + Abs(FlxG.GREEN), "alien" + Abs(FlxG.GREEN) + ".png")
			FlxAssetsManager.AddImage(Assets.IMAGE_ALIEN_SHIP + Abs(FlxG.GREEN | FlxG.RED), "alien" + Abs(FlxG.GREEN | FlxG.RED) + ".png")
			FlxAssetsManager.AddImage(Assets.IMAGE_ALIEN_SHIP + Abs(FlxG.RED), "alien" + Abs(FlxG.RED) + ".png")
		#end
	End Method

End Class