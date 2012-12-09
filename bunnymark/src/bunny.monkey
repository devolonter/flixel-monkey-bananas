Strict

Import flixel
Import playstate

Class Bunny Extends FlxSprite

	Global ClassObject:Object

	Method New(gravity:Float = 0)
		Super.New()
		
		LoadGraphic("bunny")
		
		velocity.x = 50 * (Rnd() * 5)
		velocity.y = 50 * ( (Rnd() * 5) - 2.5)
		acceleration.y = gravity
		scale.x = 0.3 + Rnd()
		scale.y = scale.x
		angle = 15 - Rnd() * 30
		angularVelocity = 30 * Rnd() * 5
		
		If (Rnd() > 0.5) Then
			velocity.x = -velocity.x
		End If
		
		If (Rnd() > 0.5) Then
			velocity.y = -velocity.y
		End If
		
		If (Rnd() > 0.5) Then
			angularVelocity = -angularVelocity
		End If
	End Method
	
	Method Update:Void()
		Super.Update()
		
		Alpha = 0.3 + 0.7 * y / PlayState.MaxY
		
		If (x > PlayState.MaxX) Then
			velocity.x = -velocity.x
			x = PlayState.MaxX
			
		ElseIf(x < PlayState.MinX)
			velocity.x = -velocity.x
			x = PlayState.MinX
			
		ElseIf(y > PlayState.MaxY) Then
			velocity.y = -velocity.y
			y = PlayState.MaxY
			
		ElseIf(y < PlayState.MinY)
			velocity.y = -velocity.y
			y = PlayState.MinY
		End If
	End Method

End Class