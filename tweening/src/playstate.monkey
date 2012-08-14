Strict

Import flixel
Import easeinfo

Alias RGetClass = reflection.GetClass

Class PlayState Extends FlxState

	Const MAX_TWEEN:Int = 10
	
	Const DURATION:Float = 1

	Field easeInfo:Stack<EaseInfo>
	
	Field currentEaseIndex:Int
	
	Field tween:FlxTween
	
	Field currentTweenIndex:Int
	
	Field sprite:FlxSprite
	
	Field min:FlxPoint
	
	Field max:FlxPoint
	
	Field easeText:FlxText
	
	Field tweenText:FlxText
	
	Field helpText:FlxText

	Method Create:Void()
		FlxG.SetBgColor($FF01355F)
	
		Local easeFunctions:GlobalInfo[] = RGetClass("Ease").GetGlobals(False)
		easeInfo = New Stack<EaseInfo>()
		
		For Local easeFunction:GlobalInfo = EachIn easeFunctions
			easeInfo.Push(New EaseInfo(easeFunction.Name, FlxEaseFunction(easeFunction.GetValue())))
		Next
		
		sprite = (New FlxSprite()).MakeGraphic(100, 100)
		sprite.offset.Make(sprite.width * 0.5, sprite.height * 0.5)
		Add(sprite)
		
		currentEaseIndex = 0
		currentTweenIndex = 0
		
		min = New FlxPoint(FlxG.Width * 0.25, FlxG.Height * 0.25)
		max = New FlxPoint(min.x + FlxG.Width * 0.5, min.y + FlxG.Height * 0.5)
		
		tweenText = New FlxText(10, 10, FlxG.Width - 20, "")
		tweenText.Size = 12
		easeText = New FlxText(10, 30, FlxG.Width - 20, "")
		easeText.Size = 12
		
		helpText = New FlxText(10, FlxG.Height - 20, FlxG.Width - 20, "")
		helpText.Alignment = FlxText.ALIGN_CENTER
		helpText.Text = "Press UP or DOWN keys to change tweening. Press SPACE to change current ease function"
		
		Add(tweenText)
		Add(easeText)
		Add(helpText)
	End Method
	
	Method Update:Void()
		Super.Update()
		
		If (AngleTween(tween) <> Null) Then
			sprite.angle = AngleTween(tween).angle
			
		ElseIf(ColorTween(tween) <> Null) Then
			sprite.Color = ColorTween(tween).color
			
		ElseIf(NumTween(tween) <> Null) Then
			sprite.Alpha = NumTween(tween).value
		End If
		
		If (FlxG.Keys.JustPressed(KEY_SPACE)) Then
			currentEaseIndex += 1
			If (currentEaseIndex = easeInfo.Length()) currentEaseIndex = 0
		 	If (HasTween()) tween.Cancel()
		End If
		
		If (FlxG.Keys.JustPressed(KEY_UP)) Then
			currentTweenIndex += 1
			If (currentTweenIndex = MAX_TWEEN + 1) currentTweenIndex = 0
			If (HasTween()) tween.Cancel()
		End If
		
		If (FlxG.Keys.JustPressed(KEY_DOWN)) Then
			currentTweenIndex -= 1
			If (currentTweenIndex < 0) Then currentTweenIndex = MAX_TWEEN
			If (HasTween()) tween.Cancel()
		End If
		
		If ( Not HasTween() Or Not tween.active) Then
			sprite.Reset(min.x, min.y + (max.y - min.y) * 0.5)
			sprite.angle = 0
			sprite.Color = FlxG.BLUE
			sprite.Alpha = 1
		
			Select currentTweenIndex
				Case 0
					'The following types are supported: FlxTween.PERSIST (default), FlxTween.LOOPING, FlxTween.PINGPONG and FlxTween.ONESHOT
					Local varTween:VarTween = New VarTween(Null, FlxTween.PINGPONG) 'FlxTween.PINGPONG|FlxTween.BACKWARD to backward direction
					
					varTween.Tween(sprite, "x", max.x, DURATION, easeInfo.Get(currentEaseIndex).ease)
					tween = AddTween(varTween)
					
				Case 1
					Local multiVarTween:MultiVarTween = New MultiVarTween(Null, FlxTween.PINGPONG)
					
					Local properties:StringMap<Float> = New StringMap<Float>()
					properties.Insert("x", max.x)
					properties.Insert("angle", 180)
					
					multiVarTween.Tween(sprite, properties, DURATION, easeInfo.Get(currentEaseIndex).ease)
					tween = AddTween(multiVarTween)
					
				Case 2
					sprite.Reset(FlxG.Width * 0.5, FlxG.Height * 0.5)
				
					Local angleTween:AngleTween = New AngleTween(Null, FlxTween.PINGPONG)
					angleTween.Tween(0, 90, DURATION, easeInfo.Get(currentEaseIndex).ease)
					tween = AddTween(angleTween)
					
				Case 3
					sprite.Reset(FlxG.Width * 0.5, FlxG.Height * 0.5)
					
					Local colorTween:ColorTween = New ColorTween(Null, FlxTween.PINGPONG)
					
					colorTween.Tween(DURATION, $0090E9, $F01EFF, 1, 1, easeInfo.Get(currentEaseIndex).ease)
					tween = AddTween(colorTween)
					
				Case 4
					sprite.Reset(FlxG.Width * 0.5, FlxG.Height * 0.5)
				
					Local numTween:NumTween = New NumTween(Null, FlxTween.PINGPONG)
					
					numTween.Tween(1, 0, DURATION, easeInfo.Get(currentEaseIndex).ease)
					tween = AddTween(numTween)
					
				Case 5
					Local linearMotionTween:LinearMotion = New LinearMotion(Null, FlxTween.PINGPONG)
					
					linearMotionTween.SetMotion(sprite.x, sprite.y, max.x, sprite.y, DURATION, easeInfo.Get(currentEaseIndex).ease)
					linearMotionTween.SetObject(sprite)
					
					tween = AddTween(linearMotionTween)
					
				Case 6
					Local linearPath:LinearPath = New LinearPath(Null, FlxTween.PINGPONG)
					
					linearPath.AddPoint(sprite.x, sprite.y)
					linearPath.AddPoint(sprite.x + (max.x - min.x) * 0.5, min.y)
					linearPath.AddPoint(max.x, sprite.y)
					
					linearPath.SetMotion(DURATION, easeInfo.Get(currentEaseIndex).ease)
					linearPath.SetObject(sprite)
					
					tween = AddTween(linearPath)
					
				Case 7
					Local circularMotion:CircularMotion = New CircularMotion(Null, FlxTween.PINGPONG)
				
					circularMotion.SetMotion(FlxG.Width * 0.5, FlxG.Height * 0.5, sprite.width, 359, True, DURATION, easeInfo.Get(currentEaseIndex).ease)
					circularMotion.SetObject(sprite)
					
					tween = AddTween(circularMotion)
					
				Case 8
					Local cubicMotion:CubicMotion = New CubicMotion(Null, FlxTween.PINGPONG)
				
					cubicMotion.SetMotion(sprite.x, sprite.y, sprite.x + (max.x - min.x) * 0.25,
										max.y, sprite.x + (max.x - min.x) * 0.75, max.y, max.x,
										sprite.y, DURATION, easeInfo.Get(currentEaseIndex).ease)
					cubicMotion.SetObject(sprite)
					
					tween = AddTween(cubicMotion)
					
				Case 9
					Local quadMotion:QuadMotion = New QuadMotion(Null, FlxTween.PINGPONG)
				
					quadMotion.SetMotion(sprite.x, sprite.y, sprite.x + (max.x - min.x) * 0.5, min.y, max.x, sprite.y, DURATION, easeInfo.Get(currentEaseIndex).ease)
					quadMotion.SetObject(sprite)
					
					tween = AddTween(quadMotion)
					
				Case 10
					Local quadPath:QuadPath = New QuadPath(Null, FlxTween.PINGPONG)
					
					quadPath.AddPoint(sprite.x, sprite.y)
					quadPath.AddPoint(sprite.x + (max.x - min.x) * 0.5, min.y)
					quadPath.AddPoint(sprite.x + (max.x - min.x) * 0.5, max.y)
					quadPath.AddPoint(max.x, sprite.y)
				
					quadPath.SetMotion(DURATION * 1.5, easeInfo.Get(currentEaseIndex).ease)
					quadPath.SetObject(sprite)
					
					tween = AddTween(quadPath)
			End Select
			
			tweenText.Text = "Current tweening: " + FlxU.GetClassName(tween, True)
			easeText.Text = "Current ease function: " + easeInfo.Get(currentEaseIndex).name
		End If
	End Method

End Class