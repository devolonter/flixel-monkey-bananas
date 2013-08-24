Strict

Import flixel
Import bunny

Class PlayState Extends FlxState Implements FlxButtonClickListener

	Global MinX:Int
	
	Global MinY:Float
	
	Global MaxX:Float
	
	Global MaxY:Float
	
	Field incBunnies:Int
	
Private
	Field gravity:Float
	
	Field bunnies:FlxGroup
	
	Field bunny:Bunny
	
	Field pirate:FlxSprite
	
	Field bg:FlxTileblock
	
	Field bgSize:Int
	
	Field addBunniesBtn:FlxButton
	
	Field removeBunniesBtn:FlxButton
	
	Field bunnyCounter:FlxText
	
	Field fpsCounter:FlxText
	
	Field lastFpsTime:Int
	
	Field fps:Int
	
Public
	Method Create:Void()
		gravity = 5
		incBunnies = 100
		
		bgSize = 32
		
		PlayState.MinX = 0
		PlayState.MinY = 0
		
		PlayState.MaxX = FlxG.Width
		PlayState.MaxY = FlxG.Height
		
		Local bgWidth:Int = Ceil(FlxG.Width / bgSize) * bgSize
		Local bgHeight:Int = Ceil(FlxG.Height / bgSize) * bgSize
		
		bg = New FlxTileblock(0, 0, bgWidth, bgHeight)
		bg.LoadTiles("grass")
		Add(bg)
		
		bunnies = New FlxGroup()
		AddBunies(incBunnies)
		Add(bunnies)
		
		pirate = New FlxSprite()
		pirate.LoadGraphic("pirate")
		Add(pirate)
		
		addBunniesBtn = New FlxButton(FlxG.Width - 80 - 20, 20, "Add Bunnies", Self)
		Add(addBunniesBtn)
		
		removeBunniesBtn = New FlxButton(20, 20, "Remove", Self)
		Add(removeBunniesBtn)
		
		bunnyCounter = New FlxText(0, 10, FlxG.Width - 20, "Bunnies: " + bunnies.Length)
		bunnyCounter.SetFormat(FlxText.SYSTEM_FONT, 22, FlxG.BLACK, FlxText.ALIGN_CENTER)
		Add(bunnyCounter)
		
		fpsCounter = New FlxText(0, bunnyCounter.y + bunnyCounter.height + 10, FlxG.Width - 20, FlxG.Width + "x" + FlxG.Height + "~n" + "FPS: " + FlxG.Updaterate + "/" + UpdateRate())
		fpsCounter.SetFormat(FlxText.SYSTEM_FONT, 22, FlxG.BLACK, FlxText.ALIGN_CENTER)
		Add(fpsCounter)
		
		FlxG.Mouse.Show()
		lastFpsTime = 0
		fps = 0
	End Method
	
	Method Draw:Void()
		Local t:Int = Millisecs()
	
		If (t - lastFpsTime >= 1000) Then
			If (fps = 0) fps = FlxG.Updaterate
		
			fpsCounter.Text = FlxG.Width + "x" + FlxG.Height + "~n" + "FPS: " + fps + "/" + UpdateRate()
			lastFpsTime = t
			fps = 0
		End If
		
		Super.Draw()
		
		fps += 1
	End Method
	
	Method Update:Void()
		Super.Update()
		
		Local t:Int = Millisecs()
		pirate.x = (FlxG.Width - pirate.width) * (0.5 + 0.5 * Sin(t / 50.0))
		pirate.y = FlxG.Height - 1.3 * pirate.height + 70 - 30 * Sin(t / 1.5)
	End Method
	
	Method OnButtonClick:Void(button:FlxButton)
		Select button
			Case addBunniesBtn
				AddBunies(incBunnies)
				
			Case removeBunniesBtn
				RemoveBunnies(incBunnies)
		End Select
		
		bunnyCounter.Text = "Bunnies: " + bunnies.Length
	End Method
	
Private
	Method AddBunies:Void(numToAdd:Int)
		For Local i:Int = 0 Until numToAdd
			bunny = Bunny(bunnies.Recycle(Bunny.__CLASS__))
			bunny.Create(gravity)
			bunnies.Add(bunny)
		Next
	End Method
	
	Method RemoveBunnies:Void(numToRemove:Int)
		If (bunnies.Length = 0) Return

		For Local i:Int = 0 Until numToRemove
			bunny = Bunny(bunnies.GetFirstExtant())
			bunnies.Remove(bunny, True)
			bunny.Destroy()
			bunny = Null
		Next
	End Method

End Class