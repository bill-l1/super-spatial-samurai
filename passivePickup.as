package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class passivePickup extends MovieClip {
		
		private var passive;
		private var carter;
		private var speed = -5;
		private var speedMax = 0;
		private var sound;
		
		public function passivePickup(passiveAmount, SpeedMax, Char) {
			passive = passiveAmount;
			carter = Char;
			speedMax = SpeedMax;
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			this.hitbox.visible = false;
		}
		
		public function EnterFrame(event:Event){
			x -= speed;
			if(speed < speedMax){
				speed += 0.5;
			}
			if(x<0){
				removeEventListener(Event.ENTER_FRAME, EnterFrame);
				this.parent.removeChild(this);
			}
			
			if(this.hitbox.hitTestObject(carter.hitbox)){
				carter.receivePassive(passive);
				sound = new soundPassivePickup();
				sound.play();
				removeEventListener(Event.ENTER_FRAME, EnterFrame);
				this.parent.removeChild(this);
			}
			

		}
	}
	
}
