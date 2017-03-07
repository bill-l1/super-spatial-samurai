package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class explosion extends MovieClip {
		
		private var sound;
		public function explosion(posX, posY, scale) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			x = posX;
			y = posY;
			scaleX = scale;
			scaleY = scale;
			sound = new soundExplosion();
			sound.play();
		}
		public function EnterFrame(event:Event){
			if(currentFrame == 16){
				trace("boom");
				removeListeners();
				this.parent.removeChild(this);
			}
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
