package  
{
	/**
	 * ...
	 * @author dave
	 */
	public class Move 
	{
		public static var DELAY_LENGTH:int = 1000;
		
		public var startX:int;
		public var startY:int;
		
		public var targetX:int;
		public var targetY:int;
		public var start:int;
		public var end:int;
		
		public function Move(xml:XML, _x:int, _y:int) 
		{
			targetX = xml.TargetX;
			targetY = xml.TargetY;
			start = xml.Start;
			end = xml.End;
			
			startX = _x;
			startY = _y;
		}
		
		public function interpolate(time:int, setPosition:Function, setDelay:Function):void
		{
			var ptime:int = time;
			if (ptime > end) ptime = end;
			
			setPosition(startX + (targetX - startX) * (ptime - start) / (end - start),
						startY + (targetY - startY) * (ptime - start) / (end - start));
						
			if (time > end && time < end + DELAY_LENGTH) {
				setDelay(1 - Number(time - end) / DELAY_LENGTH);
			} else {
				setDelay(0);
			}
		}
	}

}