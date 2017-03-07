package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class buttonMainMenuHelp extends MovieClip {
		
		private var main;
		private var ObjectLayer;
		private var buttonHover;
		private var buttonClick;
		
		public function buttonMainMenuHelp(objectLayer, Main) {
			addEventListener(MouseEvent.CLICK, OnRelease);
			addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			ObjectLayer = objectLayer;
			main = Main;
			this.button.Text.text = "Help";
			this.button.Text.mouseEnabled = false;
			buttonMode = true;
			buttonHover = new soundButtonHover();
			buttonClick = new soundButtonClick();
		}
		public function OnRelease(event: MouseEvent){
			buttonClick.play();
			main.loadHelp(1);
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
