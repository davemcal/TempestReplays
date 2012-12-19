package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.display.LoaderInfo;
	
	/**
	 * ...
	 * @author dave
	 */
	public class Main extends Sprite 
	{
		[Embed(source='board.gif')]
		private var boardgif:Class;
		
		[Embed(source = 'board4.gif')]
		private var board4gif:Class;
		
		private var seekBar:SeekBar;
		
		private var pieces:Array = new Array();
		
		private var TIMER_INTERVAL:int = 1000 / 30;
		
		private var time:int;
		
		private var SQUAREWIDTH:int;
		private var SEEK_BAR_HEIGHT:int = 30;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var myXML:XML;
			var myLoader:URLLoader = new URLLoader();
			
			var replayName:String = LoaderInfo(root.loaderInfo).parameters["file"];
			
			trace(replayName);
			
			if (replayName == null) replayName = "replay2.xml";
			
			myLoader.load(new URLRequest(replayName));
			myLoader.addEventListener(Event.COMPLETE, processXML);
		}
		
		private function processXML(e:Event):void {
			var myXML:XML;
			myXML = new XML(e.target.data);
			
			var board:Bitmap;
			if (myXML.GameType == "Standard") 
				Move.DELAY_LENGTH = 10000;
			else
				Move.DELAY_LENGTH = 1000;
			
			if (myXML.GameType == "FastStandard" || myXML.GameType == "Standard") {
				SQUAREWIDTH = Math.min(stage.stageWidth, stage.stageHeight - SEEK_BAR_HEIGHT) / 8;
				Piece.SQUAREWIDTH = SQUAREWIDTH;
				Piece.BOARD_HEIGHT = 8;
				
				board = new boardgif();			
				board.width = SQUAREWIDTH * 8;
				board.height = SQUAREWIDTH * 8;
			} else {
				SQUAREWIDTH = Math.min(stage.stageWidth, stage.stageHeight - SEEK_BAR_HEIGHT) / 12;
				Piece.SQUAREWIDTH = SQUAREWIDTH;
				Piece.BOARD_HEIGHT = 12;
				
				board = new board4gif();
				board.width = SQUAREWIDTH * 12;
				board.height = SQUAREWIDTH * 12;
			}
			addChild(board);
				
			for (var i:int = 0; i < myXML.Piece.length(); i++ )
			{
				var p:Piece = new Piece(myXML.Piece[i]);
				addChild(p);
				pieces.push(p);
			}
			
			seekBar = new SeekBar(myXML.Start, myXML.End, board.width, SEEK_BAR_HEIGHT);
			seekBar.y = board.height;
			seekBar.x = 0;
			
			addChild(seekBar);
			
			time = myXML.Start;
			
			startTimer();
		}
		
		private function startTimer():void
		{
			var t:Timer = new Timer(TIMER_INTERVAL, 0);
			t.addEventListener(TimerEvent.TIMER, update);
			
			t.start();
		}
		
		private function update (e:TimerEvent):void
		{
			//time += TIMER_INTERVAL;
			seekBar.update(TIMER_INTERVAL);
			
			time = seekBar.get_time();
			
			for ( var i:int = 0; i < pieces.length; i++) 
			{
				pieces[i].update(time);
			}
		}
	}
	
}