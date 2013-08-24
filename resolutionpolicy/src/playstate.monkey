Strict

Import flixel
Import ship

Class PlayState Extends FlxState

	Field currentPolicy:FlxText
	
	Method Create:Void()	
		Add(New FlxSprite(0, 0, "bg"))
	
		For Local i:Int = 0 To 20
			Add(New Ship(FlxG.Random() * 50 + 50, FlxG.Random() * 360))
		Next
		
		FlxText(Add(New FlxText(10, 10, 160, "Current policy: "))).Size = 16
		
		currentPolicy = New FlxText(170, 10, 150, "fill")
		currentPolicy.Size = 16
		Add(currentPolicy)
		
		FlxText(Add(New FlxText(0, FlxG.Height - 40, FlxG.Width, "press space to change resolution policy"))).SetFormat(FlxText.SYSTEM_FONT, 14, FlxG.WHITE, FlxText.ALIGN_CENTER).Alpha = 0.5
	End Method
	
	Method Update:Void()
		Super.Update()
		
		If(FlxG.Keys.JustPressed(KEY_SPACE) Or FlxG.Touch().JustPressed()) Then
			Select currentPolicy.Text
				Case "fill"
					FlxG.SetResolutionPolicy(New RatioResolutionPolicy())
					currentPolicy.Text = "ratio"
				
				Case "ratio"
					FlxG.SetResolutionPolicy(New FixedResolutionPolicy())
					currentPolicy.Text = "fixed"
					
				Case "fixed"
					FlxG.SetResolutionPolicy(New RelativeResolutionPolicy(0.5))
					currentPolicy.Text = "relative 50%"
				
				Default
					FlxG.SetResolutionPolicy(New FillResolutionPolicy())
					currentPolicy.Text = "fill"
			End Select
		End If
	End Method

End Class