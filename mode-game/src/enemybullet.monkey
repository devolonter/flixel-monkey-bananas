Strict

Import flixel
Import assets

Class EnemyBullet Extends FlxSprite
	
	Global ClassObject:FlxClass = New EnemyBulletClass()

	Field speed:Float
	Field _helperPoint:FlxPoint
	
	Method New()
		Super.New()
		LoadGraphic(ImageAssets.BOT_BULLET, True)
		AddAnimation("idle",[0, 1], 50)
		AddAnimation("poof",[2, 3, 4], 50, False)
		speed = 120
		_helperPoint = New FlxPoint()
	End Method
	
	Method Dstroy:Void()
		_helperPoint = Null
	End Method
	
	Method Update:Void()
		If (Not alive) Then
			If (finished) exists = False
		ElseIf (touching) Then
			Kill()
		End If
	End Method
	
	Method Kill:Void()
		If (Not alive) Return
		
		velocity.x = 0
		velocity.y = 0
		
		If (OnScreen()) FlxG.Play(SoundAssets.JUMP)
		
		alive = False
		Solid = false
		Play("poof")
	End Method
	
	Method Shoot:Void(location:FlxPoint, angle:Float)
		FlxG.Play(SoundAssets.ENEMY, .5)
		Reset(location.x-width/2,location.y-height/2)
		FlxU.RotatePoint(0,speed,0,0,angle, _helperPoint)
		velocity.x = _helperPoint.x
		velocity.y = _helperPoint.y
		Solid = True
		Play("idle")
	End Method

End Class

Class EnemyBulletClass Implements FlxClass
		
	Method CreateInstance:Object()
		Return New EnemyBullet()
	End Method
	
	Method InstanceOf:Bool(object:Object)
		Return EnemyBullet(object) <> Null
	End Method	

End Class