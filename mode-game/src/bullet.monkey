Strict

Import flixel
Import assets

Class Bullet Extends FlxSprite

	Global __CLASS__:Object
	
	Field speed:Float
	
	Method New()
		Super.New()
		LoadGraphic(ImageAssets.BULLET, True)
		width = 6
		height = 6
		offset.x = 1
		offset.y = 1
			
		AddAnimation("up", [0])
		AddAnimation("down", [1])
		AddAnimation("left", [2])
		AddAnimation("right", [3])
		AddAnimation("poof", [4, 5, 6, 7], 50, False)
			
		speed = 360
	End Method
	
	Method Update:Void()
		If (Not alive) Then
			If (finished) Then
				exists = False
			End If
		ElseIf (touching) Then
			Kill()
		End If
	End Method
	
	Method Kill:Void()
		If (Not alive) Return
		
		velocity.x = 0
		velocity.y = 0
		If(Self.OnScreen()) FlxG.Play(SoundAssets.JUMP)
		alive = False
		Solid = False
		Play("poof")
	End Method
	
	Method Shoot:Void(location:FlxPoint, aim:Int)
		FlxG.Play(SoundAssets.SHOOT)
		Reset(location.x - width / 2, location.y - height / 2)
		Solid = True
		
		Select (aim)
			Case UP
				Play("up")
				velocity.y = -speed
			Case DOWN
				Play("down")
				velocity.y = speed
			Case LEFT
				Play("left")
				velocity.x = -speed
			Case RIGHT
				Play("left")
				velocity.x = speed
		End Select
	End Method

End Class