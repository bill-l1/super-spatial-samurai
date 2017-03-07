package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class scoreBar extends MovieClip {
		
		public var score = 0;
		public function scoreBar() {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			
		}
		
		public function EnterFrame(event:Event){
			this.textbox.text = score;
		}
		public function addScore(Score){
			score += Score;
		}
	}
	
}
