package
{

	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import LoaderImage;
	
	import PunchClip;
	
	import RunningClip;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	
	public class Window extends Sprite
	{	
		/**
		 * #Note @유영선
		 * _*Image 객체는 BitmapDefine에서 선언 된 이미지 객체를 저장하여 사용
		 * _posWindow 윈도우에 클릭 된 좌표를 저장하는 변수
		 * _childWindow 윈도우 클릭 시 생성되는 자식 윈도우의 값을 저장하는 변수
		 * _minFlag  
		 */
		private var _cRunningClip : RunningClip = new RunningClip();
		private var _cPunchClip : PunchClip = new PunchClip();
		
		private var _closeImage : Image;
		private var _contentsImage : Image;
		private var _minimzieImage : Image;
		private var _titleBaImage : Image;
		private var _revertImage : Image;
		
		private var _posWindow : Point = new Point();
		private var _childWindow : Vector.<Window> = new  Vector.<Window>;
		
		private var _minFlag : Boolean = false;		//최소화 인 경우 = ture
		private var _rootFlag : Boolean = false;	//첫 생성 된  윈도우창 = ture
		private var _currentFlag : Boolean = false;	//현재 선택 된 윈도우창  = ture
		/**
		 * 
		 * @param posMouse 마우스가 클릭 한 위치
		 * #Note @유영선 마우스 좌표를 받아서 Window 객체 생성 후 윈도우 창이 오류 없이 열렸다면 darwWindow 호출
		 */		
		public function Window(posMouse : Point, rootFlag: Boolean)
		{
			_posWindow.x = posMouse.x;
			_posWindow.y = posMouse.y;
			_rootFlag = rootFlag;
			
			if(_rootFlag == true)drawParent();		//부모 윈도우 창 파란색, 자식 윈도우창 주황색
			else drawChild();
			addEventListener(Event.ADDED_TO_STAGE, onDrawWindow);
		}
		/**
		 * 
		 * @param e
		 * #Note @유영선 마우스 클릭 위치를 중점으로 하는 윈도우 창 출력 (창, 타이틀바, X창, 최소화 창)
		 */		
		public function onDrawWindow(e:Event) : void
		{
			_contentsImage.x = _posWindow.x-_contentsImage.width/2;
			_contentsImage.y = _posWindow.y-_contentsImage.height/2;
			if(_contentsImage.x < 0 ) _contentsImage.x = 0;
			if(_contentsImage.y < _titleBaImage.height ) _contentsImage.y = _titleBaImage.height;
			
			if(_contentsImage.x > stage.stageWidth - _contentsImage.width) _contentsImage.x = stage.stageWidth - _contentsImage.width;
	
			_contentsImage.addEventListener(TouchEvent.TOUCH,onClickedcontents);
			addChild(_contentsImage);
		
			_titleBaImage.x = _contentsImage.x;
			_titleBaImage.y = _contentsImage.y-_titleBaImage.height;
			_titleBaImage.addEventListener(TouchEvent.TOUCH,onClickedtitleBar);
			addChild(_titleBaImage);
			
			_closeImage.x = _titleBaImage.x+_contentsImage.width-_closeImage.width;
			_closeImage.y = _titleBaImage.y;
			_closeImage.addEventListener(TouchEvent.TOUCH,onClickedClose);
			addChild(_closeImage);
			
			_minimzieImage.x = _closeImage.x-_minimzieImage.width;
			_minimzieImage.y = _titleBaImage.y;
			_minimzieImage.addEventListener(TouchEvent.TOUCH,onClickedminimzie);
			addChild(_minimzieImage);
			
			_cRunningClip.getClip().x = _contentsImage.x + _cRunningClip.getClip().width;
			_cRunningClip.getClip().y = _contentsImage.y + _cRunningClip.getClip().height;	
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDownEvent);
			
			Starling.juggler.add(_cRunningClip.getClip());	//애니매이션 시작
			addChild ( _cRunningClip.getClip() );
		}
		/**
		 * 
		 * @param e
		 * Note @유영선 Space입력 시 펀치 발사 부분
		 * 펀치의 시작 화면은 캐릭터의 위치에서 약간 조절
		 * 위치 설정 후 애니매이션 시작
		 */		
		private function onKeyDownEvent(e:KeyboardEvent) : void
		{
			 
			if(e.keyCode == Keyboard.SPACE)
 			{
				for(var i:int=0; i < RunningClip.MAX_RUNFRAME_COUNT; i++)
					_cRunningClip.getClip().setFrameTexture(i,RunningClip.frames[4]);
				
				_cPunchClip.getClip().x = _cRunningClip.getClip().x + 50;
				_cPunchClip.getClip().y = _cRunningClip.getClip().y + 10;
				
 				Starling.juggler.add(_cPunchClip.getClip());	//애니매이션 시작
				
				addChild ( _cPunchClip.getClip() ); 
				addEventListener(Event.ENTER_FRAME,onFrame);
			}
		}
		
		private function onFrame(e:Event) : void
		{
			_cPunchClip.getClip().x+=5;
			if(_cPunchClip.getClip().x > 2*_posWindow.x- _cRunningClip.getClip().x)
			{
				removeEventListener(Event.ENTER_FRAME,onFrame);
				
				for(var i:int=0; i < RunningClip.MAX_RUNFRAME_COUNT; i++)
					_cRunningClip.getClip().setFrameTexture(i,RunningClip.frames[i]);
				 
				removeChild(_cPunchClip.getClip());
			}
		}
		/**
		 * 
		 * @param e 마우스 클릭 위치
		 * #Note @유영선 윈도우 창을 클릭 할 경우 자식 윈도우 생성
		 */		
		private function onClickedcontents(e:TouchEvent): void
		{
			var touch:Touch = e.getTouch(stage);
			if(!touch) return;
			var pos : Point = touch.getLocation(stage);
			
			if(touch.phase == TouchPhase.BEGAN)
			{
				
				_childWindow.push(new Window(pos,false));
				addChild(_childWindow[_childWindow.length-1]);
				trace("자식 생성");
			}
		}
		/**
		 * 
		 * @param e 마우스 클릭 위치
		 * #Note @유영선 타이트바 클릭 후 이동시 윈도우 전체 이동 
		 */		
		private function onClickedtitleBar(e:TouchEvent): void
		{
			var touch:Touch = e.getTouch(stage);
			if(!touch) return;
		
			if(touch.phase == TouchPhase.MOVED)
			{
				this.alpha = 0.5;
				var currentPos : Point = touch.getLocation(parent);
				var previousPos : Point = touch.getPreviousLocation(parent);
				var subValue : Point = currentPos.subtract(previousPos);
				
				this.x += subValue.x;
				this.y += subValue.y; 
				trace("이동");
			}
			else if(touch.phase == TouchPhase.ENDED) this.alpha = 1;	//이동 끝나면 alpah값 다시 원상 복귀
		}
		/**
		 * 
		 * @param e 마우스 클릭 위치
		 * #Note @유영선 종료 아이콘 클릭 시 부모, 자식 윈도우 종료, 리스너, 애니매이션 제거
		 */	
		private function onClickedClose(e:TouchEvent): void
		{
			var touch:Touch = e.getTouch(stage);
			if(!touch) return;
			
			if(touch.phase == TouchPhase.BEGAN)
			{
				_currentFlag = 1;
				release();
			}
		}
		/**
		 * 
		 * @param e 마우스 클릭 위치
		 * #Note @유영선 최소화 클릭 시 윈도우창이 최소화가 되고 아이콘이 최대화 아이콘으로 변경 
		 */	
		private function onClickedminimzie(e:TouchEvent): void
		{
			var touch:Touch = e.getTouch(stage);
			if(!touch) return;
			
			if(touch.phase == TouchPhase.BEGAN)
			{
				if(_minFlag == false)
				{
				
					_revertImage.x = _closeImage.x-_minimzieImage.width;;
					_revertImage.y = _titleBaImage.y;
					
					_minimzieImage.removeEventListener(TouchEvent.TOUCH,onClickedminimzie);
					_revertImage.addEventListener(TouchEvent.TOUCH,onClickedminimzie);
					removeChild(_minimzieImage,false);
					
					addChild(_revertImage);//최소화 아이콘을 최대화로 변경
					
					_contentsImage.visible = false;
					_cRunningClip.getClip().visible = false;
					_minFlag = true;
					
					for(var i :int = 0; i<_childWindow.length;i++)
					{
						_childWindow[i].visible = false;
					}
				
				}
				else
				{
					_minimzieImage.x = _closeImage.x-_minimzieImage.width;
					_minimzieImage.y = _titleBaImage.y;
					
					_revertImage.removeEventListener(TouchEvent.TOUCH,onClickedminimzie);
					_minimzieImage.addEventListener(TouchEvent.TOUCH,onClickedminimzie);
					removeChild(_revertImage,false);
					addChild(_minimzieImage);//최대화 아이콘을 최소화로 변경
					
					_contentsImage.visible = true;
					_cRunningClip.getClip().visible = true;
					_minFlag = false;
					
					for(var j :int = 0; j<_childWindow.length;j++)
					{
						_childWindow[j].visible = true;
					}
				}
			}
		}
		/**
		 *Name @유영선 부모윈도우창 (파란색) 자식윈도우창(주황색) 
		 * 		 */		
		public function drawParent() : void 
		{
			
			_closeImage = new Image(LoaderImage.sCloseTexture);
			_contentsImage = new Image(LoaderImage.sContentTexture);
			_minimzieImage = new Image(LoaderImage.sMinimizeTexture);
			_titleBaImage = new Image(LoaderImage.sTitleTexture);
			_revertImage = new Image(LoaderImage.sRevertTexture);
		}
		
		public function drawChild(): void
		{
			
			_closeImage = new Image(LoaderImage.sCloseTextureChild);
			_contentsImage = new Image(LoaderImage.sContentTextureChild);
			_minimzieImage = new Image(LoaderImage.sMinimizeTextureChild);
			_titleBaImage = new Image(LoaderImage.sTitleTextureChild);
			_revertImage = new Image(LoaderImage.sRevertTextureChild);
		}
		public function release() : void
		{
			while(0 < _childWindow.length)
				_childWindow.pop().release();	
			
			if(_rootFlag != true && _currentFlag == true )
				Window(this.parent)._childWindow.pop();
			
			trace("해제");
			
			removeEventListener(Event.ENTER_FRAME,onFrame);
			removeEventListener(Event.ADDED_TO_STAGE, onDrawWindow);
			_closeImage.removeEventListener(TouchEvent.TOUCH,onClickedClose);
			_contentsImage.removeEventListener(TouchEvent.TOUCH,onClickedcontents);
			_titleBaImage.removeEventListener(TouchEvent.TOUCH,onClickedtitleBar);
			_minimzieImage.removeEventListener(TouchEvent.TOUCH,onClickedminimzie);
			_revertImage.removeEventListener(TouchEvent.TOUCH,onClickedminimzie);
			removeChildren();
		}
	}
}