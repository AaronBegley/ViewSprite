package com.aaronbegley.platforming.view.viewsprite.interfaces
{
	import com.aaronbegley.platforming.view.viewsprite.controllers.SpriteModelController;
	import com.aaronbegley.platforming.view.viewsprite.events.SpriteModelEvent;
	import com.aaronbegley.platforming.view.viewsprite.models.SpriteModel;
	
	
	public interface IViewSprite
	{
		function get model():SpriteModel;
		function get modelController():SpriteModelController;
	//	function get rendering():Boolean;
	//	function handleProxyChange(e:SpriteProxyEvent):void;
		function render():void;
		function invalidate():void;
	}
}