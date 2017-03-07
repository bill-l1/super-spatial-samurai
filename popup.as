package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class popup extends MovieClip {
		
		private var menu;
		private var main;
		private var button;
		private var textbox;
		private var PauseButton;
		private var scoreBar;
		private var elementLayer:MovieClip;
		public function popup(Menu, Main, pauseButton, ScoreBar) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			menu = Menu;
			main = Main;
			PauseButton = pauseButton;
			scoreBar = ScoreBar;
			elementLayer = new MovieClip();
			addChild(elementLayer);
		}
		public function EnterFrame(event:Event){
			if(currentFrame == 14){
				Load();	
			}else if(currentLabel == "end"){
				Unload();
				PauseButton.createdPopup = false;
				removeEventListener(Event.ENTER_FRAME, EnterFrame);
				this.parent.removeChild(this);
			}
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		private function Load(){
			if(menu == 0){
				createButton(324, 265, 0);
				createButton(514, 0, 1);
				createButton(124, 265, 2);
				createText(75, 0);
			}else if(menu == 1){
				createButton(324, 265, 0);
				createButton(124, 265, 2);
				createText(75, 1);
			}
			stage.frameRate = 0;
		}
		public function Unload(){
			for(var i:int = 0;i<elementLayer.numChildren;i++){
				var target:MovieClip = MovieClip(elementLayer.getChildAt(i));
				target.Delete();
			}
			play();
			stage.frameRate = 60;
		}
		private function createButton(posX, posY, Type){
			if(Type == 0){
				button = new buttonRestart(main, this);
			}else if(Type == 1){
				button = new buttonClose(main, this);
			}else if(Type == 2){
				button = new buttonBack(main, this);
			}
			elementLayer.addChild(button);
			button.x = posX;
			button.y = posY;
		}
		private function createText(posY, Type){
			if(Type == 0){
				textbox = new popupTextPaused();
			}else if(Type == 1){
				textbox = new popupTextWin();
			}
			elementLayer.addChild(textbox);
			textbox.x = width/2 - textbox.width/2;
			textbox.y = posY;
		}
	}
	
}
