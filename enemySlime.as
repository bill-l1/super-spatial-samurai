package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class enemySlime extends MovieClip {
		
		private var speed;
		private var SlashContainer:MovieClip;
		private var carter;
		private var health;
		private var droneLaserContainer;
		private var timer = 60;
		private var test;
		private var charging:Boolean = false;
		private var ObjectLayer;
		private var explode;
		private var sound;
		private var chargeSound;
		
		public function enemySlime(Speed:Number, enemyHealth, slashContainerChild, DroneLaserContainer, carterTarget, objectLayer) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			speed = Speed;
			health = enemyHealth;
			SlashContainer = slashContainerChild;
			droneLaserContainer = DroneLaserContainer;
			carter = carterTarget;
			ObjectLayer = objectLayer;
			this.hitbox.visible = false;
		}
		
		
		public function EnterFrame(event:Event){

			if(!charging){
				x -= speed;
			}
			
			if(timer != 0 && charging){
				timer--;
				x -= speed / 2;
				var carterY = Math.floor(carter.y + (carter.height / 2));
				var carterX = Math.floor(carter.x + (carter.width / 2));
				this.rotation = Math.atan2(this.y - carterY, this.x - carterX) * 180 / Math.PI;
				this.gotoAndStop(2);
				if(timer == 1){
					chargeSound = new soundTentacle();
					chargeSound.play();
				}
			}else if (timer == 0 && charging){
				x -= speed * Math.cos(rotation * Math.PI / 180) * 2;
				y -= speed * Math.sin(rotation * Math.PI / 180) * 2;
				this.gotoAndStop(1);
				
			}
			
			if(x<600){
				charging = true;
			}
			
			
			
			if(x<-100){
				removeEventListener(Event.ENTER_FRAME, EnterFrame);
				this.parent.removeChild(this);
			}
			
			for(var i:int = 0;i<SlashContainer.numChildren;i++){
				var slashTarget:MovieClip = MovieClip(SlashContainer.getChildAt(i));
				if(this.hitbox.hitTestObject(slashTarget.hitbox)){
					slashTarget.slashHealth--;
					health--;
					carter.receiveDrive(1);
					trace("wut");
					sound = new soundCharSlashHit();
					sound.play();
				}
			}
			
			for(var o:int = 0;o<droneLaserContainer.numChildren;o++){
				var droneLaserTarget:MovieClip = MovieClip(droneLaserContainer.getChildAt(o));
				if(this.hitbox.hitTestObject(droneLaserTarget.hitbox)){
					droneLaserTarget.droneLaserHealth--;
					health--;
					trace("wut");
					sound = new soundCharSlashHit();
					sound.play();
				}
			}
			
			if(this.hitbox.hitTestObject(carter.hitbox)){
				carter.hurt(1);
			}
			
			if(health <= 0){
				createExplosion();
				carter.receiveScore(125);
				removeEventListener(Event.ENTER_FRAME, EnterFrame);
				this.parent.removeChild(this);
			}
		}
		private function createExplosion(){
			explode = new explosion(x, y, 1);
			ObjectLayer.addChild(explode);
		}
	}
	
}
