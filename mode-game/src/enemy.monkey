Strict

Import flixel
Import player
Import enemybullet

Class Enemy Extends FlxSprite

	Global ClassObject:FlxClass = New EnemyClass()
	
Private
	Field _player:Player
	Field _bullets:FlxGroup
	Field _gibs:FlxEmitter
	
	Field _thrust:Float
	
	Field _jets:FlxEmitter
	
	Field _timer:Float
	
	Field _shotClock:Float
	
	Field _playerMidpoint:FlxPoint
	
	Field _helperPoint:FlxPoint

Public
	Method New()
		Super.New()
		LoadGraphic(ImageAssets.BOT)
		
		width = 12
		height = 12
		CenterOffsets()
		
		_jets = new FlxEmitter();
		_jets.SetRotation()
		_jets.MakeParticles(ImageAssets.JET, 15, 0, False, 0)
		
		maxAngular = 120
		angularDrag = 400
		drag.x = 35
		_thrust = 0
		_playerMidpoint = new FlxPoint()
		_helperPoint = New FlxPoint()
	End Method	
	
	Method Init:Void(xPos:Int, yPos:Int, bullets:FlxGroup, gibs:FlxEmitter, player:Player)
		_player = player
		_bullets = bullets
		_gibs = gibs
		
		Reset(xPos - width/2,yPos - height/2)
		angle = _AngleTowardPlayer()
		health = 2
		_timer = 0
		_shotClock = 0
	End Method
	
	Method Destroy:Void()
		Super.Destroy()
		
		_player= Null
		_bullets = Null
		_gibs = Null
		
		_jets.Destroy()
		_jets = Null
		
		_playerMidpoint = Null
		_helperPoint = Null
	End Method
	
	Method Update:Void()
		Local da:Float = _AngleTowardPlayer()
		
		If (da < angle) Then
			angularAcceleration = -angularDrag
		ElseIf (da > angle) Then
			angularAcceleration = angularDrag
		Else
			angularAcceleration = 0
		End If
		
		_timer += FlxG.Elapsed
		
		If (_timer > 8) Then
			_timer = 0
		End If
		
		Local jetsOn:Bool = _timer < 6
		
		If (jetsOn) Then
			_thrust = FlxU.ComputeVelocity(_thrust, 90, drag.x, 60)
		Else
			_thrust = FlxU.ComputeVelocity(_thrust, 0, drag.x, 60)
		End If
		
		FlxU.RotatePoint(0,_thrust,0,0,angle,velocity)
		
		If (OnScreen()) Then
			Local shoot:Bool = False
			Local os:Float = _shotClock
			_shotClock += FlxG.Elapsed
			
			If (os < 4 And _shotClock >= 4) Then
				_shotClock = 0
				shoot = True
			ElseIf (os < 3.5 And _shotClock >= 3.5) Then
				shoot = True
			ElseIf (os < 3 And _shotClock >= 3) Then
				shoot = True
			End If
			
			If (shoot) Then
				Local b:EnemyBullet = EnemyBullet(_bullets.Recycle(EnemyBullet.ClassObject))				
				b.Shoot(GetMidpoint(_helperPoint), angle)
			End If
		End If
		
		Super.Update()
		
		If (jetsOn) Then
			If (Not _jets.on) Then
				_jets.Start(False, .5, .01)				
				If (OnScreen()) FlxG.Play(SoundAssets.JET)
			End If
			
			_jets.At(Self)
			_jets.SetXSpeed(-velocity.x-30,-velocity.x+30)
			_jets.SetYSpeed(-velocity.y-30,-velocity.y+30)
		Else
			_jets.on = false
		End If
		
		_jets.Update()
	End Method
	
	Method Draw:Void()
		_jets.Draw()
		Super.Draw()
	End Method
	
	Method Hurt:Void(damage:Float)
		FlxG.Play(SoundAssets.HIT)
		Flicker(.2)
		FlxG.Score += 10
		Super.Hurt(damage)
	End Method
	
	Method Kill:Void()
		If (Not alive) Return
		
		FlxG.Play(SoundAssets.ASPLODE)
		Super.Kill()
		Flicker(0)
		_jets.Kill()
		_gibs.At(Self)
		_gibs.Start(True,3,0,20)
		FlxG.Score += 200
	End Method
		
Private
	Method _AngleTowardPlayer:Float()
		Return FlxU.GetAngle(GetMidpoint(_helperPoint), _player.GetMidpoint(_playerMidpoint))
	End Method

End Class

Class EnemyClass Implements FlxClass
		
	Method CreateInstance:Object()
		Return New Enemy()
	End Method
	
	Method InstanceOf:Bool(object:Object)
		Return Enemy(object) <> Null
	End Method	

End Class