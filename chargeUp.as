package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class chargeUp extends MovieClip {
		
		private var duration;
		private var anchor;
		private var timer = 0;
		private var boss;
		
		public function chargeUp(Boss, Duration, Anchor) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			duration = Duration;
			anchor = Anchor;
			boss = Boss;
		}
		public function EnterFrame(event:Event){
			if(boss.killed){
				removeListeners();
				this.parent.removeChild(this);
			}
			var anchorPoint:Point = new Point(anchor.x, anchor.y);
			anchorPoint = anchor.parent.localToGlobal(anchorPoint);
			x = anchorPoint.x;
			y = anchorPoint.y;
			if(timer !== duration){
				timer++;
			}else{
				removeThis();
			}
		}
		private function removeThis():void{
			removeListeners();
			this.parent.removeChild(this);
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
