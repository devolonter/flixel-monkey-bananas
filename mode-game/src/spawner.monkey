Strict

Import flixel
Import player
Import enemy

Class Spawner Extends FlxSprite
	
Private
	Field _timer:Float
	Field _bots:FlxGroup
	Field _botBullets:FlxGroup
	Field _botGibs:FlxEmitter
	Field _gibs:FlxEmitter
	Field _player:Player
	Field _open:Bool
	
Public
	Method New(x:Int, y:Int, gibs:FlxEmitter, bots:FlxGroup, botBullets:FlxGroup, botGibs:FlxEmitter, player:Player)
		Super.New(x, y)
		
		LoadGraphic(ImageAssets.SPAWNER, True)
		_gibs = gibs;
		_bots = bots
		_botBullets = botBullets
		_botGibs = botGibs
		_player = player
		_timer = FlxG.Random()*20
		_open = false
		health = 8

		AddAnimation("open", [1, 2, 3, 4, 5], 40, false)
		AddAnimation("close", [4, 3, 2, 1, 0], 40, false)
		AddAnimation("dead", [6])
	End Method
	
	Method Destroy:Void()
		Super.Destroy()
		_bots = Null
		_botGibs = Null
		_botBullets = Null
		_gibs = Null
		_player = Null
	End Method
	
	Method Update:Void()
		_timer += FlxG.Elapsed
		
		Local limit:Int = 20
		
		If (OnScreen()) Then
			limit = 4
		End If
		
		If (_timer > limit) Then
			_timer = 0
			_MakeBot()
						
		ElseIf (_timer > limit - 0.35) Then
			If (Not _open) Then
				_open = True
				Play("open")
			End If
			
		ElseIf (_timer > 1) Then
			If (Not _open) Then
				_open = True
				Play("close")
			End If
		End If
		
		Super.Update()
	End Method
	
	Method Hurt:Void(damage:Float)
		FlxG.Play(SoundAssets.HIT)
		Flicker(0.2)
		FlxG.Score += 50
		Super.Hurt(damage)
	End Method
	
	Method Kill:Void()
		If (Not alive) Return
		
		FlxG.Play(SoundAssets.ASPLODE)
		FlxG.Play(SoundAssets.HIT_2)
		
		Super.Kill()
		
		active = False
		exists = True
		Solid = False
		Flicker(0)
		Play("dead")
		
		FlxG.Camera.Shake(0.007,0.25)
		FlxG.Camera.Flash($FFD8EBA2,0.65)
		
		_MakeBot()
		_gibs.At(Self)
		_gibs.Start(True,3)
		
		FlxG.Score += 1000
	End Method
	
Private
	Method _MakeBot:Void()
		If (_bots.CountLiving() > 10) Return	
		Enemy(_bots.Recycle(Enemy.ClassObject)).Init(x + width/2, y + height/2, _botBullets, _botGibs, _player)
	End Method	

End Class