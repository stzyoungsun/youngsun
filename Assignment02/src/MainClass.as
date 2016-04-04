package
{
	import Mouse;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MainClass extends Sprite
	{
		private var _mMouse : Mouse = new Mouse();

		public function MainClass() 
		{
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		public function initialize() : void
		{
			
			stage.addEventListener(TouchEvent.TOUCH,onClickedEvent);
		}
		
		public function progress() : void
		{
			
		}
		
		private function onClickedEvent(e:TouchEvent): void
		{
			var touch:Touch = e.getTouch(stage);
			if(!touch) return;
			
			if(touch.phase == TouchPhase.BEGAN)
			{
				_mMouse.setMousePoint(touch.getLocation(stage));
				
				trace(_mMouse.getMoisePoint().x);
				trace(_mMouse.getMoisePoint().y);
			}
		}
	}
}