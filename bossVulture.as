package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound; 
	import flash.media.SoundTransform;
	
	public class bossVulture extends MovieClip {
		
		public var spawning:Boolean = true;
		public var spawnTimer = 0;
		
		private var delay = 0;
		private var delayMax = 90;
		
		private var SlashContainer;
		private var droneLaserContainer;
		private var carter;
		private var main;
		public var health;
		private var ObjectLayer;
		private var pickup;
		private var boost;
		private var shift;
		private var explode;
		private var charging:Boolean = false;
		private var speedMax = 4;
		private var speed = 0;
		private var direction = 0;
		private var driftRotation;
		private var rotateTo = 0;
		private var trueRotation = 0;
		private var minTime = 20;
		private var chargeTime = 0;
		private var delayOffset = 0;
		private var rotationDifference = 0;
		private var caw;
		private var vol;
		public var killed = false;
		
		public function bossVulture(Main, maxHealth, objectLayer, slashContainerChild, DroneLaserContainer, carterTarget) {
			SlashContainer = slashContainerChild;
			droneLaserContainer = DroneLaserContainer;
			carter = carterTarget;
			main = Main;
			health = maxHealth;
			ObjectLayer = objectLayer;
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			caw = new bossVultureSound();
			vol = new SoundTransform(0.7,0);
			this.hitbox.visible = false;
			this.hurtbox.visible = false;
			
			driftRotation = rotation;
		}
		public function EnterFrame(event:Event){
			rotationDifference = this.rotation - rotateTo;
			if(spawning){
				if(x != 650){
					x--;
				}else{
					spawnTimer++
				}
				if(spawnTimer == 180){
					spawning = false;
				}
			}else{
				
				if(health > 35){
					speedMax = 4;
					delayMax = 90;
				}
				if (health <= 35){
					if(health > 20){
						speedMax = 5;
						delayMax = 60;
					}
				}
				if(health <= 20){
					if(health > 10){
						speedMax = 6;
						delayMax = 45;
					}
				}
				if(health <= 10){
					speedMax = 7;
					delayMax = 30;
				}
				
				
				if(x < 0){
					x += speedMax + 2;
					charging = false;
				}
				if(y < 0){
					y += speedMax + 2;
					createShift();
					charging = false;
				}
				
				if(x > 800){
					x -= speedMax + 2;
					charging = false;
				}
				if(y > 550){
					y -= speedMax + 2;
					createShift();
					charging = false;
				}

				delay++;
				
				if(!charging){
					x -= speed * Math.cos(driftRotation * Math.PI / 180) * 2;
					y -= speed * Math.sin(driftRotation * Math.PI / 180) * 2;
					chargeTime = 0;
					speed = speed * 0.9;
					delayOffset = delayMax * 0.95;
					
					if(delay >= delayMax){
						createBoost();
						caw.play(0, 0, vol);
						charging = true;
						if(carter.x < x){
							direction = 1;
						}else{
							direction = 2;
						}
					}
					if(delay < delayOffset){
						rotation += trueRotation;
					}
					var carterY = Math.floor(carter.y + (carter.height / 2));
					var carterX = Math.floor(carter.x + (carter.width / 2));
					
					rotateTo = Math.atan2(this.y - carterY, this.x - carterX) * 180 / Math.PI;
					
					if(rotationDifference < 10){
						rotation = rotateTo;
					}else{
						trueRotation = Math.floor((rotateTo - rotation) / 5);
					}
					
					
					
				}else if (charging){
					chargeTime++;
					speed = speedMax;
					delay = 0;
					x -= speed * Math.cos(rotation * Math.PI / 180) * 2;
					y -= speed * Math.sin(rotation * Math.PI / 180) * 2;
					if(chargeTime > minTime){
						if(direction == 1){
							if(x < carter.x){
								driftRotation = rotation;
								createShift();
								charging = false;
							}
						}else if(direction == 2){
							if(x > carter.x){
								driftRotation = rotation;
								createShift();
								charging = false;
							}
						}
					}
				}
				for(var i:int = 0;i<SlashContainer.numChildren;i++){
					var slashTarget:MovieClip = MovieClip(SlashContainer.getChildAt(i));
					if(this.hitbox.hitTestObject(slashTarget.hitbox)){
						slashTarget.slashHealth--;
						health--;
						carter.receiveDrive(1);
						trace("wut");
						var sound = new soundCharSlashHit();
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
			
				if(this.hurtbox.hitTestObject(carter.hitbox)){
					carter.hurt(1);
				}
				if(health <= 0){
					main.resetMusic();
					carter.receiveScore(1500);
					createPickup(4, 1.5);
					createExplosion();
					main.paused = false;
					killed = true;
					removeEventListener(Event.ENTER_FRAME, EnterFrame);
					this.parent.removeChild(this);
				}
			}
		}
		private function createPickup(Passive, Speed){
			pickup = new passivePickup(Passive, Speed, carter);
			ObjectLayer.addChild(pickup);
			pickup.x = this.x;
			pickup.y = this.y;
		}
		private function createBoost(){
			boost = new bossVultureBoost();
			ObjectLayer.addChild(boost);
			boost.x = this.x;
			boost.y = this.y;
			boost.rotation = rotation;
		}
		private function createShift(){
			shift = new bossVultureShift(this);
			ObjectLayer.addChild(shift);
			shift.x = this.x;
			shift.y = this.y;
			shift.rotation = rotation;
		}
		private function createExplosion(){
			explode = new explosion(x+width/2, y+height/2, 1.3);
			ObjectLayer.addChild(explode);
		}
	}
	
}
