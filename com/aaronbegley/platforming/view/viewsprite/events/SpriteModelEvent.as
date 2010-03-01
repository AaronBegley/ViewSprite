package com.aaronbegley.platforming.view.viewsprite.events
{
	import flash.events.Event;

	public class SpriteModelEvent extends Event
	{
		public static const CHANGE:String = "change";
		
		public function SpriteModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}