package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	public class buttonPause extends MovieClip {
		
		private var pop;
		private var UILayer;
		private var main;
		private var scoreBar;
		public var createdPopup = false;
		
		public function buttonPause(uILayer, Main, ScoreBar) {
			addEventListener(MouseEvent.CLICK, OnRelease);
			UILayer = uILayer;
			main = Main;
			scoreBar = ScoreBar;
			buttonMode = true;
		}
		public function OnRelease(event: MouseEvent){
			if(!createdPopup){
				createPopup();
				createdPopup = true;
				
			}
			trace("ooo");
		}
		private function createPopup(){
			pop = new popup(0, main, this, scoreBar);
			UILayer.addChild(pop);
			pop.x = 120;
			pop.y = 80;
		}
		public function Delete(){
			removeEventListener(MouseEvent.CLICK, OnRelease);
		}
	}
	
}
