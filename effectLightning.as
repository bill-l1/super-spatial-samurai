package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class effectLightning extends MovieClip {
		
		private var sound;
		public function effectLightning() {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			sound = new soundLightning();
			sound.play();
		}
		public function EnterFrame(event:Event){
			if(currentFrame == 16){
				removeListeners();
				this.parent.removeChild(this);
			}
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
