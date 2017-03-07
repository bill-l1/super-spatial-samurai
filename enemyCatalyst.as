package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class enemyCatalyst extends MovieClip {
		
		private var speed;
		private var SlashContainer:MovieClip;
		private var carter;
		private var health;
		private var ObjectLayer;
		private var droneLaserContainer;
		private var timer = 0;
		private var rotateTimes = 0;
		private var sphere;
		private var trueSpeed;
		private var shooting:Boolean = false;
		private var entering:Boolean = true;
		private var charging:Boolean = false;
		private var exiting:Boolean = false;
		private var direction = 1;
		private var explode;
		private var sound;
		
		public function enemyCatalyst(Speed:Number, enemyHealth, slashContainerChild, ObjectLayerTarget, DroneLaserContainer, carterTarget) {
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
			if(entering){
				x -= speed / 2;
				if(x < 650){
					shooting = true;
					gotoAndStop(2);
					entering = false;
				}
			}else{
				if(shooting){
					timer++;
					trueSpeed = Math.floor((carter.y - y) / 50);
					y += trueSpeed;
					if(timer == 60){
						createSphere(2);
						gotoAndStop(1);
					}else if(timer == 90){
						timer = 0;
						if(rotateTimes == 1){
							if(direction == 2){
								charging = false;
								shooting = false;
								scaleX = 1;
								x -= width;
								exiting = true;
							}else{
								charging = true;
								shooting = false;
							}
						}else{
							charging = true;
							shooting = false;
						}
					}
				}else{
					if(charging){
						if(direction == 1){
							x -= speed;
							if(x < 0){
								scaleX = -1;
								x += width;
								shooting = true;
								gotoAndStop(2);
								direction = 2;
								charging = false;
							}
						}else if(direction == 2){
							x += speed;
							if(x > 800){
								scaleX = 1;
								x -= width;
								shooting = true;
								gotoAndStop(2);
								direction = 1;
								rotateTimes++;
								charging = false;
							}
						}
					}
				}
				if(exiting){
					x -= speed;
				}
				if(x<-150){
					removeEventListener(Event.ENTER_FRAME, EnterFrame);
					this.parent.removeChild(this);
				}
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
				carter.receiveScore(200);
				removeEventListener(Event.ENTER_FRAME, EnterFrame);
				this.parent.removeChild(this);
			}
			
		}

		private function createSphere(Speed){
			sphere = new enemySphere(Speed, carter);
			ObjectLayer.addChild(sphere);
			sphere.x = this.x;
			sphere.y = Math.floor(this.y + (this.height/2));
		}
		private function createExplosion(){
			explode = new explosion(x+width/2, y+height/2, 1);
			ObjectLayer.addChild(explode);
		}
	}
	
}
