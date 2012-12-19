package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author dave
	 */
	public class SeekBar extends Sprite 
	{
		[Embed(source='seek_bg.gif')]
		private var bg_gif:Class;
		
		[Embed(source='seek_fg.gif')]
		private var fg_gif:Class;
		
		private var bg:Bitmap = new bg_gif();
		private var fg:Bitmap = new fg_gif();
		
		private var start:int;
		private var end:int;
		private var cur_time:int;
		
		public function SeekBar(_start:int, _end:int, _w:Number, _h:Number) 
		{
			start = _start;
			end = _end;
			
			cur_time = start;
			
			addEventListener(MouseEvent.MOUSE_DOWN, onClick);
			
			addChild(bg);
			addChild(fg);
			
			bg.width = _w;
			bg.height = _h;
			
			fg.width = 0;
			fg.height = _h;
		}
		
		private function onClick(e:MouseEvent):void
		{
			var fraction:Number = e.localX / width;
			
			cur_time = fraction * Number(end - start) + start;
			
			fg.width = e.localX;
		}
		
		public function update(t:int):void
		{
			cur_time += t;
			if (cur_time > end) cur_time = start;
			
			fg.width = width * Number(cur_time - start) / Number(end);
		}
		
		public function get_time():int
		{
			return cur_time;
		}
	}

}