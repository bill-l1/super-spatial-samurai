package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class enemyTentacle extends MovieClip {
		
		private var speed;
		private var drawSpeed = 1;
		private var carter;
		private var armed = false;
		private var charging = false;
		public var moving;
		private var drawing = false;
		private var direction = 0;
		private var timer = 0;
		private var SlashContainer;
		private var droneLaserContainer;
		private var boss;
		private var danger;
		private var ObjectLayer;
		private var sound;
		private var chargeSound;

		public function enemyTentacle(Boss, Speed:Number, Direction, carterTarget, slashContainerChild, DroneLaserContainer, objectLayer) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			speed = Speed;
			direction = Direction;
			//1 = from above, 2 = from below
			carter = carterTarget;
			SlashContainer = slashContainerChild;
			droneLaserContainer = DroneLaserContainer;
			boss = Boss;
			ObjectLayer = objectLayer;
			if(direction == 1){
				y = -100;
				rotation = -90;
			}else if(direction == 2){
				y = 650;
				rotation = 90;
			}
			createDanger();
			this.hitbox.visible = false;
		}
		public function EnterFrame(event:Event){
			moving = charging;
			if(boss.killed){
				removeListeners();
				if(!moving){
					danger.parent.removeChild(danger);
				}
				this.parent.removeChild(this);
			}
			var carterX = Math.floor(carter.x + (carter.width / 2));
			if(!armed){
				x = carterX;
				if(direction == 1){
					if(y < 0){
						y += speed;
					}else{
						armed = true;
					}
				}else if (direction == 2){
					if(y > 550){
						y -= speed;
					}else{
						armed = true;
					}
				}
			}else{
				
				if(!charging){
					timer++;
					if(timer <= 100){
						x = carterX;
					}
					if(timer == 120){
						chargeSound = new soundTentacle();
						chargeSound.play();
						charging = true;
						timer = 0;
					}
				}else{
				if(this.hitbox.hitTestObject(carter.hitbox)){
					carter.hurt(1);
				}
			for(var i:int = 0;i<SlashContainer.numChildren;i++){
				var slashTarget:MovieClip = MovieClip(SlashContainer.getChildAt(i));
				if(this.hitbox.hitTestObject(slashTarget.hitbox)){
					slashTarget.slashHealth--;
					drawSpeed++;
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
					drawSpeed++;
					trace("wut");
					sound = new soundCharSlashHit();
					sound.play();
				}
			}
					if(!drawing){
						
						if(direction == 1){
							if(y > 550){
								timer++;
								if(timer == 60){
									drawing = true;
								}
							}else{
								y -= speed * Math.sin(this.rotation * Math.PI / 180) * 2;
							}
						}else if(direction == 2){
							if(y < 0){
								timer++;
								if(timer == 60){
									drawing = true;
								}
							}else{
								y -= speed * Math.sin(this.rotation * Math.PI / 180) * 2;
							}
						}
					}else{
						y += drawSpeed * Math.sin(this.rotation * Math.PI / 180) * 2;
						if(direction == 1){
							if(y < -100){
								removeThis();
								this.parent.removeChild(this);
							}
						}else if (direction == 2){
							if(y > 650){
								removeThis();
								this.parent.removeChild(this);
							}
						}
					}
				}
			}
			
			if(direction == 1){
				danger.y = 70;
				danger.x = Math.floor(this.x - this.width + 20);
			}else if(direction == 2){
				danger.y = 400;
				danger.x = Math.floor(this.x - this.width + 20);
			}
			
			
			
		}
		private function removeThis():void{
			trace("rip");
			removeListeners();
			
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		private function createDanger(){
			danger = new enemyHazardDanger(this);
			ObjectLayer.addChild(danger);
			
		}
	}
	
}
