package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.media.Sound;
	
	
	public class buttonClose extends MovieClip {
		
		private var main;
		private var popup;
		private var buttonHover;
		private var buttonClick;
		
		public function buttonClose(Main, Popup) {
			addEventListener(MouseEvent.CLICK, OnRelease);
			main = Main;
			popup = Popup;
			buttonMode = true;
			
			buttonHover = new soundButtonHover();
			buttonClick = new soundButtonClick();
		}
		public function OnRelease(event: MouseEvent){
			buttonClick.play();
			popup.Unload();
		}
		public function Delete(){
			removeEventListener(MouseEvent.CLICK, OnRelease);
			this.parent.removeChild(this);
		}
	}
	
}
