package com.aaronbegley.platforming.view.viewsprite.models
{
	
	import com.aaronbegley.platforming.view.viewsprite.events.SpriteModelEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class SpriteModel extends Rectangle implements IEventDispatcher
	{

		private var _eventDispatcher:IEventDispatcher;

	//	private var _scaleX:Number;
	//	private var _scaleY:Number;

		public function SpriteModel(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0)
		{
			super(x, y, width, height);
		}


		public function setBounds(x:Number, y:Number, w:Number, h:Number):void
		{
			this.x = x ? x : 0;
			this.y = y ? y : 0;
			this.width = w ? w : 0;
			this.height = h ? h : 0;

			dispatchChangeEvent();
		}
		
		
		
		//
		//  this is a hack 'till we can calculate the native width in the controller
		
		public function setNativeWidth(value:Number):void
		{
			this.width = value;
		}
		
		public function setNativeHeight(value:Number):void
		{
			this.width = height;
		}
		
	/*	public function set scaleX(value:Number):void
		{
			_scaleX = value;
			dispatchChangeEvent();
		}
	
		public function get scaleX():Number
		{
			return _scaleX;
			dispatchChangeEvent();
		}


		public function set scaleY(value:Number):void
		{
			_scaleY = value;
			dispatchChangeEvent();
		}

		public function get scaleY():Number
		{
			return _scaleY;
			dispatchChangeEvent();
		}
	*/
		//////////////////////////////////////////////////////////////////
		//
		//  Rectangle overrides
		//
		
		// cant override x,y to dispatch change event... (public fields)

		override public function set bottom(value:Number):void
		{
			super.bottom = value;
		//	dispatchChangeEvent();
		}

		override public function set bottomRight(value:Point):void
		{
			super.bottomRight = value;
		//	dispatchChangeEvent();
		}

		override public function set top(value:Number):void
		{
			super.top = value;
		//	dispatchChangeEvent();
		}

		override public function set topLeft(value:Point):void
		{
			super.topLeft = value;
		//	dispatchChangeEvent();
		}



		//////////////////////////////////////////////////////////////////
		//
		//  change event dispatching
		//

		private function dispatchChangeEvent():void
		{
			dispatchEvent(new SpriteModelEvent(SpriteModelEvent.CHANGE));
		}


		//////////////////////////////////////////////////////////////////
		//
		//  IEventDispatcher implementation
		//

		private function get eventDispatcher():IEventDispatcher
		{
			if (!_eventDispatcher)
				_eventDispatcher = new EventDispatcher(this);

			return _eventDispatcher;
		}

		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}

		public function dispatchEvent(event:Event):Boolean
		{
			return eventDispatcher.dispatchEvent(event);
		}

		public function hasEventListener(type:String):Boolean
		{
			return eventDispatcher.hasEventListener(type);
		}

		public function willTrigger(type:String):Boolean
		{
			return eventDispatcher.willTrigger(type);
		}
	}
}