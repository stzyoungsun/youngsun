package
{
	import flash.display.Bitmap;
	
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class PunchClip
	{
		/**
		 *#Name @유영선 펀치를 조절하기 위한 클래스
		 */		
		[Embed(source = "punch-sheet.png")]
		public static const _punchSheet:Class;
		
		[Embed(source="punch-sheet.xml", mimeType="application/octet-stream")]
		public static const _punchSheetXML:Class;
		
		private var _punchClip : MovieClip;
		public static var frames : Vector.<Texture>;
		
		public static const MAX_RUNFRAME_COUNT : int = 5;

		public function PunchClip()
		{
			var bitmap:Bitmap = new _punchSheet();
			var texture:Texture = Texture.fromBitmap(bitmap);
			
			var xml:XML = XML(new _punchSheetXML());
			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture, xml);
			
			frames = sTextureAtlas.getTextures("punch");
			
			_punchClip = new MovieClip(frames,10);
		}
		
		public function getClip() : MovieClip
		{
			return _punchClip;
		}
		

	}
}