package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.motion.Color;
	import flash.media.Sound;
	
	public class carter extends MovieClip {
				
		private var healthBar;
		private var driveBar;
		private var passiveBar;
		private var scoreBar;
		
		private var invinTimer = 60;
		public var speed;
		private var tint:Color;
		private var drone:charDrone;
		private var DroneLayer;
		private var UILayer;
		
		private var tintTimer = 0;
		
		private var passiveFlash;
		private var flashTint:Color;
		
		private var lightning;
		
		private var shieldActive:Boolean;
		
		private var droneMax = 0;
		
		private var collisionX;
		private var collisionY;
		
		private var edgeTint:Color;
		
		private var passiveSound;
		
		public function carter(HealthBar, DriveBar, PassiveBar, ScoreBar, droneLayer, uILayer, Speed) {
			this.hitbox.visible = false;
			healthBar = HealthBar;
			driveBar = DriveBar;
			passiveBar = PassiveBar;
			scoreBar = ScoreBar;
			speed = Speed;
			DroneLayer = droneLayer;
			UILayer = uILayer;
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			tint = new Color;
			edgeTint = new Color;
			
			addFrameScript(1, charOverlay);
			addFrameScript(2, charOverlay);
			addFrameScript(10, charOverlay);
		}
		public function attack(){			
			gotoAndPlay(2);
			trace("rrrrr");
		}
		public function hurt(Damage:Number){
			if(invinTimer == 60){
				driveBar.addDrive(-10);
				healthBar.getHurt(Damage);
				createLightning(0);
				invinTimer = 0;
			}else if(shieldActive){
				shieldActive = false;
				createLightning(1);
				driveBar.addDrive(20);
			}
		}
		public function receiveDrive(Drive){
			driveBar.addDrive(Drive);
		}
		public function receivePassive(Passive){
			passiveBar.addPassive(Passive);
		}
		public function receiveScore(Score){
			scoreBar.addScore(Score * driveBar.scoreMultiplier);
		}
		public function usePassive(Passive, Level){
			if (passiveBar.passive >= Passive) {
				passiveBar.passive -= Passive;
				if (Level == 1){
					if(speed <= 6){
						speed += 1;
						createPassiveBarFlash(1);
					}else{
						passiveBar.passive += Passive;
					}
				}else if(Level == 2){
					if(healthBar.charHealth < healthBar.maxHealth){
						healthBar.charHealth += 1;
						createPassiveBarFlash(2);
					}else{
						passiveBar.passive += Passive;
					}
				}else if(Level == 3){
					passiveBar.passive += Passive;
				
				}else if(Level == 4){
					if(droneMax <= 3){
						createPassiveBarFlash(4);
						spawnDrone();
					}else{
						passiveBar.passive += Passive;
					}
				}else if(Level == 5){
					if(!shieldActive){
						createPassiveBarFlash(5);
						shieldActive = true;
					}else{
						passiveBar.passive += Passive;
					}
					
				}
				if(Level != 3){
					passiveSound = new soundPassiveBarUpgrade();
					passiveSound.play();
				}
			}
		}
		
		public function EnterFrame(event:Event){
			if(invinTimer <= 50 && !shieldActive){
				tintTimer = 1;
			}else{
				if(tintTimer >= 0){
					tintTimer -= 0.05;
				}
			}
			if(invinTimer != 60){
				invinTimer++;
			}
			if(shieldActive == true){
				invinTimer = -180;
				tintTimer = 0.5;
				tint.setTint(0x00ccff, 1);
				healthBar.shieldActive = true;
			}else{
				tint.setTint(0xff0000, tintTimer);
				healthBar.shieldActive = false;
			}
			
			
			if(x < 0){
				x += speed;
			}
			if(y < 0){
				y += speed;
			}
			collisionX = x + width;
			collisionY = y + height;
			if(collisionX > 800){
				x -= speed;
			}
			if(collisionY > 550){
				y -= speed;
			}

			if(speed >= 7){
				passiveBar.box1.text = "MAX";
			}else{
				passiveBar.box1.text = "Speed";
			}
			if(healthBar.charHealth >= healthBar.maxHealth){
				passiveBar.box2.text = "MAX";	
			}else{
				passiveBar.box2.text = "Health";
			}
			if(droneMax >= 4){
				passiveBar.box4.text = "MAX";
			}else{
				passiveBar.box4.text = "Drone";
			}
			if(shieldActive){
				passiveBar.box5.text = "MAX";
			}else{
				passiveBar.box5.text = "Shield";
			}
			if(healthBar.charHealth <= 1){
				edgeTint.setTint(0xff9966, 1);
			}else if(healthBar.charHealth == 2){
				edgeTint.setTint(0xccff66, 1);
			}else if(healthBar.charHealth == 3){
				edgeTint.setTint(0x66ffcc, 1);
			}
			charOverlay();
		}
		
		private function charOverlay(){
			this.overlay.transform.colorTransform = tint;
			this.overlay.alpha = tintTimer;
			this.char.edge.transform.colorTransform = edgeTint;
			
			if(driveBar.driveLevel == 0){
				this.char.gotoAndStop(1);
			}else if(driveBar.driveLevel == 1){
				this.char.gotoAndStop(2);
			}else if(driveBar.driveLevel >= 2){
				this.char.gotoAndStop(3);
			}
			
			if(speed == 4){
				this.fire.gotoAndStop(1);
			}else if(speed == 5){
				this.fire.gotoAndStop(2);
			}else if(speed == 6){
				this.fire.gotoAndStop(3);
			}else if(speed == 7){
				this.fire.gotoAndStop(4);
			}
		}
		private function spawnDrone(){
			drone = new charDrone(this);
			DroneLayer.addChild(drone);
			for(var i:int = 0;i<DroneLayer.numChildren;i++){
				var droneTarget:MovieClip = MovieClip(DroneLayer.getChildAt(i));
				if(i == 0){
					droneTarget.gotoAndPlay(0);
				}else if(i == 1){
					droneTarget.gotoAndPlay(30);
				}else if(i == 2){
					droneTarget.gotoAndPlay(15);
				}else if(i == 3){
					droneTarget.gotoAndPlay(45);
				}
			}
			droneMax = DroneLayer.numChildren;
		}
		private function createPassiveBarFlash(Level){
			passiveFlash = new passiveBarFlash();
			UILayer.addChild(passiveFlash);
			
			passiveFlash.scaleX = 0.752;
			flashTint = new Color;1
			if (Level == 1){
				passiveFlash.x = 10;
				flashTint.setTint(0x00cc99, 1);
			}else if (Level == 2){
				passiveFlash.x = 120;
				flashTint.setTint(0x00ff00, 1);
			}else if (Level == 3){
				passiveFlash.x = 230;
				flashTint.setTint(0xffff00, 1);
			}else if (Level == 4){
				passiveFlash.x = 340;
				flashTint.setTint(0xff9933, 1);
			}else if (Level == 5){
				passiveFlash.x = 450;
				flashTint.setTint(0xff0000, 1);
			}
			passiveFlash.y = 32;
			passiveFlash.transform.colorTransform = flashTint;
		}
		private function createLightning(Type){
			lightning = new effectLightning();
			UILayer.addChild(lightning);
			lightning.x = 600;
			lightning.scaleX = 0.85
			
			var lightningTint = new Color;
			if(Type == 0){
				lightningTint.setTint(0xff0000, 1);
				lightning.y = -20;
			}else if(Type == 1){
				lightningTint.setTint(0xffff00, 1);
				lightning.scaleY = 1.5
				lightning.y = -25;
			}
			lightning.transform.colorTransform = lightningTint;
		}
	}
	
}
