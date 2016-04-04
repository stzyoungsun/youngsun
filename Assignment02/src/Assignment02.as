package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#ffffff")]
	public class Assignment02 extends Sprite
	{
		private var _starling:Starling;

		public function Assignment02()
		{
			_starling = new Starling(MainClass, stage);
			_starling.start();
		}
		
	}
}