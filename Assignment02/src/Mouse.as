package
{

	import flash.geom.Point;

	public class Mouse 
	{
	
		private var _currentMouse : Point = new Point();
		
		
		public function Mouse()
		{
			
		}
		
	
		public function setMousePoint(pos:Point) : void
		{
			_currentMouse.x = pos.x;
			_currentMouse.y = pos.y;	
		}
		
		public function getMousePoint() : Point
		{
			return _currentMouse;
		}
	}
}