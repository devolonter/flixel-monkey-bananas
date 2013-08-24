Strict

Import flixel
Import assets
Import player
Import spawner
Import victorystate

Class PlayState Extends FlxState Implements FlxOverlapNotifyListener, FlxCameraFadeListener

Private
	Field _blocks:FlxGroup
	Field _decorations:FlxGroup
	Field _bullets:FlxGroup
	Field _player:Player
	Field _enemies:FlxGroup
	Field _spawners:FlxGroup
	Field _enemyBullets:FlxGroup
	Field _littleGibs:FlxEmitter	
	Field _bigGibs:FlxEmitter
	Field _hud:FlxGroup
	Field _gunjam:FlxGroup
	
	Field _objects:FlxGroup
	Field _hazards:FlxGroup
	
	Field _score:FlxText
	Field _score2:FlxText
	Field _scoreTimer:Float
	Field _jamTimer:Float
	
	Field _fading:Bool
	
Public	
	Method Create:Void()		
		FlxG.Mouse.Hide()		
		
		_littleGibs = New FlxEmitter()
		_littleGibs.SetXSpeed(-150, 150)
		_littleGibs.SetYSpeed(-200, 0)
		_littleGibs.SetRotation(-720, -720)
		_littleGibs.gravity = 350
		_littleGibs.bounce = 0.5
		_littleGibs.MakeParticles(ImageAssets.GIBS, 100, 0, True, 0.5)
		
		_bigGibs = New FlxEmitter()
		_bigGibs.SetXSpeed(-200, 200)
		_bigGibs.SetYSpeed(-300, 0)
		_bigGibs.SetRotation(-720, -720)
		_bigGibs.gravity = 350
		_bigGibs.bounce = 0.35
		_bigGibs.MakeParticles(ImageAssets.SPAWNER_GIBS, 50, 0, True, 0.5)
		
		_blocks = New FlxGroup()
		_decorations = New FlxGroup()
		_enemies = New FlxGroup()
		_spawners = New FlxGroup()
		_hud = New FlxGroup()
		_enemyBullets = New FlxGroup()
		_bullets = New FlxGroup()
		
		_player = New Player(316, 300, _bullets, _littleGibs)
		
		_GenerateLevel()
		
		Add(_spawners)
		Add(_littleGibs)
		Add(_bigGibs)
		Add(_blocks)
		Add(_decorations)
		Add(_enemies)
		
		Add(_player)
		FlxG.Camera.SetBounds(0,0,640,640,True)
		FlxG.Camera.Follow(_player,FlxCamera.STYLE_PLATFORMER)
		
		Add(_enemyBullets)
		Add(_bullets)
		Add(_hud)
		
		_hazards = New FlxGroup()
		_hazards.Add(_enemyBullets)
		_hazards.Add(_spawners)
		_hazards.Add(_enemies)
		
		_objects = new FlxGroup()
		_objects.Add(_enemyBullets)
		_objects.Add(_bullets)
		_objects.Add(_enemies)
		_objects.Add(_player)
		_objects.Add(_littleGibs)
		_objects.Add(_bigGibs)
		
		_score = New FlxText(FlxG.Width/4,0,FlxG.Width/2)
		_score.SetFormat(FlxText.SYSTEM_FONT, 16, $D8EBA2, FlxText.ALIGN_CENTER, $131C1B)
		_hud.Add(_score)
		
		If (FlxG.Scores.Length() < 2) Then
			FlxG.Scores.Push(0)
			FlxG.Scores.Push(0)
		End If
		
		If (FlxG.Score > FlxG.Scores.Get(0)) Then
			FlxG.Scores.Set(0, FlxG.Score)
		End If
		
		If (Int(FlxG.Scores.Get(0)) <> 0) Then
			_score2 = New FlxText(FlxG.Width / 2, 0, FlxG.Width / 2)
			_score2.SetFormat(FlxText.SYSTEM_FONT,8,$d8eba2,FlxText.ALIGN_RIGHT,_score.Shadow)
			_hud.Add(_score2)
			_score2.Text = "HIGHEST: "+FlxG.Scores.Get(0)+"~nLAST: "+FlxG.Score
		End If
		
		FlxG.Score = 0
		_scoreTimer = 0
		
		_gunjam = new FlxGroup()
		_gunjam.Add(New FlxSprite(0,FlxG.Height-22).MakeGraphic(FlxG.Width,24,$ff131c1b))

		_gunjam.Add(new FlxText(0,FlxG.Height-22,FlxG.Width,"GUN IS JAMMED").SetFormat(FlxText.SYSTEM_FONT,16,$d8eba2,FlxText.ALIGN_CENTER))
		_gunjam.visible = False;
		_hud.Add(_gunjam)
		
		_hud.SetAll("scrollFactor", New FlxPoint())
		_hud.Cameras =[FlxG.Camera]
		
		FlxG.PlayMusic(SoundAssets.MODE)
		FlxG.Flash($FF131C1B)
		_fading = False	
	End Method
	
	Method Destroy:Void()
		Super.Destroy()
		
		_blocks = null
		_decorations = null
		_bullets = null
		_player = null
		_enemies = null
		_spawners = null
		_enemyBullets = null
		_littleGibs = null
		_bigGibs = null
		_hud = null
		_gunjam = null
		
		_objects = null
		_hazards = null
		
		_score = null
		_score2 = null
	End Method
	
	Method Update:Void()	
		Local oldScore:Int = FlxG.Score
	
		Super.Update()
		
		FlxG.Collide(_blocks, _objects)
		FlxG.Overlap(_hazards,_player,Self)
		FlxG.Overlap(_bullets,_hazards,Self)
		
		Local scoreChanged:Bool = oldScore <> FlxG.Score
		
		If (FlxG.Keys.JustPressed(KEY_C) And _player.Flickering) Then
			_jamTimer = 1
			_gunjam.visible = True		
		End If
		
		If (_jamTimer > 0) Then
			If (Not _player.Flickering) _jamTimer = 0
			
			_jamTimer -= FlxG.Elapsed
			
			If (_jamTimer < 0) Then
				_gunjam.visible = False
			End If
		End If
		
		If (Not _fading) Then
			If (scoreChanged) _scoreTimer = 2
			
			_scoreTimer -= FlxG.Elapsed
		
			If (_scoreTimer < 0) Then
				If (FlxG.Score > 0) Then
					If (FlxG.Score > 100) Then
						FlxG.Score -= 100
					Else
						FlxG.Score = 0
						_player.Kill()
					End If
					
					_scoreTimer = 1
					scoreChanged = True
					
					Local volume:Float = .35
					
					If (FlxG.Score < 600) Then
						volume = 1
					End If
					
					FlxG.Play(SoundAssets.COUNTDOWN, volume)
				End If			
			End If
			
			If (_spawners.CountLiving() <= 0) Then
				_fading = True
				FlxG.Fade($ffd8eba2,3,Self)
			End If
		End If		
		
		If (scoreChanged) Then			
			If (Not _player.alive) FlxG.Score = 0
			_score.Text = FlxG.Score
		End If
	
	End Method
	
	Method OnOverlapNotify:Void(object1:FlxObject, object2:FlxObject)
		If (EnemyBullet(object1) Or Bullet(object1)) object1.Kill()		
		object2.Hurt(1)
	End Method
	
	Method OnCameraFadeComplete:Void(camera:FlxCamera)
		FlxG.Music.Stop()
		FlxG.SwitchState(New VictoryState())
	End Method
	
