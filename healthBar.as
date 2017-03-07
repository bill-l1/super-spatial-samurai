package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class healthBar extends MovieClip {
		
		public var charHealth;
		public var maxHealth;
		public var shieldActive = false;
		public var dead:Boolean;
		
		public function healthBar(MaxHealth) {
			charHealth = 2;
			maxHealth = MaxHealth;
			addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		public function EnterFrame(event:Event){
			trace(charHealth);
			gotoAndStop(charHealth);
			if(shieldActive){
				this.shieldOverlay.visible = true;
			}else{
				this.shieldOverlay.visible = false;
			}
			if(charHealth <= 0){
				
			}
			
			//trace(charHealth);
		}
		public function getHurt(Damage:Number){	
			if(charHealth > 1){
				charHealth -= Damage;
			}
		}
	}
	
}
