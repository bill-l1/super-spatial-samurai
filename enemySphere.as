package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class enemySphere extends MovieClip {
		
		private var speed;
		private var carter;
		private var timer = 0;
		private var sound;

		public function enemySphere(Speed:Number, carterTarget) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			speed = Speed;
			carter = carterTarget;
			
			this.hitbox.visible = false;
			
			sound = new soundEnemyLaser();
			sound.play();
		}
		public function EnterFrame(event:Event){
			if(timer != 1){
				timer++;
				
				var carterY = Math.floor(carter.y + (carter.height / 2));
				var carterX = Math.floor(carter.x + (carter.width / 2));
				this.rotation = Math.atan2(this.y - carterY, this.x - carterX) * 180 / Math.PI;
			}
			speed += 0.1;
			x -= speed * Math.cos(this.rotation * Math.PI / 180) * 2;
			y -= speed * Math.sin(this.rotation * Math.PI / 180) * 2;
			
			if(x<-100){
				removeThis();
				this.parent.removeChild(this);
			}

			if(this.hitbox.hitTestObject(carter.hitbox)){
				carter.hurt(1);
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
