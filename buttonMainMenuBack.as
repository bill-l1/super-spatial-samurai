package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class buttonMainMenuBack extends MovieClip {
		
		private var main;
		private var frame;
		private var Type;
		private var buttonHover;
		private var buttonClick;
		
		public function buttonMainMenuBack(Frame, Main, Form) {
			addEventListener(MouseEvent.CLICK, OnRelease);
			addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			frame = Frame;
			main = Main;
			Type = Form;
			this.button.Text.text = "Back";
			this.button.Text.mouseEnabled = false;
			buttonMode = true;
			scaleX = 0.75;
			scaleY = 0.75;
			
			buttonHover = new soundButtonHover();
			buttonClick = new soundButtonClick();
		}
		public function OnRelease(event: MouseEvent){
			buttonClick.play();
			if(Type == 0){
				if(frame == 1){
					main.loadMenu();
				}else{
					main.loadHelp(frame-1);
				}
			}else if(Type == 1){
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
