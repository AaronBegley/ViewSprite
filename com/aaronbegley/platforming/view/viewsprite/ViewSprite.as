package com.aaronbegley.platforming.view.viewsprite
{

	import com.aaronbegley.platforming.mxml.interfaces.IMXMLSprite;
	import com.aaronbegley.platforming.view.viewsprite.controllers.SpriteModelController;
	import com.aaronbegley.platforming.view.viewsprite.events.SpriteModelEvent;
	import com.aaronbegley.platforming.view.viewsprite.interfaces.IViewSprite;
	import com.aaronbegley.platforming.view.viewsprite.models.SpriteModel;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	[DefaultProperty("children")]
	
	public class ViewSprite extends Sprite implements IViewSprite, IMXMLSprite
	{
		protected var _model:SpriteModel;
		protected var _modelController:SpriteModelController;

		public var setX:Number;
		public var setY:Number;
		public var setWidth:Number;
		public var setHeight:Number;


		public function ViewSprite()
		{
			init();
		}

		private function init():void
		{
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage, false, 0, true);
		}
		
		//////////////////////////////////////////////////////////////////
		//
		//  IViewSprite implementation
		//

		public function get model():SpriteModel
		{
			if (!_model)
				_model = new SpriteModel();

			return _model;
		}

		public function get modelController():SpriteModelController
		{
			if (!_modelController)
				_modelController = new SpriteModelController(model, this);

			return _modelController;
		}


		public function get nativeWidth():Number
		{
			return super.width;
		}


		public function get nativeHeight():Number
		{
			return super.height;
		}

		public function render():void
		{
			applyModelPropertiesToView();
		}
		
		public function invalidate():void
		{
			modelController.updateSpriteModel();
		}
		

		//////////////////////////////////////////////////////////////////
		//
		//  IMXMLSprite implementation
		//
		private var _children:Array = new Array();
		
		[ArrayElementType("flash.display.DisplayObject")]
		public function set children(value:Array):void
		{
			_children = new Array();
			
			for each(var child:DisplayObject in value)
			{					
				addChild(child as DisplayObject);
				_children.push(child);
			}
		}
		
		public function get children():Array
		{
			return _children;
		}


		//////////////////////////////////////////////////////////////////
		//
		//  protected methods
		//
		
		

		protected function handleModelChange(e:SpriteModelEvent):void
		{	
			addEventListener(Event.ENTER_FRAME, handleEnterFrame, false, 0, true);
		}
		
		
		protected function handleChildModelChange(e:SpriteModelEvent):void
		{
			invalidate();
		}
		
		protected function handleAddedToStage(e:Event):void
		{
			// stop listening for ADDED_TO_STAGE and start listening for REMOVED_FROM_STAGE
			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage, false, 0, true);
			
			// when on the stage start responting to SpriteModel CHANGE events
			model.addEventListener(SpriteModelEvent.CHANGE, handleModelChange, false, 0, true);
			
			invalidate();
		}
		
		protected function handleRemovedFromStage(e:Event):void
		{
			// stop listening for ADDED_TO_STAGE and start listening for ADDED_TO_STAGE
			removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage, false, 0, true);
			
			// if not on the stage don't monitor SpriteMode CHANGE event
			model.removeEventListener(SpriteModelEvent.CHANGE, handleModelChange);
		}
		


		protected function handleEnterFrame(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
		
		//	var p:DisplayObject = parent;
			
		//	if (p is IViewSprite)
		//		IViewSprite(p).invalidate();
				
			render();
		}
		
		
		protected function applyModelPropertiesToView():void
		{
			graphics.clear();
			graphics.beginFill(0xFF0000, .5);
			graphics.drawRect(0, 0, model.width, model.height);

			if (_xDirty)
			{
				x = model.x;
				_xDirty = false;
			}

			if (_yDirty)
			{
				y = model.y;
				_yDirty = false;
			}
		}



		//////////////////////////////////////////////////////////////////
		//
		//  DisplayObject overrides
		//		

		// .x

		private var _xDirty:Boolean;

		override public function set x(value:Number):void
		{
			//	if (value == setX)
			//		return;

			if (_xDirty)
				super.x = value;
			else
			{
				setX = value;
				_xDirty = true;
				invalidate();
			}
		}

		override public function get x():Number
		{
			return model.x;
		}


		// .y

		private var _yDirty:Boolean;

		override public function set y(value:Number):void
		{
			//	if (value == setY)
			//		return;

			if (_yDirty)
				super.y = value;
			else
			{
				setY = value;
				_yDirty = true;
				invalidate();
			}
		}

		override public function get y():Number
		{
			return model.y;
		}


		// .width

		override public function set width(value:Number):void
		{
			//	if (value == setWidth)
			//		return;

			setWidth = value;
			invalidate();
		}

		override public function get width():Number
		{
			return model.width;
		}


		// .height

		override public function set height(value:Number):void
		{
			//	if (value == setHeight)
			//		return

			setHeight = value;
			invalidate();
		}

		override public function get height():Number
		{
			return model.height;
		}



		// .addChild, .removeChild, .addChildAt

		override public function addChild(child:DisplayObject):DisplayObject
		{
			super.addChild(child);

			if (child is IViewSprite)
				IViewSprite(child).model.addEventListener(SpriteModelEvent.CHANGE, handleChildModelChange);				
			
			invalidate();
				
			return child;
		}

		override public function removeChild(child:DisplayObject):DisplayObject
		{
			super.removeChild(child);
			invalidate();
			return child;
		}

		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			super.addChildAt(child, index);
			invalidate();
			return child;
		}

		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = getChildAt(index);
			super.removeChildAt(index);
			invalidate();
			return child;
		}
		
		// 
		/* 
		override public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle
		{
			super.getBounds(targetCoordinateSpace);	
			return super.getBounds(targetCoordinateSpace);
		}
 		*/


	}
}