package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class buttonMainMenuNext extends MovieClip {
		
		private var main;
		private var frame;
		private var buttonHover;
		private var buttonClick;
		
		public function buttonMainMenuNext(Frame, Main) {
			addEventListener(MouseEvent.CLICK, OnRelease);
			addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			frame = Frame;
			main = Main;
			this.button.Text.text = "Next";
			this.button.Text.mouseEnabled = false;
			buttonMode = true;
			scaleX = 0.75;
			scaleY = 0.75;
			
			buttonHover = new soundButtonHover();
			buttonClick = new soundButtonClick();
		}
		public function OnRelease(event: MouseEvent){
			buttonClick.play();
			if(frame != 3){
				main.loadHelp(frame+1);
			}else{
				main.loadMenu();
			}
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
