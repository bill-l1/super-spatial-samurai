package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class bossVultureBoost extends MovieClip {
		
		
		public function bossVultureBoost() {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		public function EnterFrame(event:Event){
			if(currentFrame == 20){
				removeListeners();
				this.parent.removeChild(this);
			}
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
