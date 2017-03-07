package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import src.com.aem.utils.HitTest;
	
	public class enemyBeam extends MovieClip {
		
		private var speed = 2;
		private var duration = 0;
		private var timer = 0;
		private var anchor;
		private var boss;
		private var carter;
		private var rotateTo = 0;
		private var trueRotation = 0;
		private var carterX = 0;
		private var carterY = 0;
		private var ObjectLayer;
		private var hitTest:HitTest;
		private var carterPoint:disposableHitbox;
		
		private var sound;
		
		public function enemyBeam(Boss, Speed, Duration, Anchor, carterTarget, objectLayer) {
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			speed = Speed;
			duration = Duration;
			anchor = Anchor;
			boss = Boss;
			carter = carterTarget;
			ObjectLayer = objectLayer;
			hitTest = new HitTest();
			rotation = anchor.rotation;
			carterY = Math.floor(carter.y + (carter.height / 2));
			carterX = Math.floor(carter.x + (carter.width / 2));
			carterPoint = new disposableHitbox();
			ObjectLayer.addChild(carterPoint);
			carterPoint.x = carterX;
			carterPoint.y = carterY;
			carterPoint.visible = false;
			sound = new soundBeam();
			this.hitbox.visible = false;
		}
		public function EnterFrame(event:Event){
			if(boss.killed){
				removeListeners();
				this.parent.removeChild(this);
			}
			var anchorPoint:Point = new Point(anchor.x, anchor.y);
			anchorPoint = anchor.parent.localToGlobal(anchorPoint);
			carterY = Math.floor(carter.y + (carter.height / 2));
			carterX = Math.floor(carter.x + (carter.width / 2));
			carterPoint.x = carterX;
			carterPoint.y = carterY;
			
			
			
			if(HitTest.intersects(this, carterPoint, ObjectLayer)){
				carter.hurt(1);
				trace("dude");
			}
			
			if(timer == duration){
				x -= speed * Math.cos(this.rotation * Math.PI / 180) * 2;
				y -= speed * Math.sin(this.rotation * Math.PI / 180) * 2;
				scaleX -= speed;
				if(scaleX < 0){
					removeThis();
				}
			}else{
				x = anchorPoint.x;
				y = anchorPoint.y;
				scaleX += speed;
				sound.play();
				rotateTo = Math.atan2(this.y - carterY, this.x - carterX) * 180 / Math.PI;
				if(rotation > rotateTo){
					this.rotation -= boss.rotateSpeed;
				}else{
					this.rotation += boss.rotateSpeed;
				}
				timer++;
			}
		}
		private function removeThis():void{
			removeListeners();
			ObjectLayer.removeChild(carterPoint);
			this.parent.removeChild(this);
		}
		public function removeListeners():void{
			removeEventListener(Event.ENTER_FRAME, EnterFrame);
		}
	}
	
}
