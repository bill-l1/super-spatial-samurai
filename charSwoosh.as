package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class charSwoosh extends MovieClip {
		
		private var driveBar;
		private var carter;
		public function charSwoosh(DriveBar, Carter) {
			driveBar = DriveBar;
			carter = Carter;
			colorControl();
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			addFrameScript(1, colorControl);
			addFrameScript(2, colorControl);
			addFrameScript(3, colorControl);
			addFrameScript(5, colorControl);
		}
		public function EnterFrame(event:Event){
			x = carter.x + 20;
			y = carter.y;
			if(currentFrame == 6 ){
				removeListeners();
				this.parent.removeChild(this);
			}
			if(driveBar.driveLevel == 0){
				this.swoosh.gotoAndStop(1);
			}else if(driveBar.driveLevel == 1){
				this.swoosh.gotoAndStop(2);
			}else if(driveBar.driveLevel >= 2){
				this.swoosh.gotoAndStop(3);
			}
		}		
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		private function colorControl(){
			if(driveBar.driveLevel == 0){
				this.swoosh.gotoAndStop(1);
			}else if(driveBar.driveLevel == 1){
				this.swoosh.gotoAndStop(2);
			}else if(driveBar.driveLevel >= 2){
				this.swoosh.gotoAndStop(3);
			}
		}
	}
	
}
