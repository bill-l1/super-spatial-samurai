package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class buttonMainMenuPlay extends MovieClip {
		
		private var main;
		private var ExceptionLayer;
		private var screenFade;
		private var buttonHover;
		private var buttonClick;
		
		public function buttonMainMenuPlay(exceptionLayer, Main) {
			addEventListener(MouseEvent.CLICK, OnRelease);
			addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			ExceptionLayer = exceptionLayer;
			main = Main;
			this.button.Text.text = "Play";
			this.button.Text.mouseEnabled = false;
			buttonMode = true;
			
			buttonHover = new soundButtonHover();
			buttonClick = new soundButtonClick();
		}
		public function OnRelease(event: MouseEvent){
			buttonClick.play();
			trace(x);
			createScreenFade(0);
		}
		public function MouseOver(event: MouseEvent){
			buttonHover.play();
			this.gotoAndStop(2);
		}
		public function MouseOut(event: MouseEvent){
			this.gotoAndStop(1);
		}
		private function createScreenFade(Type){
			screenFade = new effectScreenFade(Type, main);
			ExceptionLayer.addChild(screenFade);
		}
		public function Delete(){
			removeEventListener(MouseEvent.CLICK, OnRelease);
			removeEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, MouseOut);
		}
	}
	
}
