package
{
	import Mouse;
	
	import Window;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	
	public class MainClass extends Sprite
	{
		private var _mMouse : Mouse = new Mouse();
		private var _mWindow : Vector.<Window>=new Vector.<Window>; 
		
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
		/**
		 * 
		 * @param e 현재 마우스 위치
		 * Note @유영선 main 터치 이벤트 함수
		 * 클릭 위치 마우스 좌표가 이미 윈도우가 생성 되어있는지를 체크하고 없으면 윈도우 창을 만듭니다.
		 */		
		private function onClickedEvent(e:TouchEvent): void
		{
			var touch:Touch = e.getTouch(stage,TouchPhase.BEGAN);
		
			
			if(touch)
			{
				if(touch.target == stage)
				{
					_mMouse.setMousePoint(touch.getLocation(stage));
					_mWindow.push(new Window(_mMouse.getMousePoint()));
					
					stage.addChild(_mWindow[_mWindow.length-1]);
					trace(_mMouse.getMousePoint().x);
					trace(_mMouse.getMousePoint().y);
				}
				
			}
		}
		/**
		 * 
		 * @return 클릭 한 위치에 윈도우가 있을 경우 ture 없을 경우 false
		 * NOTE @유영선 이미 생성된 윈도우가 있는 것을 확인하는 함수
		 */		
	}
}