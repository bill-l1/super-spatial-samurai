package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class star extends MovieClip {
		
		private var speed;
		public function star(posY, Speed) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			y = posY;
			speed = Speed;
			var scale = Math.random()*0.9+0.1;
			scaleX = scale;
			scaleY = scale;
			alpha = scale;
		}
		public function EnterFrame(event:Event){
			if(x<-100){
				this.parent.removeChild(this);
				removeListeners();
			}
			x -= speed;
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