Private
	Method _GenerateLevel:Void()
		Local r:Int = 160
		Local b:FlxTileblock
		
		b = New FlxTileblock(0,0,640,16)
		b.LoadTiles(ImageAssets.TECH_TILES)
		_blocks.Add(b)
		
		b = New FlxTileblock(0,16,16,640-16)
		b.LoadTiles(ImageAssets.TECH_TILES)
		_blocks.Add(b)
		
		b = New FlxTileblock(640-16,16,16,640-16)
		b.LoadTiles(ImageAssets.TECH_TILES)
		_blocks.Add(b)
		
		b = New FlxTileblock(16,640-24,640-32,8)
		b.LoadTiles(ImageAssets.DIRT_TOP)
		_blocks.Add(b)
		
		b = New FlxTileblock(16,640-16,640-32,16)
		b.LoadTiles(ImageAssets.DIRT)
		_blocks.Add(b)
		
		_BuildRoom(r*0,r*0,True)
		_BuildRoom(r*1,r*0)
		_BuildRoom(r*2,r*0)
		_BuildRoom(r*3,r*0,True)
		_BuildRoom(r*0,r*1,True)
		_BuildRoom(r*1,r*1)
		_BuildRoom(r*2,r*1)
		_BuildRoom(r*3,r*1,True)
		_BuildRoom(r*0,r*2)
		_BuildRoom(r*1,r*2)
		_BuildRoom(r*2,r*2)
		_BuildRoom(r*3,r*2)
		_BuildRoom(r*0,r*3,True)
		_BuildRoom(r*1,r*3)
		_BuildRoom(r*2,r*3)
		_BuildRoom(r*3,r*3,True)
	End Method

	Method _BuildRoom:Void(rx:Int, ry:Int, spawners:Bool = False)
		Local rw:Int = 20
		Local sx:Int
		Local sy:Int
		
		If (spawners) Then
			sx = 2 + FlxG.Random() * (rw - 7)
			sy = 2 + FlxG.Random() * (rw - 7)	
		End If
		
		Local numBlocks:Int = 3 + FlxG.Random() * 4
		If (spawners) numBlocks += 1
		
		Local maxW:Int = 10
		Local minW:Int = 2
		Local maxH:Int = 8
		Local minH:Int = 1
		Local bx:Int
		Local by:Int
		Local bw:Int
		Local bh:Int
		Local check:Bool
		
		For Local i:Int = 0 Until numBlocks
			Repeat
				bw = minW + FlxG.Random()*(maxW-minW)
				bh = minH + FlxG.Random()*(maxH-minH)
				bx = -1 + FlxG.Random()*(rw+1-bw)
				by = -1 + FlxG.Random()*(rw+1-bh)
				
				If (spawners) Then
					check = ((sx>bx+bw) Or (sx+3<bx) Or (sy>by+bh) Or (sy+3<by))
				Else
					check = True
				End If
			Until (check)
			
			Local b:FlxTileblock
			b = New FlxTileblock(rx+bx*8,ry+by*8,bw*8,bh*8)
			b.LoadTiles(ImageAssets.TECH_TILES)
			_blocks.Add(b)
			
			If (bw >= 4 And bh >= 5) Then
				b = New FlxTileblock(rx+bx*8+8,ry+by*8,bw*8-16,8)
				b.LoadTiles(ImageAssets.DIRT_TOP)
				_decorations.Add(b)
						
				b = New FlxTileblock(rx+bx*8+8,ry+by*8+8,bw*8-16,bh*8-24);
				b.LoadTiles(ImageAssets.DIRT)
				_decorations.Add(b)
			End If
		Next
		
		If (spawners) Then
			Local sp:Spawner = New Spawner(rx+sx*8,ry+sy*8,_bigGibs,_enemies,_enemyBullets,_littleGibs,_player)
			_spawners.Add(sp)
			
			_hud.Add(New FlxSprite(3 + (_spawners.Length-1)*16, 3, ImageAssets.MINIFRAME))
			Local camera:FlxCamera = New FlxCamera(5 + (_spawners.Length - 1) * 16, 5, 24, 24, 0.5)
			camera.Follow(sp)
			FlxG.AddCamera(camera)
		End If
	End Method

End Class