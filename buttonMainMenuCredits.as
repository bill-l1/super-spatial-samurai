package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class buttonMainMenuCredits extends MovieClip {
		
		private var main;
		private var buttonHover;
		private var buttonClick;
		
		public function buttonMainMenuCredits(Main) {
			addEventListener(MouseEvent.CLICK, OnRelease);
			addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			main = Main;
			buttonMode = true;
			
			buttonHover = new soundButtonHover();
			buttonClick = new soundButtonClick();
		}
		public function OnRelease(event: MouseEvent){
			buttonClick.play();
			main.loadCredits();
		}
		public function MouseOver(event: MouseEvent){
			buttonHover.play();
			this.gotoAndStop(2);
		}
		public function MouseOut(event: MouseEvent){
			this.gotoAndStop(1);
		}
		
		public function Delete(){
			removeEventListener(MouseEvent.CLICK, OnRelease);
			removeEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, MouseOut);
		}
	}
	
}
