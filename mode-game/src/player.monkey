Strict

Import flixel
Import assets
Import bullet

Class Player Extends FlxSprite

Private
	Field _jumpPower:Int
	Field _bullets:FlxGroup
	Field _aim:Int
	Field _restart:Float
	Field _gibs:FlxEmitter
	
	Field _heplerPoint:FlxPoint
	
Public
	Method New(x:Int, y:Int, bullets:FlxGroup, gibs:FlxEmitter)
		Super.New(x, y)
		
		LoadGraphic(ImageAssets.SPACEMAN, True, True, 8)		
		_restart = 0
		
		width = 6
		height = 7
		offset.x = 1
		offset.y = 1
		
		Local runSpeed:Int = 80
		drag.x = runSpeed * 8
		acceleration.y = 420
		_jumpPower = 200
		maxVelocity.x = runSpeed
		maxVelocity.y = _jumpPower
		
		AddAnimation("idle", [0])
		AddAnimation("run", [1, 2, 3, 0], 12)
		AddAnimation("jump", [4])
		AddAnimation("idle_up", [5])
		AddAnimation("run_up", [6, 7, 8, 5], 12)
		AddAnimation("jump_up", [9])
		AddAnimation("jump_down", [10])
		
		_bullets = bullets
		_gibs = gibs
		
		_heplerPoint = New FlxPoint()
	End Method
	
	Method Destroy:Void()
		Super.Destroy()
		_bullets = null
		_gibs = null
		_heplerPoint = Null	
	End Method
	
	Method Update:Void()
		If (Not alive) Then
			_restart += FlxG.Elapsed
			
			If (_restart > 2) Then
				FlxG.ResetState()
			End If
			
			Return
		End If
		
		If (JustTouched(FLOOR) And velocity.y > 50) Then
			FlxG.Play(SoundAssets.LAND)
		End If
		
		acceleration.x = 0
		
		If (FlxG.Keys.Left) Then
			Facing = LEFT
			acceleration.x -= drag.x
		ElseIf (FlxG.Keys.Right)
			Facing = RIGHT
			acceleration.x += drag.x
		End If
		
		If (FlxG.Keys.JustPressed(KEY_X) And Not velocity.y) Then
			velocity.y = -_jumpPower
			FlxG.Play(SoundAssets.JUMP)
		End If
		
		If (FlxG.Keys.Up) Then
			_aim = UP
		ElseIf (FlxG.Keys.Down) Then
			_aim = DOWN
		Else
			_aim = Facing	
		End If
		
		If (velocity.y <> 0) Then
			If (_aim = UP) Then
				Play("jump_up")
			ElseIf (_aim = DOWN) Then
				Play("jump_down")
			Else
				Play("jump")
			End If
		End If
		
		If (velocity.x = 0) Then
			If (_aim = UP) Then
				Play("idle_up")
			Else
				Play("idle")
			End If
		Else
			If (_aim = UP) Then
				Play("run_up")
			Else
				Play("run")
			End If
		End If
		
		If (FlxG.Keys.JustPressed(KEY_C)) Then
			If (Flickering) Then
				FlxG.Play(SoundAssets.JAM)
			Else
				GetMidpoint(_heplerPoint)
				Bullet(_bullets.Recycle(ClassInfo(Bullet.ClassObject))).Shoot(_heplerPoint, _aim)
				
				If (_aim = DOWN) velocity.y -= 36
			End If
		End If
	End Method
	
	Method Hurt:Void(damage:Float)
		damage = 0		
		If (Flickering) Return
		
		FlxG.Play(SoundAssets.HURT)
		Flicker(1.3)
		
		If (FlxG.Score > 1000) FlxG.Score -= 1000
		
		If (velocity.x > 0) Then
			velocity.x = -maxVelocity.x
		Else
			velocity.x = maxVelocity.x
		End If
		
		Super.Hurt(damage)
	End Method
	
	Method Kill:Void()
		If (Not alive) Return
		
		Solid = False
		
		FlxG.Play(SoundAssets.ASPLODE)
		FlxG.Play(SoundAssets.HIT_2)
		
		Super.Kill()
		
		Flicker(0)
		exists = True
		visible = false
		velocity.Make()
		acceleration.Make()
		FlxG.Camera.Shake(0.005,0.35)
		FlxG.Camera.Flash($FFD8EBA2, 0.35)
		
		If (_gibs <> Null) Then
			_gibs.At(Self)
			_gibs.Start(True, 5, 0, 50)
		End If
	End Method

End Class