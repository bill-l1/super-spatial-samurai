package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class bossVultureShift extends MovieClip {
		
		private var boss;
		public function bossVultureShift(Boss) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			boss = Boss;
		}
		public function EnterFrame(event:Event){
			x = boss.x;
			y = boss.y;
			if(currentFrame == 5){
				rotation = boss.rotation;
			}else if(currentFrame == 10){
				rotation = boss.rotation;
			}else if(currentFrame == 15){
				removeListeners();
				this.parent.removeChild(this);
			}
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
