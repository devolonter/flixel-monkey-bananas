Strict

Import flixel
Import menustate
Import assets

Import flixel.flxtext.driver.angelfont

Class Mode Extends FlxGame
	
	Method New()
		Super.New(320, 240, GetClass("MenuState"), 1, 60)
	End Method
	
	Method OnCreate:Int()
		Super.OnCreate()
		FlxG.SetResolutionPolicy(New RatioResolutionPolicy())
		Return 0
	End Method
	
	Method OnContentInit:Void()
		FlxAssetsManager.AddImage(ImageAssets.SPAWNER_GIBS, "spawner_gibs.png")
		FlxAssetsManager.AddImage(ImageAssets.GIBS, "gibs.png")
		FlxAssetsManager.AddImage(ImageAssets.SPACEMAN, "spaceman.png")
		FlxAssetsManager.AddImage(ImageAssets.BULLET, "bullet.png")
		FlxAssetsManager.AddImage(ImageAssets.TECH_TILES, "tech_tiles.png")
		FlxAssetsManager.AddImage(ImageAssets.DIRT_TOP, "dirt_top.png")
		FlxAssetsManager.AddImage(ImageAssets.DIRT, "dirt.png")
		FlxAssetsManager.AddImage(ImageAssets.BOT_BULLET, "bot_bullet.png")
		FlxAssetsManager.AddImage(ImageAssets.BOT, "bot.png")
		FlxAssetsManager.AddImage(ImageAssets.JET, "jet.png")
		FlxAssetsManager.AddImage(ImageAssets.SPAWNER, "spawner.png")
		FlxAssetsManager.AddImage(ImageAssets.MINIFRAME, "miniframe.png")
		
		FlxAssetsManager.AddSound(SoundAssets.HIT_1, "menu_hit." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(SoundAssets.HIT_2, "menu_hit_2." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(SoundAssets.JUMP, "jump." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(SoundAssets.LAND, "land." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(SoundAssets.ASPLODE, "asplode." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(SoundAssets.HURT, "hurt." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(SoundAssets.JAM, "jam." + FlxSound.GetValidExt())		
		FlxAssetsManager.AddSound(SoundAssets.SHOOT, "shoot." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(SoundAssets.ENEMY, "enemy." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(SoundAssets.HIT, "hit." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(SoundAssets.JET, "jet." + FlxSound.GetValidExt())
		FlxAssetsManager.AddSound(SoundAssets.COUNTDOWN, "countdown." + FlxSound.GetValidExt())
		
		FlxAssetsManager.AddMusic(SoundAssets.MODE, "mode." + FlxMusic.GetValidExt())
		
		FlxAssetsManager.AddCursor(ImageAssets.CURSOR, "cursor.png")
		
		FlxAssetsManager.AddString(StringAssests.ATTRACT_1, "attract1.txt")
		FlxAssetsManager.AddString(StringAssests.ATTRACT_2, "attract2.txt")
		
		FlxTextAngelFontDriver.Init()
		FlxText.SetDefaultDriver(ClassInfo(FlxTextAngelFontDriver.ClassObject))
		
		Local systemFont:FlxFont = FlxAssetsManager.GetFont(FlxText.SYSTEM_FONT, FlxText.DRIVER_ANGELFONT)
		systemFont.SetPath(32, "big_system_font.txt")
	End Method

End Class