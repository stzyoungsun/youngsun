package
{

	import flash.geom.Point;
	import BitmapDefine;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class Window extends Sprite
	{	
		/**
		 * #Note @유영선
		 * _*Image 객체는 BitmapDefine에서 선언 된 이미지 객체를 저장하여 사용
		 * _posWindow 윈도우에 클릭 된 좌표를 저장하는 변수
		 * _childWindow 윈도우 클릭 시 생성되는 자식 윈도우의 값을 저장하는 변수
		 * _minFlag  
		 */		
		private var _closeImage : Image = new Image(Texture.fromEmbeddedAsset(BitmapDefine._closePNG));
		private var _contentsImage : Image = new Image(Texture.fromEmbeddedAsset(BitmapDefine._contentsPNG));
		private var _minimzieImage : Image = new Image(Texture.fromEmbeddedAsset(BitmapDefine._minimziePNG));
		private var _titleBaImage : Image = new Image(Texture.fromEmbeddedAsset(BitmapDefine._titleBarPNG));
		private var _revertImage : Image = new Image(Texture.fromEmbeddedAsset(BitmapDefine._revertPNG));
		
		private var _posWindow : Point = new Point();
		private var _childWindow : Window = null;
		
		private var _minFlag : Boolean = false;
		/**
		 * 
		 * @param posMouse 마우스가 클릭 한 위치
		 * #Note @유영선 마우스 좌표를 받아서 Window 객체 생성 후 윈도우 창이 오류 없이 열렸다면 darwWindow 호출
		 */		
		public function Window(posMouse : Point)
		{
			_posWindow.x = posMouse.x;
			_posWindow.y = posMouse.y;
			
			addEventListener(Event.ADDED_TO_STAGE, drawWindow);
		}
		/**
		 * 
		 * @param e
		 * #Note @유영선 마우스 클릭 위치를 중점으로 하는 윈도우 창 출력 (창, 타이틀바, X창, 최소화 창)
		 */		
		public function drawWindow(e:Event) : void
		{
			_contentsImage.x = _posWindow.x-_contentsImage.width/2;
			_contentsImage.y = _posWindow.y-_contentsImage.height/2;
			_contentsImage.addEventListener(TouchEvent.TOUCH,onClickedcontents);
			addChild(_contentsImage);
		
			_titleBaImage.x = _posWindow.x-_contentsImage.width/2;
			_titleBaImage.y = _posWindow.y-_contentsImage.height/2;
			_titleBaImage.addEventListener(TouchEvent.TOUCH,onClickedtitleBar);
			addChild(_titleBaImage);
			
			_closeImage.x = _posWindow.x+_contentsImage.width/2-_closeImage.width;
			_closeImage.y = _posWindow.y-_contentsImage.height/2;
			_closeImage.addEventListener(TouchEvent.TOUCH,onClickedClose);
			addChild(_closeImage);
			
			_minimzieImage.x = _posWindow.x+_contentsImage.width/2-_closeImage.width-_minimzieImage.width;
			_minimzieImage.y = _posWindow.y-_contentsImage.height/2;
			_minimzieImage.addEventListener(TouchEvent.TOUCH,onClickedminimzie);
			addChild(_minimzieImage);
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
				_childWindow = new Window(pos);
				addChild(_childWindow);
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
				var currentPos : Point = touch.getLocation(parent);
				var previousPos : Point = touch.getPreviousLocation(parent);
				var subValue : Point = currentPos.subtract(previousPos);
				
				this.x += subValue.x;
				this.y += subValue.y; 
				trace("이동");
			}
		}
		/**
		 * 
		 * @param e 마우스 클릭 위치
		 * #Note @유영선 종료 아이콘 클릭 시 부모, 자식 윈도우 종료
		 */	
		private function onClickedClose(e:TouchEvent): void
		{
			var touch:Touch = e.getTouch(stage);
			if(!touch) return;
			
			if(touch.phase == TouchPhase.BEGAN)
			{
				this.removeFromParent(false);
				trace("삭제");
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
					_minimzieImage = new Image(Texture.fromEmbeddedAsset(BitmapDefine._revertPNG));		//최소화 아이콘을 최대화로 변경
					_minimzieImage.x = _posWindow.x+_contentsImage.width/2-_closeImage.width-_minimzieImage.width;
					_minimzieImage.y = _posWindow.y-_contentsImage.height/2;
					_minimzieImage.addEventListener(TouchEvent.TOUCH,onClickedminimzie);
					addChild(_minimzieImage);
					
					this._contentsImage.visible = false;
					_minFlag = true;
					if(_childWindow != null)
						_childWindow.visible = false;
				}
				else
				{
					_minimzieImage = new Image(Texture.fromEmbeddedAsset(BitmapDefine._minimziePNG));		//최대화 아이콘을 최소화로 변경
					_minimzieImage.x = _posWindow.x+_contentsImage.width/2-_closeImage.width-_minimzieImage.width;
					_minimzieImage.y = _posWindow.y-_contentsImage.height/2;
					_minimzieImage.addEventListener(TouchEvent.TOUCH,onClickedminimzie);
					addChild(_minimzieImage);
					
					this._contentsImage.visible = true;
					_minFlag = false;
					if(_childWindow != null)
						_childWindow.visible = true;
				}
			}
		}
	}
}