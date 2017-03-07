package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class enemyCube extends MovieClip {
		
		private var speed;
		private var SlashContainer:MovieClip;
		private var carter;
		private var health;
		private var ObjectLayer;
		private var droneLaserContainer;
		private var timer = 0;
		private var explode;
		
		private var pickup;
		private var laser;
		
		private var sound;
		
		public function enemyCube(Speed:Number, enemyHealth, slashContainerChild, ObjectLayerTarget, DroneLaserContainer, carterTarget) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			speed = Speed;
			health = enemyHealth;
			SlashContainer = slashContainerChild;
			carter = carterTarget;
			ObjectLayer = ObjectLayerTarget;
			droneLaserContainer = DroneLaserContainer;
			this.hitbox.visible = false;
		}
		
		
		public function EnterFrame(event:Event){
			x -= speed;
			timer++;
			
			if(x<-100){
				removeEventListener(Event.ENTER_FRAME, EnterFrame);
				this.parent.removeChild(this);
			}
			
			if(timer == 60){
				createLaser(3);
				timer = 0;
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
				createPickup(1, 1.5);
				carter.receiveScore(100);
				removeEventListener(Event.ENTER_FRAME, EnterFrame);
				this.parent.removeChild(this);
			}
			
		}
		private function createPickup(Passive, Speed){
			pickup = new passivePickup(Passive, Speed, carter);
			ObjectLayer.addChild(pickup);
			pickup.x = Math.floor(this.x + (this.width/2));
			pickup.y = Math.floor(this.y + (this.height/2));
		}
		private function createLaser(Speed){
			laser = new enemyLaser(Speed, carter);
			ObjectLayer.addChild(laser);
			laser.x = Math.floor(this.x + (this.width/2));
			laser.y = Math.floor(this.y + (this.height/2));
		}
		private function createExplosion(){
			explode = new explosion(x+width/2, y+height/2, 0.5);
			ObjectLayer.addChild(explode);
		}
	}
	
}
