package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dave
	 */
	public class Piece extends Sprite 
	{
		public static var BOARD_HEIGHT:int = 8;
		
		[Embed(source='pieces.gif')]
		private var pieces:Class;
		[Embed(source = 'delay.gif')]
		private var delaygif:Class;
		
		private var pieceMap:Bitmap = new pieces();
		
		private var delay:Bitmap = new delaygif();
		
		private static var pieceDict:Dictionary = new Dictionary();
		pieceDict["WhitePawn"] = 0; pieceDict["WhiteBishop"] = 1; pieceDict["WhiteKnight"] = 2; pieceDict["WhiteRook"] = 3; pieceDict["WhiteKing"] = 4; pieceDict["WhiteQueen"] = 5;
		pieceDict["BlackPawn"] = 6; pieceDict["BlackBishop"] = 7; pieceDict["BlackKnight"] = 8; pieceDict["BlackRook"] = 9; pieceDict["BlackKing"] = 10; pieceDict["BlackQueen"] = 11;
		pieceDict["GreenPawn"] = 12; pieceDict["GreenBishop"] = 13; pieceDict["GreenKnight"] = 14; pieceDict["GreenRook"] = 15; pieceDict["GreenKing"] = 16; pieceDict["GreenQueen"] = 17;
		pieceDict["RedPawn"] = 18; pieceDict["RedBishop"] = 19; pieceDict["RedKnight"] = 20; pieceDict["RedRook"] = 21; pieceDict["RedKing"] = 22; pieceDict["RedQueen"] = 23;
		
		public static var SQUAREWIDTH:int = 62;
		
		private var moves:Array;
		private var startX:int;
		private var startY:int;
		private var death:int;
		
		public function Piece(xml:XML) 
		{
			var dest:BitmapData = new BitmapData(62, 62);
			dest.copyPixels(pieceMap.bitmapData, new Rectangle(pieceDict[xml.Name.toString()] * 62, 0, 62, 62), new Point());
			
			var pic:Bitmap = new Bitmap(dest);
			pic.smoothing = true;
			
			startX = xml.X;
			startY = xml.Y;
			
			addChild(delay);
			addChild(pic);
			
			setPosition(startX, startY);
			width = SQUAREWIDTH;
			height = SQUAREWIDTH;
			
			moves = new Array();
			
			var sx:int = startX;
			var sy:int = startY;
			
			for (var i:int = 0; i < xml.Moves.Move.length(); i++)
			{
				var m:Move = new Move(xml.Moves.Move[i], sx, sy);
				sx = m.targetX; sy = m.targetY;
				
				moves.push(m);
			}
			
			death = xml.Death;
		}
		
		public function update(time:int):void
		{
			visible = true;
			if (death != 0 && time > death) visible = false;
			
			if (moves.length == 0) return;
			
			var m:Move = null;
			
			for (var i:int = 0; i < moves.length; i++)
			{	
				if (time >= moves[i].start) {
					m = moves[i];
				}
			}
			
			if (m) {
				m.interpolate(time, setPosition, setDelay);
			}
			else {
				setPosition(startX, startY);
				setDelay(0);
			}
		}
		
		private function setPosition(_x:Number, _y:Number):void
		{
			x = _x * SQUAREWIDTH;
			y = (BOARD_HEIGHT - _y - 1) * SQUAREWIDTH;
		}
		
		private function setDelay(h:Number):void
		{
			if (h == 0) delay.visible = false;
			delay.visible = true;
			
			delay.width = 62;
			delay.height = h * 62;
			delay.x = 0;
			delay.y = 62 - h * 62;
		}
	}

}