package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class droneLaser extends MovieClip {
		
		private var speed;
		public var droneLaserHealth;
		public function droneLaser(Health:Number, Speed:Number) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			speed = Speed;
			droneLaserHealth = Health;
			this.hitbox.visible = false;
			
		}
		public function EnterFrame(event:Event){
			x += speed;
			if(x>800){
				removeThis();
				this.parent.removeChild(this);
			}
			if(droneLaserHealth <= 0){
				trace("WOOOLOLOOLOLOL");
				removeThis();
				this.parent.removeChild(this);
			}
			
		}
		private function removeThis():void{
			removeListeners();
			
		}
		

		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
