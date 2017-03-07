package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class evan extends MovieClip {
		
		private var main;
		private var Crystal:crystal;
		private var crystalSpawned = false;
		private var speed = 3;
		private var crystalSpeed = -5;
		private var timer = 0;
		private var exiting = false;
		private var ObjectLayer;
		
		public function evan(Main, objectLayer) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			main = Main;
			ObjectLayer = objectLayer;
		}
		public function EnterFrame(event:Event){
			if(!exiting){
				if(y < 200){
					y += speed;
				}else{
					timer++;
				}
				if(timer == 90){
					spawnCrystal();
					exiting = true;
				}
			}else{
				this.x += speed + 2;
			}
			if(crystalSpawned){
				Crystal.rotation -= 2;
				Crystal.x += crystalSpeed;
				crystalSpeed += 0.1;
				if(Crystal.x > 900){
					main.paused = false;
					removeEventListener(Event.ENTER_FRAME, EnterFrame);
					ObjectLayer.removeChild(Crystal);
					this.parent.removeChild(this);
				}
			}
		}
		public function spawnCrystal() {
			Crystal = new crystal();
			ObjectLayer.addChild(Crystal);
			Crystal.x = x;
			Crystal.y = y + 20;
			crystalSpawned = true;
		}
	}
	
}
