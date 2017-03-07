package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class enemyHealthBar extends MovieClip {
		
		public var enemyHealth;
		public var maxHealth;
		public var dead:Boolean;
		private var frameMultiplier = 0;
		private var boss;
		private var timer = 0;
		private var delay = 0;
		
		public function enemyHealthBar(MaxHealth, Boss) {
			maxHealth = MaxHealth;
			boss = Boss;
			addEventListener(Event.ENTER_FRAME, EnterFrame);
		}
		public function EnterFrame(event:Event){
			enemyHealth = boss.health;
			if(boss.spawning){
				if(delay > 30){
					if(timer <= 100){
						gotoAndStop(Math.round(timer + 1));
						timer += 0.5
					}
				}else{
					delay++;
				}
			}else{
				frameMultiplier = 100/maxHealth;
				gotoAndStop(Math.round(enemyHealth * frameMultiplier) + 1);
			}
			if(boss.killed){
				removeEventListener(Event.ENTER_FRAME, EnterFrame);
				this.parent.removeChild(this);
			}
		}
	}
	
}
