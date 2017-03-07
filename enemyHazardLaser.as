package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class enemyHazardLaser extends MovieClip {
		
		private var speed;
		private var duration;
		private var dangerTime = 0;
		private var dangerTimeMax = 120;
		public var moving = false;
		private var time = 0;
		private var ObjectLayer;
		private var carter;
		private var danger;
		private var direction;
		private var homing = false;
		
		private var sound;
		
		public function enemyHazardLaser(Speed, Duration, Direction, Location, Homing, ObjectLayerTarget, carterTarget) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			speed = Speed;
			duration = Duration;
			carter = carterTarget;
			ObjectLayer = ObjectLayerTarget;
			direction = Direction;
			if(Direction == 1){
				rotation = 0;
				x = -50;
				y = Location;
			}else if(Direction == 2){
				rotation = 180;
				x = 850;
				y = Location;
			}else if(Direction == 3){
				rotation = 90;
				y = -20;
				x = Location;
			}else if(Direction == 4){
				rotation = -90;
				y = 570;
				x = Location;
			}
			if(Homing){
				homing = true;
			}
			createDanger();
			this.hitbox.visible = false;
			sound = new soundBeam();
					
		}
		
		public function EnterFrame(event:Event){
			if(dangerTime > dangerTimeMax){
				if(time < duration){
					time++;
					scaleX += speed;
				}else{
					scaleY -= 0.01;
					if(scaleY <= 0){
						removeThis();
					}
				}
				moving = true;
				sound.play();
			}else{
				dangerTime++;
				moving = false;
			}
			if(this.hitbox.hitTestObject(carter.hitbox)){
				carter.hurt(1);
			}
			if(direction == 1){
				danger.x = 70;
				danger.y = Math.floor(this.y - this.height);
			}else if(direction == 2){
				danger.x = 700;
				danger.y = Math.floor(this.y - this.height);
			}else if(direction == 3){
				danger.y = 70;
				danger.x = Math.floor(this.x - this.width);
			}else if(direction == 4){
				danger.y = 450;
				danger.x = Math.floor(this.x - this.width);
			}
			
			if(homing){
				if(direction == 1 || direction == 2){
					if(y > carter.y){
						y -= speed/8;
					}else{
						y += speed/8;
					}
				}else if(direction == 3 || direction == 4){
					if(x > carter.x){
						x -= speed/8;
					}else{
						x += speed/8;
					}
				}
			}
		}
		private function removeThis(){
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
			this.parent.removeChild(this);
		}
		
		private function createDanger(){
			danger = new enemyHazardDanger(this);
			ObjectLayer.addChild(danger);
			
		}
		
	}
	
}
