package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.motion.Color;
	
	public class enemyHazardDanger extends MovieClip {
		
		private var tint:Color;
		private var isYellow = false;
		private var hazard;
		private var time = 0;
		private var sound;
		public function enemyHazardDanger(Hazard){
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			hazard = Hazard;
			tint = new Color;
			sound = new soundDanger();
			sound.play(0, 4);
		}
		public function EnterFrame(event:Event){
			if(hazard.moving){
				removeThis();
			}
			
			
			if(time > 5){
				if(isYellow){
					tint.setTint(0xffff00, 0);
					isYellow = false;
				}else{
					tint.setTint(0xffff00, 0.8);
					isYellow = true;
				}
				transform.colorTransform = tint;
				time = 0;
			}
			time++;
		}
		private function removeThis(){
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
			this.parent.removeChild(this);
		}
	}
	
}
