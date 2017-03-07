package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class driveBar extends MovieClip {
		
		private var drive = 0;
		public var driveLevel = 0;
		public var scoreMultiplier = 0;
		private var maxDrive;
		private var timer;
		
		public function driveBar(MaxDrive) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			maxDrive = MaxDrive;
		}
		public function EnterFrame(event:Event){
			scoreMultiplier = driveLevel + 1;
			this.multiplierBox.levelText.text = scoreMultiplier;
			this.multiplierBox.scaleX = Math.floor((scoreMultiplier + 1) / 2);
			this.multiplierBox.scaleY = Math.floor((scoreMultiplier + 1) / 2);
			
			gotoAndStop(drive + 1);
			if(timer == 0){
				drive--;
				timer = 15;
			}

			if(drive < 0){
				drive = 0;
			}else if(drive > maxDrive){
				drive = maxDrive;
			}
			if(drive < 20){
				driveLevel = 0;
			}else if(drive >= 20 && drive < 40){
				driveLevel = 1;
			}else if(drive >= 40 && drive < 58){
				driveLevel = 2;
			}else if(drive == 59){
				driveLevel = 3;
			}

			timer--;
		}
		public function addDrive(Drive:Number){
			drive += Drive;
			timer = 80;
		}
	}
	
}
