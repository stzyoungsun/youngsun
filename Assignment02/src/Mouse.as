package
{

	import flash.geom.Point;

	public class Mouse 
	{
	
		private var _currentMouse : Point = new Point();
		
		
		public function Mouse()
		{
			
		}
		/**
		 * 
		 * @param pos 마우스가 클릭 한 위치
		 * Note @유영선 마우스가 클릭 한 위치를 받아서 그 값은 Mouse 객체에 저장
		 */		
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