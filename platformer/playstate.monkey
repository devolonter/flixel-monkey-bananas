Strict

Import flixel
Import assets

Class PlayState Extends FlxState

	Field player:FlxSprite	
	Field level:MapLevel
			
	Method Create:Void()
		FlxG.Framerate = 60
	
		level = New MapLevel
		Add(level);
		
		_SetupPlayer()
		
		'tell flixel how big our game world is
		FlxG.WorldBounds = New FlxRect(0, 0, level.width, level.height);
		'keep camera in boundries of map
		FlxG.Camera.SetBounds(0, 0, level.width, level.height);
		'camera follows players, bitches
		FlxG.Camera.Follow(player, FlxCamera.STYLE_PLATFORMER);
		
		'FlxG.Mouse.Show()
	End Method
	
	Method Update:Void()		
		If (FlxG.Keys.JustPressed(KEY_ESCAPE)) Error ""
		_UpdatePlayer()
		Super.Update()
		FlxG.Collide(player, level)
	End Method
	
	Method Draw:Void()
		Super.Draw()
	End Method

Private	
	Method _SetupPlayer:Void()
		player = New FlxSprite(64, 220)
		player.LoadGraphic(Assets.PLAYER, True, True, 16)
		
		player.width = 14
		player.height = 14
		player.offset.x = 1
		player.offset.y = 1
		
		player.drag.x = 640
		player.acceleration.y = 420
		player.maxVelocity.x = 80
		player.maxVelocity.y = 200
		
		player.AddAnimation("idle", [0])
		player.AddAnimation("run", [1, 2, 3, 0], 12)
		player.AddAnimation("jump", [4])
		
		Add(player)
	End Method
	
	Method _UpdatePlayer:Void()
		player.acceleration.x = 0
		
		If (FlxG.Keys.Left) Then
			player.Facing = FlxObject.LEFT
			player.acceleration.x -= player.drag.x
			
		ElseIf (FlxG.Keys.Right) Then
			player.Facing = FlxObject.RIGHT
			player.acceleration.x += player.drag.x
		End If
		
		If (FlxG.Keys.JustPressed(KEY_UP) And player.velocity.y = 0) Then
			player.y -= 1
			player.velocity.y = -200
		End If
		
		If (player.velocity.y <> 0) Then
			player.Play("jump")
		
		ElseIf (player.velocity.x = 0) Then
			player.Play("idle")
			
		Else
			player.Play("run")
		End If
	End Method
End Class

Class MapLevel Extends FlxGroup
	Field map:FlxTilemap
	Field sky:FlxTilemap
	Field width:Int
	Field height:Int
	
	Method New()
		sky = New FlxTilemap
		sky.LoadMap(FlxAssetsManager.GetString(Assets.LEVEL_SKY), Assets.LEVEL_SKYIMAGE, 192, 336);
		sky.SetTileProperties(1, FlxObject.NONE);
		sky.scrollFactor.x = 0.5;
			
		map = New FlxTilemap
		map.LoadMap(FlxAssetsManager.GetString(Assets.LEVEL_MAP), Assets.LEVEL_TILES, 16, 16, 0, 0, 1, 31);
		width = map.width;
		height = map.height;
		
		'so that we can jump up through this tile#
		map.SetTileProperties(40, FlxObject.UP, null, null, 4);
		
		Add(sky);
		Add(map);
	End
	
End