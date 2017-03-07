package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class passiveBarFlash extends MovieClip {
		
		
		public function passiveBarFlash() {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		public function EnterFrame(event:Event){
			if(currentFrame == 40){
				removeListeners();
				this.parent.removeChild(this);
			}
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
