package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class charSlashEffect extends MovieClip {
		
		public function charSlashEffect() {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		public function EnterFrame(event:Event){
			if(currentFrame == 8){
				removeEventListener(Event.ENTER_FRAME, EnterFrame);
				this.parent.removeChild(this);
			}
		}
	
	}
	
}
