package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class buttonRestart extends MovieClip {
		
		private var main;
		private var popup;
		private var buttonHover;
		private var buttonClick;
		
		public function buttonRestart(Main, Popup) {
			addEventListener(MouseEvent.CLICK, OnRelease);
			main = Main;
			popup = Popup;
			buttonMode = true;
			
			buttonClick = new soundButtonClick();
		}
		public function OnRelease(event: MouseEvent){
			buttonClick.play();
			popup.Unload();
			main.loadLevel();
		}
		public function Delete(){
			removeEventListener(MouseEvent.CLICK, OnRelease);
			this.parent.removeChild(this);
		}
	}
	
}
