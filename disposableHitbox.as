package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class disposableHitbox extends MovieClip {
		
		
		public function disposableHitbox() {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		public function EnterFrame(event:Event){
			
		}
	}
	
}
