package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class effectLightningDelay extends MovieClip {
		
		private var timer = 0;
		private var timerMax;
		private var sound;
		public function effectLightningDelay(Delay) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			timerMax = Delay;
			sound = new soundLightning();
			
		}
		public function EnterFrame(event:Event){
			if(timer == timerMax){
				sound.play();
				play();
				timer++;
			}else{
				timer++;
			}
			if(currentFrame == 17){
				removeListeners();
				this.parent.removeChild(this);
			}
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
