 package
{

	public class BitmapDefine 
	{
		/**
		 *Note @유영선 이미지 객체 따로 저장 
		 */		
		[Embed(source ="close.png")]
		public static const _closePNG : Class;
		
		[Embed(source ="contents.png")]
		public  static const _contentsPNG : Class;
		
		[Embed(source ="minimize.png")]
		public  static const _minimziePNG : Class;
		
		[Embed(source ="titleBar.png")]
		public  static const _titleBarPNG : Class;
		
		[Embed(source = "revert.png")]
		public  static const _revertPNG : Class;

		public function BitmapDefine()
		{
		}
	}
}