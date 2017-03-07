package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class help extends MovieClip {
		
		
		public function help() {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		public function EnterFrame(event:Event){
			
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
