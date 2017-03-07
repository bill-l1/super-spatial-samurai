package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class effectScreenFade extends MovieClip {
		
		private var Type;
		private var main;
		private var sound;
		public function effectScreenFade(tp, Main) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			Type = tp;
			main = Main;
			sound = new soundReveal();
			sound = sound.play();
		}
		public function EnterFrame(event:Event){
			if(currentFrame == 90){
				removeListeners();
				this.parent.removeChild(this);
			}
			if(Type == 0){
				if(currentFrame == 59){
					main.loadLevel();
				}
			}
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
