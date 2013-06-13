Strict


Import flixel
Import playstate
Import assets

Class Assets
	Const PLAYER:String = "player"
	
	Const LEVEL_MAP:String = "level_map"
	Const LEVEL_TILES:String = "level_tiles"
	
	Const LEVEL_SKY:String = "level_sky"
	Const LEVEL_SKYIMAGE:String = "level_skyimage"
End Class

Class FlixelGame Extends FlxGame

	Method New()
		Super.New(400, 300, GetClass("PlayState"))
	End Method
	
	Method OnContentInit:Void()
		FlxAssetsManager.AddImage(Assets.PLAYER, "spaceman.png")
		
		FlxAssetsManager.AddString(Assets.LEVEL_MAP, "mapCSV_Level1_Map.txt")
		FlxAssetsManager.AddImage(Assets.LEVEL_TILES, "tiles.png")
		
		FlxAssetsManager.AddString(Assets.LEVEL_SKY, "mapCSV_Level1_Sky.txt")
		FlxAssetsManager.AddImage(Assets.LEVEL_SKYIMAGE, "backdrop.png")
	End Method

End Class
