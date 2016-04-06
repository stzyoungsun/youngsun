package
{
	import flash.display.Bitmap;
	
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class RunningClip
	{
		[Embed(source = "running-sheet.png")]
		public static const _runnigSheet:Class;
		
		[Embed(source="running-sheet.xml", mimeType="application/octet-stream")]
		public static const _runnigSheetXML:Class;
		
		private var _runningClip : MovieClip;
		public static var frames : Vector.<Texture>;
		
		public static const MAX_RUNFRAME_COUNT : int = 5;
		public function RunningClip()
		{
			var bitmap:Bitmap = new _runnigSheet();
			var texture:Texture = Texture.fromBitmap(bitmap);
			
			var xml:XML = XML(new _runnigSheetXML());
			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml);
			
			frames = sTextureAtlas.getTextures("running");
			
			_runningClip = new MovieClip(frames,10);
		}
		
		public function getClip() : MovieClip
		{
			return _runningClip;
		}
		
	}
}