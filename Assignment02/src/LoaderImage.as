package
{

	public class LoaderImage
	{
		import starling.display.Image;
		import starling.textures.Texture;
		
		import flash.display.Bitmap;
		import flash.display.Loader;
		import flash.events.Event;
		import flash.net.URLRequest;
		
		public static const MAX_IMAGE_COUNT : int = 10;
		private  var _completeImageCount : int = 0;
		
		private static var _bitmap : Bitmap = new Bitmap();
		
		private var _contentloader : Loader = new Loader();
		private var _closeloader : Loader = new Loader();
		private var _titleloader : Loader = new Loader();
		private var _revertloader : Loader = new Loader();
		private var _minimizeloader : Loader = new Loader();
		private var _contentloaderChild : Loader = new Loader();
		private var _closeloaderChild : Loader = new Loader();
		private var _titleloaderChild : Loader = new Loader();
		private var _revertloaderChild : Loader = new Loader();
		private var _minimizeloaderChild : Loader = new Loader();
		
		public static var sContentTexture : Texture;
		public static var sCloseTexture : Texture;
		public static var sTitleTexture : Texture;
		public static var sRevertTexture : Texture;
		public static var sMinimizeTexture : Texture;
		public static var sContentTextureChild : Texture;
		public static var sCloseTextureChild : Texture;
		public static var sTitleTextureChild : Texture;
		public static var sRevertTextureChild : Texture;
		public static var sMinimizeTextureChild : Texture;
		
		private var _urlContents : URLRequest = new URLRequest("https://raw.githubusercontent.com/stzyoungsun/youngsun/master/Assignment02/src/GUI_resources/contents.png");
		private var _urlClose : URLRequest = new URLRequest("https://raw.githubusercontent.com/stzyoungsun/youngsun/master/Assignment02/src/GUI_resources/close.png");
		private var _urlTitleBar : URLRequest = new URLRequest("https://raw.githubusercontent.com/stzyoungsun/youngsun/master/Assignment02/src/GUI_resources/titleBar.png");
		private var _urlRevert : URLRequest = new URLRequest("https://raw.githubusercontent.com/stzyoungsun/youngsun/master/Assignment02/src/GUI_resources/revert.png");
		private var _urlMinimize : URLRequest = new URLRequest("https://raw.githubusercontent.com/stzyoungsun/youngsun/master/Assignment02/src/GUI_resources/minimize.png");
		
		private var _urlContentsChild : URLRequest = new URLRequest("https://raw.githubusercontent.com/stzyoungsun/youngsun/master/Assignment02/src/GUI_resources/contents2.png");
		private var _urlCloseChild : URLRequest = new URLRequest("https://raw.githubusercontent.com/stzyoungsun/youngsun/master/Assignment02/src/GUI_resources/close2.png");
		private var _urlTitleBarChild : URLRequest = new URLRequest("https://raw.githubusercontent.com/stzyoungsun/youngsun/master/Assignment02/src/GUI_resources/titleBar2.png");
		private var _urlRevertChild : URLRequest = new URLRequest("https://raw.githubusercontent.com/stzyoungsun/youngsun/master/Assignment02/src/GUI_resources/revert2.png");
		private var _urlMinimizeChild : URLRequest = new URLRequest("https://raw.githubusercontent.com/stzyoungsun/youngsun/master/Assignment02/src/GUI_resources/minimize2.png");
		
		private var _completeFunction:Function;
		private var _progressFunction:Function;
		
		public static var sDrawNumber: Boolean = false;
		public function LoaderImage(completeFunction:Function, progressFunction : Function)
		{
			
			_contentloader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleateContent);
			_contentloader.load(_urlContents);
				
			_closeloader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleateClose);
			_closeloader.load(_urlClose);
				
			_titleloader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleateTitlebar);
			_titleloader.load(_urlTitleBar);
				
			_revertloader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleateRevert);
			_revertloader.load(_urlRevert);
			
			_minimizeloader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleateMinimize);
			_minimizeloader.load(_urlMinimize);
			
			_contentloaderChild.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleateContentChild);
			_contentloaderChild.load(_urlContentsChild);
			
			_closeloaderChild.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleateCloseChild);
			_closeloaderChild.load(_urlCloseChild);
			
			_titleloaderChild.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleateTitlebarChild);
			_titleloaderChild.load(_urlTitleBarChild);
			
			_revertloaderChild.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleateRevertChild);
			_revertloaderChild.load(_urlRevertChild);
			
			_minimizeloaderChild.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleateMinimizeChild);
			_minimizeloaderChild.load(_urlMinimizeChild);
			
			_completeFunction = completeFunction;
			_progressFunction = progressFunction;
			
		}
		private function onCompleateContent(e:Event) : void
		{
			_bitmap = e.currentTarget.loader.content as Bitmap;
			trace(_bitmap);
			sContentTexture = Texture.fromBitmap(_bitmap);
			e.currentTarget.loader.removeEventListener(Event.COMPLETE, onCompleateContent);
				
			chedckedImageCount();
		}
		private function onCompleateClose(e:Event) : void
		{
			
			_bitmap = e.currentTarget.loader.content as Bitmap;
			sCloseTexture = Texture.fromBitmap(_bitmap);
			e.currentTarget.loader.removeEventListener(Event.COMPLETE, onCompleateClose);
			chedckedImageCount();
		}
		private function onCompleateTitlebar(e:Event) : void
		{
			
			_bitmap = e.currentTarget.loader.content as Bitmap;;
			sTitleTexture = Texture.fromBitmap(_bitmap);
			e.currentTarget.loader.removeEventListener(Event.COMPLETE, onCompleateClose);
			chedckedImageCount();
		}
		private function onCompleateRevert(e:Event) : void
		{
			
			_bitmap = e.currentTarget.loader.content as Bitmap;
			sRevertTexture = Texture.fromBitmap(_bitmap);
			e.currentTarget.loader.removeEventListener(Event.COMPLETE, onCompleateClose);
			chedckedImageCount();
		}
		private function onCompleateMinimize(e:Event) : void
		{
			
			_bitmap = e.currentTarget.loader.content as Bitmap;
			sMinimizeTexture = Texture.fromBitmap(_bitmap);
			e.currentTarget.loader.removeEventListener(Event.COMPLETE, onCompleateClose);
			chedckedImageCount();
		}
		
		private function onCompleateContentChild(e:Event) : void
		{
			_bitmap = e.currentTarget.loader.content as Bitmap;
			trace(_bitmap);
			sContentTextureChild = Texture.fromBitmap(_bitmap);
			e.currentTarget.loader.removeEventListener(Event.COMPLETE, onCompleateContent);
			
			chedckedImageCount();
		}
		private function onCompleateCloseChild(e:Event) : void
		{
			
			_bitmap = e.currentTarget.loader.content as Bitmap;
			sCloseTextureChild = Texture.fromBitmap(_bitmap);
			e.currentTarget.loader.removeEventListener(Event.COMPLETE, onCompleateClose);
			chedckedImageCount();
		}
		private function onCompleateTitlebarChild(e:Event) : void
		{
			
			_bitmap = e.currentTarget.loader.content as Bitmap;;
			sTitleTextureChild = Texture.fromBitmap(_bitmap);
			e.currentTarget.loader.removeEventListener(Event.COMPLETE, onCompleateClose);
			chedckedImageCount();
		}
		private function onCompleateRevertChild(e:Event) : void
		{
			
			_bitmap = e.currentTarget.loader.content as Bitmap;
			sRevertTextureChild = Texture.fromBitmap(_bitmap);
			e.currentTarget.loader.removeEventListener(Event.COMPLETE, onCompleateClose);
			chedckedImageCount();
		}
		private function onCompleateMinimizeChild(e:Event) : void
		{
			
			_bitmap = e.currentTarget.loader.content as Bitmap;
			sMinimizeTextureChild = Texture.fromBitmap(_bitmap);
			e.currentTarget.loader.removeEventListener(Event.COMPLETE, onCompleateClose);
			chedckedImageCount();
		}
		private function chedckedImageCount() : void
		{
			_completeImageCount++;
			_progressFunction(_completeImageCount);
			trace(_completeImageCount);
			if(_completeImageCount == MAX_IMAGE_COUNT)
			{
				_completeFunction();
			}
		}
	}
}