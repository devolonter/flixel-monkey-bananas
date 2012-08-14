Strict

Import flixel
Import assets
Import playstate


Class VictoryState Extends FlxState Implements FlxCameraFadeListener

Private
	Field _timer:Float
	Field _fading:Bool

Public
	Method Create:Void()
		_timer = 0
		_fading = False
		FlxG.Flash($ffd8eba2)
		
		Local gibs:FlxEmitter = New FlxEmitter(0,-50)
		gibs.SetSize(FlxG.Width,0)
		gibs.SetXSpeed()
		gibs.SetYSpeed(0,100)
		gibs.SetRotation(-360,360)
		gibs.gravity = 80
		gibs.MakeParticles(ImageAssets.SPAWNER_GIBS,800,0,True,0)
		Add(gibs)
		gibs.Start(False,0,0.005)
		
		Local text:FlxText = new FlxText(0,FlxG.Height/2-35,FlxG.Width,"VICTORY~n~nSCORE: "+FlxG.Score)
		text.SetFormat(FlxText.SYSTEM_FONT,16,$d8eba2,FlxText.ALIGN_CENTER)
		Add(text)
	End Method
	
	Method Update:Void()
		Super.Update()
		
		If (Not _fading) Then
			_timer += FlxG.Elapsed
			
			If ((_timer > .35 And _timer > 10) Or FlxG.Keys.JustPressed(KEY_X) Or FlxG.Keys.JustPressed(KEY_C)) Then
				_fading = True
				FlxG.Play(SoundAssets.HIT_2)
				FlxG.Fade($ff131c1b,2,Self)
			End If
		End If
	End Method
	
	Method OnFadeComplete:Void()
		FlxG.SwitchState(New PlayState())
	End Method
	
End Class