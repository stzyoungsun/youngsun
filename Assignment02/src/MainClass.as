package
{
	import LoaderImage;
	import Mouse;
	import Window;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	
	public class MainClass extends Sprite
	{
		/**
		 *Note @유영선
		 * _mMonse 마우스 클랙스 객체
		 * _mWindow 윈도우 클래스 객체 
		 */		
		private var _cMouse : Mouse = new Mouse();
		private var _cWindow : Vector.<Window>=new Vector.<Window>; 
		private var _cLoaderImage : LoaderImage;
		
		private  var _completeLoadImage : Function;
		private  var _progressLoadImage : Function;
		
		private var _progressTextField : TextField; 
		private var _progressText : String = "";
		public function MainClass() 
		{
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		public function initialize() : void
		{
			
			_progressTextField = new TextField(200,200,_progressText);
			_progressTextField.x = 400;
			_progressTextField.y = 400;
			_progressTextField.border = true;
			
			stage.addChild(_progressTextField);
			
			_completeLoadImage = completeLoadImage;
			_progressLoadImage = progressLoadImage;
			
			_cLoaderImage = new LoaderImage(_completeLoadImage, _progressLoadImage);
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
					stage.removeChild(_progressTextField);
					
					_cMouse.setMousePoint(touch.getLocation(stage));
					_cWindow.push(new Window(_cMouse.getMousePoint(),true));
					
					stage.addChild(_cWindow[_cWindow.length-1]);
				}
				
			}
		}
		public function completeLoadImage() : void
		{
			stage.addEventListener(TouchEvent.TOUCH,onClickedEvent);
			_progressText = "로딩 완료";
			_progressTextField.text = _progressText;
		}
		public function progressLoadImage(progressCount : int) : void
		{
			_progressText = "로딩 중 : " + String(progressCount);
		
			_progressTextField.text = _progressText;	
		}
	}
}