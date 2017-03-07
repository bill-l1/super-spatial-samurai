package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class logo extends MovieClip {
		
		private var timer = 0;
		
		public function logo() {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		public function EnterFrame(event:Event){
			if(currentFrame == 120){
				if(timer == 0){
					this.overlay.gotoAndStop(2);
					timer++;
				}else if(timer == 1){
					this.overlay.gotoAndStop(3);
					timer++;
				}else if(timer == 2){
					this.overlay.gotoAndStop(1);
					timer = 0;
				}
				
			}
		}
	}
	
}
