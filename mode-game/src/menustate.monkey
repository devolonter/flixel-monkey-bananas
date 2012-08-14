Strict

Import flixel
Import assets
Import playstate

Class MenuState Extends FlxState Implements FlxButtonClickListener, FlxCameraFadeListener, FlxReplayListener
	
	Field gibs:FlxEmitter
	Field playButton:FlxButton
	Field title1:FlxText
	Field title2:FlxText
	Field fading:Bool
	Field timer:Float
	Field attractMode:Bool
	
	Method Create:Void()
		'pre-load all sounds
		For Local res:String = EachIn FlxAssetsManager.AllSounds()
			FlxG.LoadSound(res).Kill()
		Next
	
		FlxG.SetBgColor($FF131C1B)
		
		gibs = New FlxEmitter(FlxG.Width / 2 - 50, FlxG.Height / 2 - 10)
		gibs.SetSize(100, 30)
		gibs.SetYSpeed(-200, -20)
		gibs.SetRotation(-720, 720)
		gibs.gravity = 100
		gibs.MakeParticles(ImageAssets.SPAWNER_GIBS, 650, 0, True, 0)
		Add(gibs)
		
		title1 = New FlxText(FlxG.Width + 16, FlxG.Height / 3, 64, "mo")
		title1.Size = 32
		title1.Color = $3A5C39
		title1.velocity.x = -FlxG.Width
		Add(title1)
		
		title2 = New FlxText(-60, title1.y, title1.width, "de")
		title2.Size = title1.Size
		title2.Color = title1.Color
		title2.velocity.x = FlxG.Width
		Add(title2)
		
		fading = False
		timer = 0
		attractMode = False
		
		FlxG.Mouse.Show(ImageAssets.CURSOR)
	End Method
	
	Method Destroy:Void()
		Super.Destroy()
		gibs = Null
		playButton = Null
		title1 = Null
		title2 = Null
	End Method
	
	Method Update:Void()
		Super.Update()
		
		If (title2.x > title1.x + title1.width - 4) Then
			title2.x = title1.x + title1.width - 4
			title1.velocity.x = 0
			title2.velocity.x = 0
			
			FlxG.Play(SoundAssets.HIT_1)
			FlxG.Flash($FFD8EBA2, .5)
			FlxG.Shake(.035, .5)
			title1.Color = $D8EBA2
			title2.Color = $D8EBA2
			gibs.Start(True, 5)
			title1.angle = FlxG.Random() * 30 - 15
			title2.angle = FlxG.Random() * 30 - 15
			
			Local text:FlxText
			text = New FlxText(FlxG.Width / 2 - 50, FlxG.Height / 3 + 39, 100, "by Adam Atomic")
			text.Alignment = FlxText.ALIGN_CENTER
			text.Color = $3A5C39
			text.Size = 8
			Add(text)
			
			Local flixelButton:FlxButton = New FlxButton(FlxG.Width / 2 - 40, FlxG.Height / 3 + 54, 
				"flixel.org", New FlixelButtonClickListener())
			flixelButton.Color = $FF729954
			flixelButton.label.Color = $FFD8EBA2
			Add(flixelButton)
			
			Local dannyButton:FlxButton = New FlxButton(flixelButton.x, flixelButton.y + 22, 
				"music", New DannyButtonClickListener())
			dannyButton.Color = flixelButton.Color
			dannyButton.label.Color = flixelButton.label.Color
			Add(dannyButton)
			
			text = New FlxText(FlxG.Width / 2 - 40, FlxG.Height / 3 + 139, 80, "X+C TO PLAY")
			text.Color = $729954
			text.Alignment = FlxText.ALIGN_CENTER
			Add(text)
			
			playButton = New FlxButton(flixelButton.x, flixelButton.y + 82, "CLICK HERE", Self)
			playButton.Color = flixelButton.Color
			playButton.label.Color = flixelButton.label.Color
			Add(playButton)
		End If
		
		timer += FlxG.Elapsed		
		If (timer > 10) attractMode = True
		
		If ((FlxG.Keys.X And FlxG.Keys.C) Or attractMode) Then
			If (Not fading) Then
				fading = True
				FlxG.Play(SoundAssets.HIT_2)
				FlxG.Flash($FFD8EBA2, .5)
				FlxG.Fade($FF131C1B, 1, Self)
			End If
		End If
	End Method
	
	Method OnButtonClick:Void()		
		playButton.exists = False
		FlxG.Play(SoundAssets.HIT_2)
	End Method
	
	Method OnFadeComplete:Void()
		If (attractMode) Then
			If (FlxG.Random() < 0.5) Then
				FlxG.LoadReplay(FlxAssetsManager.GetString(StringAssests.ATTRACT_1) ,new PlayState(),[KEY_ESCAPE, KEY_X, KEY_C], 22, Self)
			Else
				FlxG.LoadReplay(FlxAssetsManager.GetString(StringAssests.ATTRACT_2) ,new PlayState(),[KEY_ESCAPE, KEY_X, KEY_C], 22, Self)
			End If
		Else
			FlxG.SwitchState(New PlayState())			
		End If		
	End Method
	
	Method OnReplayComplete:Void()
		FlxG.Fade($ff131c1b, 1, New DemoCompleteListener())
	End Method

End Class

Class DemoCompleteListener Implements FlxCameraFadeListener
	
	Method OnFadeComplete:Void()
		FlxG.StopReplay()
		FlxG.ResetGame()
	End Method

End Class

Class DannyButtonClickListener Implements FlxButtonClickListener

	Method OnButtonClick:Void()
		FlxU.OpenURL("http://dbsoundworks.com")
	End Method
	
End Class

Class FlixelButtonClickListener Implements FlxButtonClickListener

	Method OnButtonClick:Void()
		FlxU.OpenURL("http://flixel.org")
	End Method
	
End Class