package
{

	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class Window extends Sprite
	{
		[Embed(source ="close.png")]
		private var _closePNG : Class;
		
		[Embed(source ="contents.png")]
		private var _contentsPNG : Class;
		
		[Embed(source ="minimize.png")]
		private var _minimziePNG : Class;
		
		[Embed(source ="titleBar.png")]
		private var _titleBarPNG : Class;
		
		[Embed(source = "revert.png")]
		private var _revertPNG : Class;
		
		private var _posWindow : Point = new Point();
		private var _childWindow : Window = null;

		private var _contentstexture : Texture = Texture.fromBitmap(new _contentsPNG());
		private var _contentsimage : Image = new Image(_contentstexture);
		
		private var _titleBartexture : Texture = Texture.fromBitmap(new _titleBarPNG());
		private var _titleBarimage : Image = new Image(_titleBartexture);
		
		private var _closetexture : Texture = Texture.fromBitmap(new _closePNG());
		private var _closeimage : Image = new Image(_closetexture);
		
		private var _minimzietexture : Texture = Texture.fromBitmap(new _minimziePNG());
		private var _minimzieimage : Image = new Image(_minimzietexture);
		
		private var _minFlag : Boolean = false;
		
		public function Window(posMouse : Point)
		{
			_posWindow.x = posMouse.x;
			_posWindow.y = posMouse.y;
			
			addEventListener(Event.ADDED_TO_STAGE, drawWindow);
		}
		
		public function drawWindow(e:Event) : void
		{
			_contentsimage.x = _posWindow.x-_contentsimage.width/2;
			_contentsimage.y = _posWindow.y-_contentsimage.height/2;
			_contentsimage.addEventListener(TouchEvent.TOUCH,onClickedcontents);
			addChild(_contentsimage);
			
			_titleBarimage.x = _posWindow.x-_contentsimage.width/2;
			_titleBarimage.y = _posWindow.y-_contentsimage.height/2;
			_titleBarimage.addEventListener(TouchEvent.TOUCH,onClickedtitleBar);
			addChild(_titleBarimage);
			
			
			_closeimage.x = _posWindow.x+_contentsimage.width/2-_closeimage.width;
			_closeimage.y = _posWindow.y-_contentsimage.height/2;
			_closeimage.addEventListener(TouchEvent.TOUCH,onClickedClose);
			addChild(_closeimage);
			
			
			_minimzieimage.x = _posWindow.x+_contentsimage.width/2-_closeimage.width-_minimzieimage.width;
			_minimzieimage.y = _posWindow.y-_contentsimage.height/2;
			_minimzieimage.addEventListener(TouchEvent.TOUCH,onClickedminimzie);
			addChild(_minimzieimage);
		}
		
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
		
		private function onClickedClose(e:TouchEvent): void
		{
			var touch:Touch = e.getTouch(stage);
			if(!touch) return;
			
			if(touch.phase == TouchPhase.BEGAN)
			{
				this.removeFromParent(false);
				this.removeChild(_childWindow,false);
				trace("삭제");
			}
		}
		
		private function onClickedminimzie(e:TouchEvent): void
		{
			var touch:Touch = e.getTouch(stage);
			if(!touch) return;
			
			if(touch.phase == TouchPhase.BEGAN)
			{
				if(_minFlag == false)
				{
					_minimzietexture = Texture.fromBitmap(new _revertPNG());
					_minimzieimage  = new Image(_minimzietexture);
					_minimzieimage.x = _posWindow.x+_contentsimage.width/2-_closeimage.width-_minimzieimage.width;
					_minimzieimage.y = _posWindow.y-_contentsimage.height/2;
					_minimzieimage.addEventListener(TouchEvent.TOUCH,onClickedminimzie);
					addChild(_minimzieimage);
					
					this._contentsimage.visible = false;
					_minFlag = true;
					if(_childWindow != null)
						_childWindow.visible = false;
				}
				else
				{
					_minimzietexture = Texture.fromBitmap(new _minimziePNG());
					_minimzieimage  = new Image(_minimzietexture);
					_minimzieimage.x = _posWindow.x+_contentsimage.width/2-_closeimage.width-_minimzieimage.width;
					_minimzieimage.y = _posWindow.y-_contentsimage.height/2;
					_minimzieimage.addEventListener(TouchEvent.TOUCH,onClickedminimzie);
					addChild(_minimzieimage);
					
					this._contentsimage.visible = true;
					_minFlag = false;
					if(_childWindow != null)
						_childWindow.visible = true;
				}
			}
		}
	}
}