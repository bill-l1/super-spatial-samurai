package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;	
	
	public class slimeArmy extends MovieClip {
		
		private var speed = 3;
		
		public function slimeArmy() {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		public function EnterFrame(event:Event){
			x -= speed;
			if(x < -200){
				removeEventListener(Event.ENTER_FRAME, EnterFrame);
				this.parent.removeChild(this);
			}
		}
	}
	
}
