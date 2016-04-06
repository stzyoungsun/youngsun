 package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import starling.events.Event;
	import starling.textures.Texture;

	public class BitmapDefine 
	{
		/**
		 *Note @유영선 이미지 객체 따로 저장 
		 */
		[Embed(source ="GUI_resources/close.png")]
		public static const sClosePNG1 : Class;
		
		[Embed(source ="GUI_resources/contents.png")]
		public  static const sContentsPNG1 : Class;
		
		[Embed(source ="GUI_resources/minimize.png")]
		public  static const sMinimziePNG1 : Class;
		
		[Embed(source ="GUI_resources/titleBar.png")]
		public  static const sTitleBarPNG1 : Class;
		
		[Embed(source = "GUI_resources/revert.png")]
		public  static const sRevertPNG1 : Class;

		[Embed(source ="GUI_resources/close2.png")]
		public static const sClosePNG2 : Class;
		
		[Embed(source ="GUI_resources/contents2.png")]
		public  static const sContentsPNG2 : Class;
		
		[Embed(source ="GUI_resources/minimize2.png")]
		public  static const sMinimziePNG2 : Class;
		
		[Embed(source ="GUI_resources/titleBar2.png")]
		public  static const sTitleBarPNG2 : Class;
		
		[Embed(source = "GUI_resources/revert2.png")]
		public  static const sRevertPNG2 : Class;
		
		public static var sDrawNumber : Boolean = true;
		private var _texture : Texture;
		private var _loader : Loader = new Loader();
		public static var image : Bitmap;
		public function BitmapDefine()
		{
		}
		
		public function getTexture() : void
		{
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			_loader.load(new URLRequest("GUI_resources/titleBar2.png"));
			
		}
		
		public function onComplete(event:Event):void
		{
			image = Bitmap(_loader.content);
		}
	}
}