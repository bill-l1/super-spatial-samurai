package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class effectReveal extends MovieClip {
		
		private var sound;
		public function effectReveal() {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			sound = new soundReveal();
		}
		public function EnterFrame(event:Event){
			if(currentFrame == 120){
				sound.play();
			}if(currentFrame == 150){
				removeListeners();
				this.parent.removeChild(this);
			}
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
