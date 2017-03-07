package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class enemyHazardBoulder extends MovieClip {
		
		private var speed;
		private var SlashContainer:MovieClip;
		private var carter;
		private var droneLaserContainer;
		private var sound;
		
		public function enemyHazardBoulder(Speed:Number, Scale, slashContainerChild, DroneLaserContainer, carterTarget) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			speed = Speed;
			SlashContainer = slashContainerChild;
			droneLaserContainer = DroneLaserContainer;
			carter = carterTarget;
			this.hitbox.visible = false;
			scaleX = Scale;
			scaleY = Scale;
		}
		public function EnterFrame(event:Event){
			x -= speed;
			rotation -= speed;
			
			for(var i:int = 0;i<SlashContainer.numChildren;i++){
				var slashTarget:MovieClip = MovieClip(SlashContainer.getChildAt(i));
				if(this.hitbox.hitTestObject(slashTarget.hitbox)){
					slashTarget.slashHealth--;
					sound = new soundCharSlashHitMiss();
					sound.play();
				}
			}
			
			for(var o:int = 0;o<droneLaserContainer.numChildren;o++){
				var droneLaserTarget:MovieClip = MovieClip(droneLaserContainer.getChildAt(o));
				if(this.hitbox.hitTestObject(droneLaserTarget.hitbox)){
					droneLaserTarget.droneLaserHealth--;
					sound = new soundCharSlashHitMiss();
					sound.play();
				}
			}
			
			if(this.hitbox.hitTestObject(carter.hitbox)){
				carter.hurt(1);
			}
		}
	}
	
}
