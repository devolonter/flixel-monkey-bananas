Strict

Import flixel

Import assets

Class Alien Extends FlxSprite
	
Private
	Const _DEFAULT_ANIMATION:String = "Default"

	Field _originalX:Int
	Field _shotClock:Float
	Field _bullets:FlxGroup
	
Public
	Method New(x:Int, y:Int, color:Int, bullets:FlxGroup)
		Super.New(x, y)
		
		#If TARGET <> "html5"
			LoadGraphic(Assets.IMAGE_ALIEN_SHIP, True)
			Color = color
		#Else
			LoadGraphic(Assets.IMAGE_ALIEN_SHIP + Abs(color), True)
		#End
		
		ResetShotClock()
		_originalX= x
		_bullets = bullets
		
		AddAnimation(_DEFAULT_ANIMATION, [0,1,0,2], 6 + FlxG.Random() * 4)
		Play(_DEFAULT_ANIMATION)
		
		velocity.x = 10
	End Method
	
	Method Update:Void()		
		If (y > FlxG.Height * .35) _shotClock -= FlxG.Elapsed
		
		If (_shotClock <= 0) Then
			ResetShotClock()
			Local bullet:FlxSprite = FlxSprite(_bullets.Recycle())
			bullet.Reset(x + width / 2 - bullet.width / 2, y)
			bullet.velocity.y = 65
		End If
	End Method
	
	Method SwitchDirectionNeeded:Bool()
		Return Abs(x - _originalX) > 8
	End Method
	
	Method ResetShotClock:Void()
		_shotClock = 1 + FlxG.Random() * 20
	End Method
	
	Method SwitchDirection:Void()		
		If (velocity.x > 0) Then
			x = _originalX + 8
		Else
			x = _originalX - 8
		End If
		
		velocity.x = -velocity.x		
	End Method

End Class