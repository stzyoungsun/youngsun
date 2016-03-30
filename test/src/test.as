package
{
	import flash.display.Sprite;
	import MainClass;
	
	public class test extends Sprite
	{
		public function test()
		{
			var mMainclass : MainClass = new MainClass();
			mMainclass.initalize();
			mMainclass.Progress();
			mMainclass.Render();
		}
	
	}
}