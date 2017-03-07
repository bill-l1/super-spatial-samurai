package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class charDrone extends MovieClip {
		private var carter;
		
		public function charDrone(Char) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			carter = Char;
		}
		public function EnterFrame(event:Event){
			x = carter.x;
			y = Math.floor(carter.y + 20);
		}
	}
	
}
