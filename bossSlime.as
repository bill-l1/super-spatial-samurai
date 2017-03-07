package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class bossSlime extends MovieClip {
		
		private var speed = 2;
		private var SlashContainer:MovieClip;
		private var carter;
		public var health = 0;
		private var ObjectLayer;
		private var droneLaserContainer;
		private var timer = 0;
		private var main;
		private var laser;
		private var laserSpeed = 3;
		private var beam;
		private var beamSpeed = 5;
		private var army;
		private var chargeParticle;
		private var tentacle;
		private var tentacleSpeed = 5;
		private var attackRotation = 0;
		
		private var firingA = false;
		private var firingB = false;
		private var rotateToA = 0;
		private var rotateToB = 0;
		private var trueRotationA = 0;
		private var trueRotationB = 0;
		private var cannonTimer = 0;
		private var cannonTimerMax = 500;
		public var rotateSpeed = 0.1;
		
		private var direction = 0;
		private var shifting = true;
		private var returning = false;
		private var returnDirection = 0;
		private var phase = 0;
		
		private var cannonMaxHealth = 0;
		private var plateMaxHealth = 0;
		
		private var cannonAHealth = 0;
		private var cannonBHealth = 0;
		
		private var shieldHealth = 0;
		
		private var plateAHealth = 0;
		private var plateBHealth = 0;
		
		private var cannonADestroyed = false;
		private var cannonBDestroyed = false;
		
		private var plateADestroyed = false;
		private var plateBDestroyed = false;
		
		public var spawning = true;
		public var killed = false;
		private var boom;
		private var explode;
		private var explosionTimer = 0;
		
		private var sound;
		
		public function bossSlime(Main, enemyHealth, cannonHealth, plateHealth,  ObjectLayerTarget, slashContainerChild, DroneLaserContainer, carterTarget) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			main = Main;
			
			health = enemyHealth;
			cannonMaxHealth = cannonHealth;
			plateMaxHealth = plateHealth;
			
			cannonAHealth = cannonMaxHealth;
			cannonBHealth = cannonMaxHealth;
			
			plateAHealth = plateMaxHealth;
			plateBHealth = plateMaxHealth;
			
			SlashContainer = slashContainerChild;
			carter = carterTarget;
			ObjectLayer = ObjectLayerTarget;
			droneLaserContainer = DroneLaserContainer;
			
			this.mouth.addFrameScript(80, mouthReset);
			this.mouth.addFrameScript(99, mouthReset);
			
			this.hitbox.visible = false;
			this.tentacleA.cannon.hitbox.visible = false;
			this.tentacleB.cannon.hitbox.visible = false;
			this.plateA.hitbox.visible = false;
			this.plateB.hitbox.visible = false;
		}
		
		
		public function EnterFrame(event:Event){
			if(spawning){
				timer++;
				if(timer == 10){
					createArmy();
				}
				if(timer > 30){
					if(x < 550){
						if(timer == 400){
							timer = 0;
							direction = 1;
							speed = 1;
							spawning = false;
						}
					}else{
						x -= speed;
					}
				}
				
			}else{
				if(cannonADestroyed && cannonBDestroyed){
					if(plateADestroyed && plateBDestroyed){
						phase = 2;
					}else{
						phase = 1;
					}
				}else{
					phase = 0;
				}
				
				if(shifting){
					if(direction == 1){
						if(y > 325){
							timer++
							if(timer == 30){
								direction = 2;
								timer = 0;
							}
						}else{
							y += speed;	
						}
					}else if(direction == 2){
						if(y < 250){
							timer++
							if(timer == 30){
								direction = 1;
								timer = 0;
							}
						}else{
							y -= speed;
						}
					}
					if(phase >= 1){
						if(y > 280){
							returnDirection = 2;
						}else{
							returnDirection = 1;
						}
						timer = 0;
						returning = true;
						shifting = false;
					}
				}else{
					
					if(returning){
						if(returnDirection == 1){
							if(y <= 280){
								y += speed;	
							}else{
								returning = false;
							}
						}
						if(returnDirection == 2){
							if(y >= 280){
								y -= speed;	
							}else{
								returning = false;
							}
						}
					}
				}
				for(var i:int = 0;i<SlashContainer.numChildren;i++){
					var slashTarget:MovieClip = MovieClip(SlashContainer.getChildAt(i));
					if(phase == 0){
						if(!cannonADestroyed){
							if(this.tentacleA.cannon.hitbox.hitTestObject(slashTarget.hitbox)){
								slashTarget.slashHealth--;
								cannonAHealth--;
								carter.receiveDrive(1);
								trace("wut");
								sound = new soundCharSlashHit();
								sound.play();
							}
						}
						if(!cannonBDestroyed){
							if(this.tentacleB.cannon.hitbox.hitTestObject(slashTarget.hitbox)){
								slashTarget.slashHealth--;
								cannonBHealth--;
								carter.receiveDrive(1);
								trace("wut");
								sound = new soundCharSlashHit();
								sound.play();
							}
						}
					}else if(phase == 1){
						if(!plateADestroyed){
							if(this.plateA.hitbox.hitTestObject(slashTarget.hitbox)){
								slashTarget.slashHealth--;
								plateAHealth--;
								carter.receiveDrive(1);
								trace("wut");
								sound = new soundCharSlashHit();
								sound.play();
							}
						}
						if(!plateBDestroyed){
							if(this.plateB.hitbox.hitTestObject(slashTarget.hitbox)){
								slashTarget.slashHealth--;
								plateBHealth--;
								carter.receiveDrive(1);
								trace("wut");
								sound = new soundCharSlashHit();
								sound.play();
							}
						}
					}
					if(phase == 2){
						if(this.hitbox.hitTestObject(slashTarget.hitbox)){
							slashTarget.slashHealth--;
							health--;
							carter.receiveDrive(1);
							trace("wut");
							sound = new soundCharSlashHit();
								sound.play();
						}
						
					}
				}
			
				for(var o:int = 0;o<droneLaserContainer.numChildren;o++){
					var droneLaserTarget:MovieClip = MovieClip(droneLaserContainer.getChildAt(o));
					if(phase == 0){
						if(!cannonADestroyed){
							if(this.tentacleA.cannon.hitbox.hitTestObject(droneLaserTarget.hitbox)){
								droneLaserTarget.droneLaserHealth--;
								cannonAHealth--;
								trace("wut");
								sound = new soundCharSlashHit();
								sound.play();
							}
						}
						if(!cannonBDestroyed){
							if(this.tentacleB.cannon.hitbox.hitTestObject(droneLaserTarget.hitbox)){
								droneLaserTarget.droneLaserHealth--;
								cannonBHealth--;
								trace("wut");
								sound = new soundCharSlashHit();
								sound.play();
							}
						}
					}else if(phase == 1){
						if(!plateADestroyed){
							if(this.plateA.hitbox.hitTestObject(droneLaserTarget.hitbox)){
								droneLaserTarget.droneLaserHealth--;
								plateAHealth--;
								trace("wut");
								sound = new soundCharSlashHit();
								sound.play();
							}
						}
						if(!plateBDestroyed){
							if(this.plateB.hitbox.hitTestObject(droneLaserTarget.hitbox)){
								droneLaserTarget.droneLaserHealth--;
								plateBHealth--;
								trace("wut");
								sound = new soundCharSlashHit();
								sound.play();
							}
						}
					}else if(phase == 2){
						if(this.hitbox.hitTestObject(droneLaserTarget.hitbox)){
							droneLaserTarget.droneLaserHealth--;
							health--;
							carter.receiveDrive(1);
							trace("wut");
							sound = new soundCharSlashHit();
								sound.play();
						}
					}
				}
			
				if(this.hitbox.hitTestObject(carter.hitbox)){
					carter.hurt(1);
				}else if(this.plateA.hitbox.hitTestObject(carter.hitbox)){
					carter.hurt(1);
				}else if(this.plateB.hitbox.hitTestObject(carter.hitbox)){
					carter.hurt(1);
				}else if(this.tentacleA.cannon.hitbox.hitTestObject(carter.hitbox)){
					carter.hurt(1);
				}else if(this.tentacleB.cannon.hitbox.hitTestObject(carter.hitbox)){
					carter.hurt(1);
				}
				
				if(health <= 0){
					killed = true;
					if(timer == 0){
						var deathSound = new soundBossSlimeDeath();
						deathSound.play();
					}
					timer++;
					explosionTimer++;
					if(timer == 300){
						removeThis();
					}
					if(explosionTimer == 11){
						createRandomExplosion();
						explosionTimer = 0;
					}
				}
				
				var carterY = Math.floor(carter.y + (carter.height / 2));
				var carterX = Math.floor(carter.x + (carter.width / 2));
				
				var globalPointA:Point = new Point(this.tentacleA.cannon.x, this.tentacleA.cannon.y);
				globalPointA = this.tentacleA.localToGlobal(globalPointA);
				rotateToA = Math.atan2(globalPointA.y - carterY, globalPointA.x - carterX) * 180 / Math.PI;
				trueRotationA = Math.floor((rotateToA - this.tentacleA.cannon.rotation) / 5);
				
			
				var globalPointB:Point = new Point(this.tentacleB.cannon.x, this.tentacleB.cannon.y);
				globalPointB = this.tentacleB.localToGlobal(globalPointB);
				rotateToB = Math.atan2(globalPointB.y - carterY, globalPointB.x - carterX) * 180 / Math.PI;
				trueRotationB = Math.floor((rotateToB - this.tentacleB.cannon.rotation) / 5);

				
				
				if(cannonTimer != cannonTimerMax){
					cannonTimer++;
				}else{
					if(attackRotation == 1){
						attackRotation = 0;
					}else if(attackRotation == 0){
						attackRotation = 1
					}
					roar();
					cannonTimer = 0;
				}
				
				if(phase == 1){
					if(attackRotation == 0){
						if(cannonTimer == 180){
							createTentacle(tentacleSpeed, 2)
						}
					}else if(attackRotation == 1){
						if(cannonTimer == 200){
							createTentacle(tentacleSpeed, 1)
						}else if(cannonTimer == 240){
							createTentacle(tentacleSpeed, 2)
						}
					}
				}else if(phase == 2){
					if(attackRotation == 0){
						if(cannonTimer == 180){
							createTentacle(tentacleSpeed, 1)
						}else if(cannonTimer == 360){
							createTentacle(tentacleSpeed, 2)
						}
					}else if(attackRotation == 1){
						if(cannonTimer == 200){
							createTentacle(tentacleSpeed, 2)
						}else if(cannonTimer == 230){
							createTentacle(tentacleSpeed, 1)
						}else if(cannonTimer == 260){
							createTentacle(tentacleSpeed, 2)
						}
					}
				}
				
				
				if(!cannonADestroyed){
					if(cannonTimer == 60){
						createLaser(laserSpeed, globalPointA);
					}else if(cannonTimer == 150){
						createLaser(laserSpeed, globalPointA);
					}else if(cannonTimer == 240){
						createLaser(laserSpeed, globalPointA);
					}else if(cannonTimer == 320){
						createLaser(laserSpeed, globalPointA);
					}else if(cannonTimer == 410){
						createLaser(laserSpeed, globalPointA);
					}else if(cannonTimer == 500){
						createLaser(laserSpeed, globalPointA);
					}else if(cannonTimer == 590){	
						createLaser(laserSpeed, globalPointA);
					}
				}else{
					firingA = true;
					if(cannonTimer == 60){
						createChargeParticle(120, this.tentacleA.cannon);
					}else if(cannonTimer == 180){
						if(phase == 0){
							createBeam(beamSpeed, 120, this.tentacleA.cannon)
						}else if(phase == 1){
							createBeam(beamSpeed + 2, 120, this.tentacleA.cannon)
						}else if(phase == 2){
							createBeam(beamSpeed + 3, 240, this.tentacleA.cannon)
						}
					}
				}
				if(!cannonBDestroyed){
					if(cannonTimer == 60){
						createLaser(laserSpeed, globalPointB);
					}else if(cannonTimer == 150){
						createLaser(laserSpeed, globalPointB);
					}else if(cannonTimer == 240){
						createLaser(laserSpeed, globalPointB);
					}else if(cannonTimer == 320){
						createLaser(laserSpeed, globalPointB);
					}else if(cannonTimer == 410){
						createLaser(laserSpeed, globalPointB);
					}else if(cannonTimer == 500){
						createLaser(laserSpeed, globalPointB);
					}else if(cannonTimer == 590){
						createLaser(laserSpeed, globalPointB);
					}
				}else{
					firingB = true;
					if(cannonTimer == 60){
						createChargeParticle(120, this.tentacleB.cannon);
					}else if(cannonTimer == 180){
						if(phase == 0){
							createBeam(beamSpeed, 120, this.tentacleB.cannon)
						}else if(phase == 1){
							createBeam(beamSpeed + 2, 120, this.tentacleB.cannon)
						}else if(phase == 2){
							createBeam(beamSpeed + 3, 240, this.tentacleB.cannon)
						}
					}
				}
				
				if(!firingA){
					this.tentacleA.cannon.rotation += trueRotationA;
				}else{
					if(this.tentacleA.cannon.rotation > rotateToA){
						this.tentacleA.cannon.rotation -= rotateSpeed;
					}else{
						this.tentacleA.cannon.rotation += rotateSpeed;
					}
				}
				if(!firingB){
					this.tentacleB.cannon.rotation += trueRotationB;
				}else{
					if(this.tentacleB.cannon.rotation > rotateToB){
						this.tentacleB.cannon.rotation -= rotateSpeed;
					}else{
						this.tentacleB.cannon.rotation += rotateSpeed;
					}
				}
				
				
				if(cannonAHealth <= 0 && !cannonADestroyed){
					cannonADestroyed = true;
					this.tentacleA.cannon.gotoAndStop(2);
					createExplosion(globalPointA.x, globalPointA.y, 0.5);
				}
				if(cannonBHealth <= 0 && !cannonBDestroyed){
					cannonBDestroyed = true;
					this.tentacleB.cannon.gotoAndStop(2);
					createExplosion(globalPointB.x, globalPointB.y, 0.5);
				}
				if(plateAHealth <= 0 && !plateADestroyed){
					plateADestroyed = true;
					this.plateA.gotoAndStop(2);
					createExplosion(x + this.body.width/2, y + this.body.height/2, 1);
				}
				if(plateBHealth <= 0 && !plateBDestroyed){
					plateBDestroyed = true;
					this.plateB.gotoAndStop(2);
					createExplosion(x + this.body.width/2, y + this.body.height/2, 1);
				}
				
				shieldHealth = cannonAHealth + cannonBHealth;
				if(shieldHealth <= cannonMaxHealth){
					this.shield.gotoAndStop(2);
				}else{
					this.shield.gotoAndStop(1);
				}
				if(phase > 0){
					this.shield.visible = false;
				}
			}
			
		}
		private function mouthReset(){
			if(!killed){
				this.mouth.gotoAndPlay(1);
			}else{
				this.mouth.gotoAndPlay(81);
			}
		}
		
		private function createLaser(Speed, Cannon){
			laser = new enemyLaser(Speed, carter);
			ObjectLayer.addChild(laser);
			laser.x = Cannon.x;
			laser.y = Cannon.y;
		}
		private function createBeam(Speed, Duration, Cannon){
			beam = new enemyBeam(this, Speed, Duration, Cannon, carter, ObjectLayer);
			ObjectLayer.addChild(beam);
			beam.x = Cannon.x;
			beam.y = Cannon.y;
		}
		private function createTentacle(Speed, Direction){
			tentacle = new enemyTentacle(this, Speed, Direction, carter, SlashContainer, droneLaserContainer, ObjectLayer);
			ObjectLayer.addChild(tentacle);
		}
		private function createChargeParticle(Duration, Cannon){
			chargeParticle = new chargeUp(this, Duration, Cannon);
			ObjectLayer.addChild(chargeParticle);
			chargeParticle.x = Cannon.x;
			chargeParticle.y = Cannon.y;
		}
		private function createRandomExplosion(){
			boom = new explosion(Math.random()* width + x, Math.random()* height + y, 1);
			ObjectLayer.addChild(boom);
		}
		private function createExplosion(posX, posY, Scale){
			explode = new explosion(posX, posY, Scale);
			ObjectLayer.addChild(explode);
		}
		private function createArmy(){
			army = new slimeArmy();
			ObjectLayer.addChild(army);
			army.x = 800;
			army.y = 0;
		}
		private function roar(){
			this.mouth.gotoAndPlay(81);
			var slimeSound = new soundBossSlime();
			slimeSound.play();
		}
		private function removeThis(){
			main.paused = false;
			carter.receiveScore(100);
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
			this.parent.removeChild(this);
		}
	}
	
}
