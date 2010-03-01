package com.aaronbegley.platforming.view.viewsprite.controllers
{
	import com.aaronbegley.platforming.view.viewsprite.ViewSprite;
	import com.aaronbegley.platforming.view.viewsprite.interfaces.IViewSprite;
	import com.aaronbegley.platforming.view.viewsprite.models.SpriteModel;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	[DefaultProperty("children")]

	public class SpriteModelController
	{
		protected var _spriteModel:SpriteModel;
		protected var _viewSprite:ViewSprite;

		public function SpriteModelController(spriteModel:SpriteModel = null, viewSprite:ViewSprite = null)
		{
			if (!spriteModel || !viewSprite)
				throw new Error("SpriteProxyController must pass in both a SpriteProxy adn a ProxiedSprite into it's constructor");

			_spriteModel = spriteModel;
			_viewSprite = viewSprite;

		}

		public function updateSpriteModel():void
		{
			// 1.
			layoutChildren();

			// 2.
			setBounds();

			// 3.
		//	if (_viewSprite.parent is IViewSprite)
		//		IViewSprite(_viewSprite.parent).invalidate();
		}

		protected function layoutChildren():void
		{

			//
			//  abstract function.  To be called via override.


		/* example code:

		   for each (var child:DisplayObject in _viewSprite.children)
		   {
		   layout each child by setting x,y,width, or height


		   or...

		   layout each child via if (child is IViewSprite)
		   IViewSprite(child).model.setBounds();
		   .
		   .
		   .

		   }

		 */

		}

		protected function setBounds():void
		{
			var _x:Number;
			var _y:Number;
			var _w:Number;
			var _h:Number;

			_x = _viewSprite.setX ? _viewSprite.setX : 0;
			_y = _viewSprite.setY ? _viewSprite.setY : 0;
			_w = _viewSprite.setWidth ? _viewSprite.setWidth : nativeBounds(_viewSprite).width;
			_h = _viewSprite.setHeight ? _viewSprite.setHeight : nativeBounds(_viewSprite).height;

			_spriteModel.setBounds(_x, _y, _w, _h);
		}

		/*
			
			this recreates the default sprite width and height behaviour.
		
		*/
		private function nativeBounds(viewSprite:ViewSprite):Rectangle
		{
			// if there are no children return;
			if (viewSprite.children.length == 0)
				return new Rectangle();

			// else return a rectangle that includes all the children.
			var bounds:Rectangle = new Rectangle();
			
			for each (var child:DisplayObject in viewSprite.children)
			{
				var childBounds:Rectangle = new Rectangle(child.x, child.y, child.width, child.height);
				
				if ((childBounds.width + child.x) >= bounds.width)
					bounds.width = childBounds.width + child.x;

				if ((childBounds.height + child.y) >= bounds.height)
					bounds.height = childBounds.height + child.y;
			}

			return bounds;
		}


	}
}