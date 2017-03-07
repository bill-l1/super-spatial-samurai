package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.motion.Color;
	
	public class charSlash extends MovieClip {
		
		private var speed;
		public var slashHealth;
		private var driveBar;
		private var ObjectLayer;
		private var effect;
		private var tint;
		private var sound;
		
		public function charSlash(Health:Number, Speed:Number, DriveBar, objectLayer) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			driveBar = DriveBar;
			ObjectLayer = objectLayer;
			speed = Speed;
			slashHealth = Health;
			scaleY = 0.3;
			this.hitbox.visible = false;
			if(driveBar.driveLevel == 1){
				scaleY += 0.2;
				speed++;
			}else if(driveBar.driveLevel == 2){
				scaleY += 0.35;
				slashHealth++;
				speed += 3;
			}else if(driveBar.driveLevel == 3){
				scaleY += 0.5;
				slashHealth++;
				speed += 4;
			}
			tint = new Color;
			colorControl();
			sound = new soundCharSlashAttack();
			sound.play();
		}
		
		public function EnterFrame(event:Event){
			x += speed;
			if(x>800){
				removeThis();
				this.parent.removeChild(this);
			}
			
			if(slashHealth <= 0){
				trace("WOOOLOLOOLOLOL");
				removeThis();
				this.parent.removeChild(this);
			}
			
		}
		
		private function removeThis():void{
			createEffect();
			removeListeners();
			trace("rip in peperoni");
			
		}
		
		private function createEffect(){
			effect = new charSlashEffect();
			ObjectLayer.addChild(effect);
			effect.x = x;
			effect.y = Math.floor(y + height/2);
			if(driveBar.driveLevel == 1){
				effect.scaleX = 1.25;
				effect.scaleY = 1.25;
			}else if(driveBar.driveLevel == 2){
				effect.scaleX = 1.5;
				effect.scaleY = 1.5;
			}else if(driveBar.driveLevel == 3){
				effect.scaleX = 2;
				effect.scaleY = 2;
			}
			var swooshTint = new Color;
			if(driveBar.driveLevel == 0){
				swooshTint.setTint(0x00ffff, 0.8);
			}else if(driveBar.driveLevel == 1){
				swooshTint.setTint(0x00ff00, 0.8);
			}else if(driveBar.driveLevel >= 2){
				swooshTint.setTint(0xffff00, 0.8);
			}
			effect.transform.colorTransform = swooshTint;
		}
		
		private function colorControl(){
			if(driveBar.driveLevel == 0){
				tint.setTint(0x00ffff, 0.8);
			}else if(driveBar.driveLevel == 1){
				tint.setTint(0x00ff00, 0.8);
			}else if(driveBar.driveLevel >= 2){
				tint.setTint(0xffff00, 0.8);
			}
			transform.colorTransform = tint;
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}

	}
	
}
