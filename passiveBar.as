package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class passiveBar extends MovieClip {
		
		public var passive = 4;
		private var maxPassive;
		
		public function passiveBar(MaxPassive) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			maxPassive = MaxPassive;
			
			box1.scaleX = 1.333;
			box2.scaleX = 1.333;
			box4.scaleX = 1.333;
			box5.scaleX = 1.333;
			
			box1.x -= 5;
			box2.x -= 5;
			box4.x -= 5;
			box5.x -= 5;
		}
		public function EnterFrame(event:Event){
			gotoAndStop(passive + 1);
			if(passive < 0){
				passive = 0;
			}else if(passive > maxPassive){
				passive = maxPassive;
			}

			
			
		}
		public function addPassive(Passive:Number){
			passive += Passive;
		}
		
	}
}
