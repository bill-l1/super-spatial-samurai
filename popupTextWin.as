package  {
	
	import flash.display.MovieClip;
	
	
	public class popupTextWin extends MovieClip {
		
		
		public function popupTextWin() {
			// constructor code
		}
		public function Delete(){
			this.parent.removeChild(this);
		}
	}
	
}
