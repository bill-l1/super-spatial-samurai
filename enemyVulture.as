﻿package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class enemyVulture extends MovieClip {
		
		private var speed;
		private var SlashContainer:MovieClip;
		private var carter;
		private var health;
		private var droneLaserContainer;
		private var ObjectLayer;
		private var explode;
		private var sound;
		
		public function enemyVulture(Speed:Number, enemyHealth, slashContainerChild, DroneLaserContainer, carterTarget, objectLayer) {
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
			x -= speed;
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
				carter.receiveScore(50);
				removeEventListener(Event.ENTER_FRAME, EnterFrame);
				this.parent.removeChild(this);
			}
		}
		private function createExplosion(){
			explode = new explosion(x+width/2, y+height/2, 0.75);
			ObjectLayer.addChild(explode);
		}
	}
	
}
