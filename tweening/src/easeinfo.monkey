Strict

Import flixel

Class EaseInfo
	
	Field name:String
	
	Field ease:FlxEaseFunction
	
	Method New(name:String, ease:FlxEaseFunction)
		Self.name = name
		Self.ease = ease
	End Method

End Class