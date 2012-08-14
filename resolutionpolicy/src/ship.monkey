Strict

Import flixel

Class Ship Extends FlxSprite

	Method New(velocity:Float, angle:Float)
		Super.New(FlxG.Random() * FlxG.Width, FlxG.Random() * FlxG.Height, "ship")
		Self.angle = angle
		FlxU.RotatePoint(0, velocity, 0, 0, angle, Self.velocity)
	End Method
	
	Method Update:Void()
		Super.Update()
		
		If(velocity.y > 0) Then
			If(y > FlxG.Height) y = - height
		Else
			If(y < - height) y = FlxG.Height + height
		End If
		
		If(velocity.x > 0) Then
			If(x > FlxG.Width) x = - width
		Else
			If(x < - width) x = FlxG.Width
		End If
	End Method

End Class