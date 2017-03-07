package {

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;

	public class Main extends MovieClip {
		
		//level control
		public var level: Number;
		public var time: Number;
		public var paused : Boolean;

		//health/drive/passive
		public var HealthBar: healthBar;
		public var maxHealth: Number;

		public var DriveBar: driveBar;
		public var maxDrive;
	
		public var PassiveBar: passiveBar;
		public var maxPassive;
		
		public var ScoreBar:scoreBar;
		
		public var PauseButton : buttonPause;
		public var buttonPlay : buttonMainMenuPlay;
		public var buttonHelp : buttonMainMenuHelp;
		public var buttonCredits : buttonMainMenuCredits;
		public var title : logo;
		
		public var EnemyHealthBar: enemyHealthBar;

		//char controls
		public var char: carter;
		public var isAttacking: Boolean;
		public var speed;

		var moveleft: Boolean;
		var moveright: Boolean;
		var moveup: Boolean;
		var movedown: Boolean;
		var attackButtonDown: Boolean;

		public var slash: charSlash;
		public var slashSpeed;
		
		public var laser : droneLaser;
		public var laserSpeed;
		public var droneTimer;

		//enemies
		public var vulture: enemyVulture;
		public var cube: enemyCube;
		public var slime: enemySlime;
		public var wasp: enemyWasp;
		public var catalyst: enemyCatalyst;
		
		public var hazardLaser: enemyHazardLaser;
		public var hazardBoulder: enemyHazardBoulder;
		
		public var spawner: evan;
		public var vultureBoss : bossVulture;
		public var slimeBoss : bossSlime;

		//layers
		public var UILayer: MovieClip;
		public var slashContainer: MovieClip;
		public var droneLaserContainer : MovieClip;
		public var DroneLayer: MovieClip;
		public var ObjectLayer: MovieClip;
		public var ButtonLayer: MovieClip;
		public var ExceptionLayer: MovieClip;
		public var BackgroundLayer: MovieClip;
		
		private var starTimer = 0;
		private var starTimerMax = 10;
		private var starClip:star;
		
		public var helpClip:help;
		public var creditsClip:credits;
		
		private var songTitle:songTheme;
		private var channelMain:SoundChannel;
		private var transformMain:SoundTransform;
		
		private var songLevel:songStage;
		private var songBattle:songBoss;
		
		private var songWin:soundWin;
		
		public function Main() {
			loadMusic();
			loadInit();
			loadMenu();
			
		}
		public function loadMusic(){
			
			songTitle = new songTheme();
			songLevel = new songStage();
			songBattle = new songBoss();
			channelMain = new SoundChannel();
			transformMain = new SoundTransform(0.5, 0);
			SoundMixer.soundTransform = new SoundTransform(0.7);
		}
		public function loadMenu(){
			removeAll();
			
			
			function playTitle(){
				playSong(channelMain, songTitle, 0.5);
				
			}
			stopSound();
			var reveal = new effectReveal();
			ExceptionLayer.addChild(reveal);
			reveal.x = 0;
			reveal.y = 0;
			reveal.addFrameScript(120, playTitle);
			var lightning = new effectLightningDelay(30);
			ExceptionLayer.addChild(lightning);
			lightning.x = 262;
			lightning.y = -84;
			lightning.rotation = -90;
			lightning.scaleY = 4;
			//lightning.height = 238;
			
			spawnPlayButton();
			spawnHelpButton();
			spawnCreditsButton();
			spawnLogo();
		}
		public function playSong(Channel, Song, Volume){
			trace("ay lmao");
			transformMain = new SoundTransform(Volume, 0);
			Channel = Song.play(0, 9999, transformMain);
		}
		public function stopSound(){
			SoundMixer.stopAll();
		}
		public function resetMusic(){
			stopSound();
			playSong(channelMain, songLevel, 0.3);
		}
		public function loadHelp(frame){
			removeAll();
			
			helpClip = new help();
			UILayer.addChild(helpClip);
			helpClip.x = 0;
			helpClip.y = 0;
			helpClip.gotoAndStop(frame);
			
			var buttonBack = new buttonMainMenuBack(frame, this, 0);
			ButtonLayer.addChild(buttonBack);
			buttonBack.x = 30;
			buttonBack.y = 480;
			
			var buttonNext = new buttonMainMenuNext(frame, this);
			ButtonLayer.addChild(buttonNext);
			buttonNext.x = 570;
			buttonNext.y = 480;
			
		}
		public function loadCredits(){
			removeAll();
			creditsClip = new credits();
			UILayer.addChild(creditsClip);
			creditsClip.x = 0;
			creditsClip.y = 0;
			
			var buttonBack = new buttonMainMenuBack(0, this, 1);
			ButtonLayer.addChild(buttonBack);
			buttonBack.x = 580;
			buttonBack.y = 20;
		}
		public function loadInit(){
			UILayer = new MovieClip;
			stage.addChild(UILayer);
			
			slashContainer = new MovieClip;
			stage.addChild(slashContainer);
			
			droneLaserContainer = new MovieClip;
			stage.addChild(droneLaserContainer);
			
			DroneLayer = new MovieClip;
			stage.addChild(DroneLayer);
			
			ObjectLayer = new MovieClip;
			stage.addChild(ObjectLayer);
			
			ButtonLayer = new MovieClip;
			stage.addChild(ButtonLayer);
			
			ExceptionLayer = new MovieClip;
			stage.addChild(ExceptionLayer);
			
			BackgroundLayer = new MovieClip;
			stage.addChild(BackgroundLayer);
		}
		public function loadLevel0(){
			level = 0;
			time = 0;
			paused = false;
			
			maxHealth= 3;
			
			maxDrive = 59;
			
			maxPassive = 10;
			
			isAttacking = false;
			speed = 4;
			
			moveleft = false;
			moveright = false;
			moveup = false;
			movedown = false;
			attackButtonDown = false;
			
			slashSpeed = 10;
			
			laserSpeed = 20;
			droneTimer = 0;
			
			
			
			spawnHealthBar();
			spawnPassiveBar();
			spawnDriveBar();
			spawnScoreBar();
			spawnPauseButton();
			spawnChar();
			stage.addEventListener(Event.ENTER_FRAME, enterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
			stage.focus = this;
			
			char.addFrameScript(19, resetFrame);
			char.addFrameScript(10, createSlash);
			
		}

		public function enterFrame(event: Event) {
			
			if (moveleft) {
				char.x -= char.speed;
			} else if (moveright) {
				char.x += char.speed;
			}

			if (moveup) {
				char.y -= char.speed;
			} else if (movedown) {
				char.y += char.speed;
			}

			if (attackButtonDown) {
				if (isAttacking == false) {
					isAttacking = true;
					char.attack();
				}
			}
			if(!paused){
				time++;
			}
			checkTime(time, level);
			
			ExceptionLayer.parent.setChildIndex(ExceptionLayer, ExceptionLayer.parent.numChildren-1);
			ButtonLayer.parent.setChildIndex(ButtonLayer, ButtonLayer.parent.numChildren-2);
			UILayer.parent.setChildIndex(UILayer, UILayer.parent.numChildren-3);
			DroneLayer.parent.setChildIndex(DroneLayer, DroneLayer.parent.numChildren-4);
			slashContainer.parent.setChildIndex(slashContainer, slashContainer.parent.numChildren-5);
			droneLaserContainer.parent.setChildIndex(droneLaserContainer, droneLaserContainer.parent.numChildren-6);
			ObjectLayer.parent.setChildIndex(ObjectLayer, ObjectLayer.parent.numChildren-7);
			BackgroundLayer.parent.setChildIndex(BackgroundLayer, BackgroundLayer.parent.numChildren-8);
			
			if(starTimer != starTimerMax){
				starTimer++;
			}else{
				spawnStar();
				starTimer = 0;
			}
		}
		public function keyDown(event: KeyboardEvent) {

			switch (event.keyCode) {

				case Keyboard.LEFT:
					moveleft = true;
					break;
				case Keyboard.RIGHT:
					moveright = true;
					break;
				case Keyboard.UP:
					moveup = true;
					break;
				case Keyboard.DOWN:
					movedown = true;
					break;
				case Keyboard.SPACE:
					attackButtonDown = true;
					break;
			}
		}
		public function keyUp(event: KeyboardEvent) {
			switch (event.keyCode) {
				case Keyboard.LEFT:
					moveleft = false;
					break;
				case Keyboard.RIGHT:
					moveright = false;
					break;
				case Keyboard.UP:
					moveup = false;
					break;
				case Keyboard.DOWN:
					movedown = false;
					break;
				case Keyboard.SPACE:
					attackButtonDown = false;
					break;				
				case 49:
					char.usePassive(2, 1);
					break;
				case 50:
					char.usePassive(4, 2);
					break;
				case 51:
					char.usePassive(6, 3);
					break;
				case 52:
					char.usePassive(8, 4);
					break;
				case 53:
					char.usePassive(10, 5);
					break;
			}
		}

		public function spawnChar() {

			char = new carter(HealthBar, DriveBar, PassiveBar, ScoreBar, DroneLayer, UILayer, speed);
			ObjectLayer.addChild(char);
			char.scaleX = 0.5;
			char.scaleY = 0.5;
			char.x = 150;
			char.y = 250;
		}
		public function resetFrame(): void {
			isAttacking = false;
			gotoAndStop(1);

		}

		public function createSlash() {
			slash = new charSlash(1, slashSpeed, DriveBar, ObjectLayer);
			slashContainer.addChild(slash);
			slash.x = char.x;
			slash.y = char.y;
			if(droneTimer == 1){
				for(var i:int = 0;i<DroneLayer.numChildren;i++){
					var droneTarget:MovieClip = MovieClip(DroneLayer.getChildAt(i));
					createDroneLaser(Math.floor(droneTarget.droneBody.x + droneTarget.x), Math.floor(droneTarget.droneBody.y + droneTarget.y));
				}
				if(DroneLayer.numChildren != 0){
					var droneSound = new soundDroneLaser();
					droneSound.play();
				}
				droneTimer = 0;
			}else{
				droneTimer++
			}
			createSwoosh();
		}
		public function createSwoosh(){
			var swoosh = new charSwoosh(DriveBar, char);
			ObjectLayer.addChild(swoosh);
			swoosh.x = char.x + 20;
			swoosh.y = char.y;
			swoosh.scaleX = 0.5;
			swoosh.scaleY = 0.5;
		}
		public function createDroneLaser(X, Y) {
			laser = new droneLaser(1, laserSpeed);
			droneLaserContainer.addChild(laser);
			laser.x = X;
			laser.y = Y;
		}
		public function spawnVulture(enemyY: Number) {
			vulture = new enemyVulture(4, 1, slashContainer, droneLaserContainer, char, ObjectLayer);
			ObjectLayer.addChild(vulture);
			vulture.x = 800;
			vulture.y = enemyY;
		}
		public function spawnCube(enemyY: Number) {
			cube = new enemyCube(2, 2, slashContainer, ObjectLayer, droneLaserContainer, char);
			ObjectLayer.addChild(cube);
			cube.x = 800;
			cube.y = enemyY;
		}
		public function spawnSlime(enemyY: Number) {
			slime = new enemySlime(3, 4, slashContainer, droneLaserContainer, char, ObjectLayer);
			ObjectLayer.addChild(slime);
			slime.x = 850;
			slime.y = enemyY;
		}
		public function spawnWasp(enemyY: Number, Variance) {
			wasp = new enemyWasp(4, 1, Variance, enemyY, slashContainer, droneLaserContainer, char, ObjectLayer);
			ObjectLayer.addChild(wasp);
			wasp.x = 800;
			wasp.y = enemyY;
		}
		public function spawnCatalyst(enemyY: Number) {
			catalyst = new enemyCatalyst(5, 8, slashContainer, ObjectLayer, droneLaserContainer, char);
			ObjectLayer.addChild(catalyst);
			catalyst.x = 800;
			catalyst.y = enemyY;
			catalyst.scaleX = 1.2;
			catalyst.scaleY = 1.2;
		}		
		public function spawnSpawner(){
			spawner = new evan(this, ObjectLayer);
			ObjectLayer.addChild(spawner);
			spawner.x = 600;
			spawner.y = -100;
			
			time++;
			paused = true;
		}
		public function spawnHazardLaser(Location, Speed, Duration, Direction, Homing){
			hazardLaser = new enemyHazardLaser(Speed, Duration, Direction, Location, Homing, ObjectLayer, char);
			ObjectLayer.addChild(hazardLaser);
		}
		public function spawnHazardBoulder(enemyY, Speed, Scale){
			hazardBoulder = new enemyHazardBoulder(Speed, Scale, slashContainer, droneLaserContainer, char);
			ObjectLayer.addChild(hazardBoulder);
			hazardBoulder.x = 950;
			hazardBoulder.y = enemyY;
		}
		public function spawnVultureBoss() {
			vultureBoss = new bossVulture(this, 50, ObjectLayer, slashContainer, droneLaserContainer, char);
			ObjectLayer.addChild(vultureBoss);
			vultureBoss.x = 900;
			vultureBoss.y = 300;
			
			spawnEnemyHealthBar(50, vultureBoss);
			time++;
			paused = true;
		}
		public function spawnSlimeBoss() {
			slimeBoss = new bossSlime(this, 100, 30, 80, ObjectLayer, slashContainer, droneLaserContainer, char);
			ObjectLayer.addChild(slimeBoss);
			slimeBoss.x = 900;
			slimeBoss.y = 300;
			
			spawnEnemyHealthBar(100, slimeBoss);
			time++;
			paused = true;
		}
		public function spawnHealthBar() {
			HealthBar = new healthBar(maxHealth);
			UILayer.addChild(HealthBar);
			HealthBar.x = 10;
			HealthBar.y = 10;
			HealthBar.scaleX = 0.75;
		}
		public function spawnPassiveBar() {
			PassiveBar = new passiveBar(maxPassive);
			UILayer.addChild(PassiveBar);
			PassiveBar.x = 10;
			PassiveBar.y = 33;
			PassiveBar.scaleX = 0.752;
		}
		public function spawnDriveBar() {
			DriveBar = new driveBar(maxDrive);
			UILayer.addChild(DriveBar);
			DriveBar.x = 8;
			DriveBar.y = 57;
			DriveBar.scaleX = 0.756;
		}
		public function spawnScoreBar() {
			ScoreBar = new scoreBar();
			UILayer.addChild(ScoreBar);
			ScoreBar.x = 585;
			ScoreBar.y = 26;
		}
		public function spawnPauseButton() {
			PauseButton = new buttonPause(UILayer, this, ScoreBar);
			ButtonLayer.addChild(PauseButton);
			PauseButton.x = 750;
			PauseButton.y = 10;
		}
		public function spawnPlayButton(){
			buttonPlay = new buttonMainMenuPlay(ExceptionLayer, this);
			ButtonLayer.addChild(buttonPlay);
			buttonPlay.x = 280;
			buttonPlay.y = 320;
		}
		public function spawnHelpButton(){
			buttonHelp = new buttonMainMenuHelp(ObjectLayer, this);
			ButtonLayer.addChild(buttonHelp);
			buttonHelp.x = 280;
			buttonHelp.y = 420;
		}
		public function spawnCreditsButton(){
			buttonCredits = new buttonMainMenuCredits(this);
			ButtonLayer.addChild(buttonCredits);
			buttonCredits.x = 720;
			buttonCredits.y = 20;
		}
		public function spawnLogo(){
			title = new logo();
			UILayer.addChild(title);
			title.x = (stage.width / 2) - title.width / 2;
			title.y = 70;
		}
		private function createPopup(){
			var pop = new popup(1, this, PauseButton, scoreBar);
			UILayer.addChild(pop);
			pop.x = 120;
			pop.y = 80;
			PauseButton.createdPopup = true;
			
			stopSound();
			songWin = new soundWin();
			transformMain = new SoundTransform(0.3, 0);
			channelMain = songWin.play(0, 0, transformMain);
		}
		public function spawnEnemyHealthBar(enemyMaxHealth, Boss){
			EnemyHealthBar = new enemyHealthBar(enemyMaxHealth, Boss);
			UILayer.addChild(EnemyHealthBar);
			EnemyHealthBar.x = 30;
			EnemyHealthBar.y = 510;
			var lightning = new effectLightning();
			UILayer.addChild(lightning);
			lightning.x = 750;
			lightning.y = 480;
		}
		public function spawnStar(){
			starClip = new star(Math.random()*550, Math.random()*2+1);
			BackgroundLayer.addChild(starClip);
			starClip.x = 800;
		}
		public function spawnEnemy(Enemy, posY, Variance = 0){
			if(Enemy == "vulture"){
				spawnVulture(posY);
			}else if(Enemy == "wasp"){
				spawnWasp(posY, Variance);
			}else if(Enemy == "slime"){
				spawnSlime(posY);
			}else if(Enemy == "cube"){
				spawnCube(posY);
			}else if(Enemy == "catalyst"){
				spawnCatalyst(posY);
			}
		}
		public function spawnBoss(Boss){
			if(Boss == "slime"){
				spawnSlimeBoss();
			}else if(Boss == "vulture"){
				spawnVultureBoss();
			}else if(Boss == "evan"){
				spawnSpawner();
			}
			stopSound();
			playSong(channelMain, songBattle, 0.35);
		}
		public function test() {
			trace("AYYYYYYYYYY");
		}
		public function loadLevel(){
			stopSound();
			playSong(channelMain, songLevel, 0.3);
			//stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
			//stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			//stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			removeAll();
			
			
			loadLevel0();
		}
		private function checkTime(Time, Level){
			if(Level == 0){
				
				
				if(Time == 100){spawnEnemy("vulture", 200);}
				if(Time == 125){spawnEnemy("vulture", 300);}
				if(Time == 150){spawnEnemy("vulture", 400);}
				
				if(Time == 250){spawnEnemy("vulture", 150);}
				if(Time == 275){spawnEnemy("vulture", 250);}
				if(Time == 300){spawnEnemy("vulture", 350);}
				
				if(Time == 400){spawnEnemy("vulture", 200);}
				if(Time == 400){spawnEnemy("vulture", 300);}
				
				if(Time == 520){spawnEnemy("vulture", 350);}
				if(Time == 520){spawnEnemy("vulture", 450);}
				
				if(Time == 600){spawnEnemy("vulture", 200);}
				if(Time == 610){spawnEnemy("vulture", 300);}
				if(Time == 620){spawnEnemy("vulture", 400);}
				
				if(Time == 690){spawnEnemy("vulture", 250);}
				if(Time == 700){spawnEnemy("vulture", 350);}
				if(Time == 710){spawnEnemy("vulture", 450);}
				
				if(Time == 850){spawnEnemy("cube", 300);}
				if(Time == 900){spawnEnemy("cube", 400);}
				
				if(Time == 1000){spawnEnemy("vulture", 150);}
				if(Time == 1010){spawnEnemy("vulture", 250);}
				if(Time == 1020){spawnEnemy("vulture", 350);}
				
				if(Time == 1100){spawnEnemy("vulture", 350);}
				if(Time == 1100){spawnEnemy("vulture", 450);}
				
				if(Time == 1160){spawnEnemy("vulture", 200);}
				if(Time == 1160){spawnEnemy("vulture", 300);}
				
				if(Time == 1230){spawnEnemy("vulture", 225);}
				if(Time == 1240){spawnEnemy("vulture", 275);}
				if(Time == 1250){spawnEnemy("vulture", 325);}
				
				if(Time == 1350){spawnEnemy("cube", 250);}
				if(Time == 1400){spawnEnemy("cube", 350);}
				
				if(Time == 1500){spawnHazardBoulder(150, 2, 1);}
				
				if(Time == 1650){spawnEnemy("vulture", 225);}
				if(Time == 1660){spawnEnemy("vulture", 325);}
				if(Time == 1670){spawnEnemy("vulture", 425);}
				
				if(Time == 1730){spawnEnemy("wasp", 350, 5);}
				if(Time == 1740){spawnEnemy("wasp", 450, 5);}
				
				if(Time == 1890){spawnEnemy("wasp", 225, 6);}
				if(Time == 1900){spawnEnemy("wasp", 325, 6);}
				if(Time == 1910){spawnEnemy("wasp", 425, 6);}
				
				if(Time == 1960){spawnEnemy("wasp", 250, 6);}
				if(Time == 1970){spawnEnemy("wasp", 350, 6);}
				if(Time == 1980){spawnEnemy("wasp", 450, 6);}
				
				if(Time == 2080){spawnEnemy("vulture", 100);}
				if(Time == 2090){spawnEnemy("vulture", 200);}
				if(Time == 2100){spawnEnemy("vulture", 300);}
				if(Time == 2110){spawnEnemy("vulture", 400);}
				if(Time == 2120){spawnEnemy("vulture", 500);}
					
				if(Time == 2220){spawnEnemy("vulture", 75);}
				if(Time == 2230){spawnEnemy("vulture", 175);}
				if(Time == 2240){spawnEnemy("vulture", 275);}
				if(Time == 2250){spawnEnemy("vulture", 375);}
				if(Time == 2260){spawnEnemy("vulture", 475);}
				
				if(Time == 2300){spawnEnemy("cube", 225);}
				if(Time == 2310){spawnEnemy("cube", 325);}
				
				if(Time == 2430){spawnEnemy("vulture", 225);}
				if(Time == 2440){spawnEnemy("vulture", 275);}
				if(Time == 2450){spawnEnemy("vulture", 325);}
				
				if(Time == 2500){spawnEnemy("cube", 275);}
				if(Time == 2520){spawnEnemy("cube", 375);}
				
				if(Time == 2600){spawnHazardBoulder(200, 1.5, 1.5);}
				
				if(Time == 3150){spawnEnemy("vulture", 475);}
				if(Time == 3160){spawnEnemy("vulture", 375);}
				if(Time == 3170){spawnEnemy("vulture", 275);}
				if(Time == 3180){spawnEnemy("vulture", 175);}
				if(Time == 3190){spawnEnemy("vulture", 75);}
				
				if(Time == 3300){spawnEnemy("vulture", 500);}
				if(Time == 3310){spawnEnemy("vulture", 400);}
				if(Time == 3320){spawnEnemy("vulture", 300);}
				if(Time == 3330){spawnEnemy("vulture", 200);}
				if(Time == 3340){spawnEnemy("vulture", 100);}
				
				if(Time == 3500){spawnEnemy("cube", 350);}
				if(Time == 3520){spawnEnemy("cube", 250);}
				
				if(Time == 3600){spawnEnemy("wasp", 150, 5);}
				if(Time == 3610){spawnEnemy("wasp", 225, 5);}
				if(Time == 3620){spawnEnemy("wasp", 300, 5);}
				
				if(Time == 3680){spawnEnemy("wasp", 175, 6);}
				if(Time == 3690){spawnEnemy("wasp", 250, 6);}
				if(Time == 3700){spawnEnemy("wasp", 325, 6);}
				
				if(Time == 3800){spawnEnemy("vulture", 100);}
				if(Time == 3810){spawnEnemy("vulture", 200);}
				if(Time == 3820){spawnEnemy("vulture", 300);}
				if(Time == 3830){spawnEnemy("vulture", 400);}
				if(Time == 3840){spawnEnemy("vulture", 500);}
					
				if(Time == 3880){spawnEnemy("vulture", 75);}
				if(Time == 3890){spawnEnemy("vulture", 175);}
				if(Time == 3900){spawnEnemy("vulture", 275);}
				if(Time == 3910){spawnEnemy("vulture", 375);}
				if(Time == 3920){spawnEnemy("vulture", 475);}
				
				if(Time == 4000){spawnEnemy("cube", 350);}
				if(Time == 4000){spawnEnemy("cube", 250);}
				
				if(Time == 4100){spawnEnemy("cube", 450);}
				if(Time == 4150){spawnEnemy("cube", 150);}
				
				if(Time == 4300){spawnHazardBoulder(150, 2.5, 0.75);}
				if(Time == 4410){spawnHazardBoulder(400, 2.5, 0.75);}
				if(Time == 4600){spawnEnemy("vulture", 200);}
				if(Time == 4520){spawnHazardBoulder(150, 2.5, 0.75);}
				
				if(Time == 4800){spawnEnemy("vulture", 225);}
				if(Time == 4810){spawnEnemy("vulture", 325);}
				if(Time == 4820){spawnEnemy("vulture", 425);}
				
				if(Time == 4880){spawnEnemy("vulture", 275);}
				if(Time == 4890){spawnEnemy("vulture", 375);}
				if(Time == 4900){spawnEnemy("vulture", 475);}
				
				if(Time == 4960){spawnEnemy("wasp", 125, 5);}
				if(Time == 4970){spawnEnemy("wasp", 225, 5);}
				if(Time == 4980){spawnEnemy("wasp", 325, 5);}
				
				if(Time == 5040){spawnEnemy("wasp", 175, 4);}
				if(Time == 5050){spawnEnemy("wasp", 250, 4);}
				if(Time == 5060){spawnEnemy("wasp", 325, 4);}
				
				if(Time == 5150){spawnEnemy("vulture", 475);}
				if(Time == 5160){spawnEnemy("vulture", 375);}
				if(Time == 5170){spawnEnemy("vulture", 275);}
				if(Time == 5180){spawnEnemy("vulture", 175);}
				if(Time == 5190){spawnEnemy("vulture", 75);}
				
				if(Time == 5250){spawnEnemy("vulture", 500);}
				if(Time == 5260){spawnEnemy("vulture", 400);}
				if(Time == 5270){spawnEnemy("vulture", 300);}
				if(Time == 5280){spawnEnemy("vulture", 200);}
				if(Time == 5290){spawnEnemy("vulture", 100);}
				
				if(Time == 5350){spawnEnemy("cube", 350);}
				
				if(Time == 5450){spawnEnemy("vulture", 100);}
				if(Time == 5460){spawnEnemy("vulture", 200);}
				if(Time == 5470){spawnEnemy("vulture", 300);}
				if(Time == 5480){spawnEnemy("vulture", 400);}
				if(Time == 5490){spawnEnemy("vulture", 500);}
				
				if(Time == 5550){spawnEnemy("cube", 250);}
				
				if(Time == 5620){spawnEnemy("vulture", 75);}
				if(Time == 5630){spawnEnemy("vulture", 175);}
				if(Time == 5640){spawnEnemy("vulture", 275);}
				if(Time == 5650){spawnEnemy("vulture", 375);}
				if(Time == 5660){spawnEnemy("vulture", 475);}
			
				if(Time == 5900){spawnHazardBoulder(100, 3, 0.75);}
				if(Time == 5900){spawnHazardBoulder(450, 3, 0.75);}
				if(Time == 6020){spawnEnemy("vulture", 235);}
				if(Time == 6000){spawnHazardBoulder(250, 3, 0.75);}
				
				if(Time == 6100){spawnHazardBoulder(100, 3, 0.75);}
				if(Time == 6100){spawnHazardBoulder(450, 3, 0.75);}
				
				if(Time == 6200){spawnHazardBoulder(250, 3, 0.75);}
				
				if(Time == 6300){spawnHazardBoulder(100, 3, 0.75);}
				if(Time == 6300){spawnHazardBoulder(450, 3, 0.75);}
				if(Time == 6420){spawnEnemy("vulture", 235);}
				if(Time == 6400){spawnHazardBoulder(250, 3, 0.75);}
				
				if(Time == 6500){spawnHazardBoulder(100, 3, 0.75);}
				if(Time == 6500){spawnHazardBoulder(450, 3, 0.75);}
				
				if(Time == 6600){spawnHazardBoulder(250, 3, 0.75);}
				
				if(Time == 6800){spawnHazardBoulder(100, 3, 0.75);}
				if(Time == 6800){spawnHazardBoulder(275, 3, 0.75);}
				
				if(Time == 6920){spawnHazardBoulder(450, 3, 0.75);}
				if(Time == 6920){spawnHazardBoulder(275, 3, 0.75);}
				
				if(Time == 7100){spawnEnemy("vulture", 225);}
				if(Time == 7110){spawnEnemy("vulture", 325);}
				if(Time == 7110){spawnEnemy("vulture", 425);}
				
				if(Time == 7240){spawnEnemy("vulture", 275);}
				if(Time == 7260){spawnEnemy("vulture", 475);}
				
				if(Time == 7350){spawnEnemy("vulture", 325);}
				
				if(Time == 7500){spawnEnemy("cube", 375);}
				if(Time == 7550){spawnEnemy("cube", 225);}
				
				if(Time == 7800){spawnBoss("vulture");}
				
				if(Time == 8000){spawnEnemy("wasp", 125, 6);}
				if(Time == 8000){spawnEnemy("wasp", 200, 6);}
				if(Time == 8000){spawnEnemy("wasp", 275, 6);}
				
				if(Time == 8100){spawnEnemy("wasp", 175, 6);}
				if(Time == 8105){spawnEnemy("wasp", 250, 6);}
				if(Time == 8110){spawnEnemy("wasp", 325, 6);}
				
				if(Time == 8180){spawnEnemy("wasp", 100, 5);}
				if(Time == 8190){spawnEnemy("wasp", 175, 5);}
				if(Time == 8200){spawnEnemy("wasp", 250, 5);}
				if(Time == 8210){spawnEnemy("wasp", 325, 5);}
				if(Time == 8220){spawnEnemy("wasp", 400, 5);}
				
				if(Time == 8260){spawnEnemy("wasp", 75, 5);}
				if(Time == 8270){spawnEnemy("wasp", 150, 5);}
				if(Time == 8280){spawnEnemy("wasp", 225, 5);}
				if(Time == 8290){spawnEnemy("wasp", 300, 5);}
				if(Time == 8300){spawnEnemy("wasp", 375, 5);}
				
				if(Time == 8340){spawnEnemy("wasp", 100, 6);}
				if(Time == 8350){spawnEnemy("wasp", 175, 6);}
				if(Time == 8360){spawnEnemy("wasp", 250, 6);}
				if(Time == 8370){spawnEnemy("wasp", 325, 6);}
				if(Time == 8380){spawnEnemy("wasp", 400, 6);}
				
				if(Time == 8420){spawnEnemy("wasp", 75, 6);}
				if(Time == 8430){spawnEnemy("wasp", 150, 6);}
				if(Time == 8440){spawnEnemy("wasp", 225, 6);}
				if(Time == 8450){spawnEnemy("wasp", 300, 6);}
				if(Time == 8460){spawnEnemy("wasp", 375, 6);}
				
				if(Time == 8550){spawnEnemy("cube", 425);}
				if(Time == 8570){spawnEnemy("cube", 250);}
				
				if(Time == 8800){spawnEnemy("wasp", 100, 6);}
				if(Time == 8810){spawnEnemy("wasp", 175, 6);}
				if(Time == 8820){spawnEnemy("wasp", 250, 6);}
				if(Time == 8830){spawnEnemy("wasp", 325, 6);}
				if(Time == 8840){spawnEnemy("wasp", 400, 6);}
				
				if(Time == 8880){spawnEnemy("wasp", 75, 6);}
				if(Time == 8890){spawnEnemy("wasp", 150, 6);}
				if(Time == 8900){spawnEnemy("wasp", 225, 6);}
				if(Time == 8910){spawnEnemy("wasp", 300, 6);}
				if(Time == 8920){spawnEnemy("wasp", 375, 6);}
				
				if(Time == 8960){spawnEnemy("wasp", 100, 6);}
				if(Time == 8970){spawnEnemy("wasp", 175, 6);}
				if(Time == 8980){spawnEnemy("wasp", 250, 6);}
				if(Time == 8990){spawnEnemy("wasp", 325, 6);}
				if(Time == 9000){spawnEnemy("wasp", 400, 6);}
				
				if(Time == 9040){spawnEnemy("wasp", 75, 6);}
				if(Time == 9050){spawnEnemy("wasp", 150, 6);}
				if(Time == 9060){spawnEnemy("wasp", 225, 6);}
				if(Time == 9070){spawnEnemy("wasp", 300, 6);}
				if(Time == 9080){spawnEnemy("wasp", 375, 6);}
				
				if(Time == 9180){spawnEnemy("cube", 400);}
				if(Time == 9190){spawnEnemy("cube", 275);}
				
				if(Time == 9340){spawnEnemy("wasp", 300, 6);}
				if(Time == 9400){spawnHazardBoulder(150, 2.5, 0.75);}
				if(Time == 9520){spawnEnemy("wasp", 250, 6);}
				if(Time == 9540){spawnEnemy("wasp", 200, 6);}
				if(Time == 9510){spawnHazardBoulder(400, 2.5, 0.75);}
				if(Time == 9630){spawnEnemy("wasp", 200, 6);}
				if(Time == 9650){spawnEnemy("wasp", 300, 6);}
				if(Time == 9620){spawnHazardBoulder(150, 2.5, 0.75);}
				
				if(Time == 9900){spawnEnemy("wasp", 100, 6);}
				if(Time == 9910){spawnEnemy("wasp", 175, 6);}
				if(Time == 9920){spawnEnemy("wasp", 250, 6);}
				if(Time == 9930){spawnEnemy("wasp", 325, 6);}
				if(Time == 9940){spawnEnemy("wasp", 400, 6);}
				
				if(Time == 9970){spawnEnemy("wasp", 75, 6);}
				if(Time == 9980){spawnEnemy("wasp", 150, 6);}
				if(Time == 9990){spawnEnemy("wasp", 225, 6);}
				if(Time == 10000){spawnEnemy("wasp", 300, 6);}
				if(Time == 10010){spawnEnemy("wasp", 375, 6);}
				
				if(Time == 10040){spawnEnemy("wasp", 100, 6);}
				if(Time == 10050){spawnEnemy("wasp", 175, 6);}
				if(Time == 10060){spawnEnemy("wasp", 250, 6);}
				if(Time == 10070){spawnEnemy("wasp", 325, 6);}
				if(Time == 10080){spawnEnemy("wasp", 400, 6);}
				
				if(Time == 10110){spawnEnemy("wasp", 75, 6);}
				if(Time == 10120){spawnEnemy("wasp", 150, 6);}
				if(Time == 10130){spawnEnemy("wasp", 225, 6);}
				if(Time == 10140){spawnEnemy("wasp", 300, 6);}
				if(Time == 10150){spawnEnemy("wasp", 375, 6);}
				
				if(Time == 10250){spawnEnemy("cube", 425);}
				if(Time == 10270){spawnEnemy("cube", 250);}
				
				if(Time == 10400){spawnEnemy("slime", 225);}
				if(Time == 10440){spawnEnemy("slime", 325);}
				if(Time == 10480){spawnEnemy("slime", 425);}
				
				if(Time == 10550){spawnEnemy("slime", 175);}
				if(Time == 10580){spawnEnemy("slime", 275);}
				if(Time == 10610){spawnEnemy("slime", 375);}
				
				if(Time == 10700){spawnEnemy("wasp", 75, 6);}
				if(Time == 10710){spawnEnemy("wasp", 150, 6);}
				if(Time == 10720){spawnEnemy("wasp", 225, 6);}
				if(Time == 10730){spawnEnemy("wasp", 300, 6);}
				if(Time == 10740){spawnEnemy("wasp", 375, 6);}
				
				if(Time == 10860){spawnEnemy("slime", 150);}
				if(Time == 10870){spawnEnemy("slime", 250);}
				if(Time == 10880){spawnEnemy("slime", 350);}
				if(Time == 10890){spawnEnemy("slime", 450);}
				
				if(Time == 10960){spawnEnemy("cube", 375);}
				if(Time == 11000){spawnEnemy("cube", 225);}
				
				if(Time == 11200){spawnHazardLaser(300, 5, 120, 2, false);}
				
				if(Time == 11400){spawnHazardLaser(175, 5, 120, 2, false);}
				if(Time == 11400){spawnHazardLaser(425, 5, 120, 2, false);}
				
				if(Time == 11700){spawnEnemy("slime", 225);}
				if(Time == 11710){spawnEnemy("slime", 325);}
				if(Time == 11720){spawnEnemy("slime", 425);}
				
				if(Time == 11800){spawnEnemy("slime", 175);}
				if(Time == 11810){spawnEnemy("slime", 275);}
				if(Time == 11820){spawnEnemy("slime", 375);}
				
				if(Time == 11920){spawnEnemy("slime", 150);}
				if(Time == 11930){spawnEnemy("slime", 250);}
				if(Time == 11940){spawnEnemy("slime", 350);}
				if(Time == 11950){spawnEnemy("slime", 450);}
				
				if(Time == 12030){spawnEnemy("wasp", 100, 6);}
				if(Time == 12040){spawnEnemy("wasp", 175, 6);}
				if(Time == 12050){spawnEnemy("wasp", 250, 6);}
				if(Time == 12060){spawnEnemy("wasp", 325, 6);}
				if(Time == 12070){spawnEnemy("wasp", 400, 6);}
				
				if(Time == 12120){spawnEnemy("cube", 225);}
				if(Time == 12140){spawnEnemy("cube", 375);}
				
				if(Time == 12300){spawnEnemy("wasp", 400, 6);}
				if(Time == 12310){spawnEnemy("wasp", 325, 6);}
				if(Time == 12320){spawnEnemy("wasp", 250, 6);}
				if(Time == 12330){spawnEnemy("wasp", 175, 6);}
				if(Time == 12340){spawnEnemy("wasp", 100, 6);}
				
				if(Time == 12380){spawnEnemy("wasp", 375, 6);}
				if(Time == 12390){spawnEnemy("wasp", 300, 6);}
				if(Time == 12300){spawnEnemy("wasp", 225, 6);}
				if(Time == 12310){spawnEnemy("wasp", 150, 6);}
				if(Time == 12320){spawnEnemy("wasp", 75, 6);}
				
				if(Time == 12500){spawnEnemy("slime", 425);}
				if(Time == 12510){spawnEnemy("slime", 325);}
				if(Time == 12520){spawnEnemy("slime", 225);}
				if(Time == 12530){spawnEnemy("slime", 125);}
				
				if(Time == 12630){spawnEnemy("slime", 450);}
				if(Time == 12640){spawnEnemy("slime", 350);}
				if(Time == 12650){spawnEnemy("slime", 250);}
				if(Time == 12660){spawnEnemy("slime", 150);}
				
				if(Time == 12750){spawnEnemy("cube", 350);}
				if(Time == 12750){spawnEnemy("cube", 225);}
				
				if(Time == 12870){spawnEnemy("slime", 425);}
				if(Time == 12880){spawnEnemy("slime", 300);}
			
				if(Time == 12920){spawnEnemy("slime", 375);}
				if(Time == 12930){spawnEnemy("slime", 250);}
				
				if(Time == 13000){spawnEnemy("cube", 250);}
				if(Time == 13000){spawnEnemy("cube", 375);}
				
				if(Time == 13100){spawnEnemy("wasp", 100, 6);}
				if(Time == 13110){spawnEnemy("wasp", 175, 6);}
				if(Time == 13120){spawnEnemy("wasp", 250, 6);}
				if(Time == 13130){spawnEnemy("wasp", 325, 6);}
				if(Time == 13140){spawnEnemy("wasp", 400, 6);}
				
				if(Time == 13180){spawnEnemy("wasp", 75, 6);}
				if(Time == 13190){spawnEnemy("wasp", 150, 6);}
				if(Time == 13200){spawnEnemy("wasp", 225, 6);}
				if(Time == 13210){spawnEnemy("wasp", 300, 6);}
				if(Time == 13220){spawnEnemy("wasp", 375, 6);}
				
				if(Time == 13400){SoundMixer.soundTransform = new SoundTransform(0.3);}
				if(Time == 13400){spawnHazardLaser(25, 8, 90, 3, false);}
				if(Time == 13410){spawnHazardLaser(75, 8, 90, 3, false);}
				if(Time == 13420){spawnHazardLaser(125, 8, 90, 3, false);}
				if(Time == 13430){spawnHazardLaser(175, 8, 90, 3, false);}
				if(Time == 13440){spawnHazardLaser(225, 8, 90, 3, false);}
				if(Time == 13450){spawnHazardLaser(275, 8, 90, 3, false);}
				if(Time == 13460){spawnHazardLaser(325, 8, 90, 3, false);}
				if(Time == 13470){spawnHazardLaser(375, 8, 90, 3, false);}
				if(Time == 13480){spawnHazardLaser(425, 8, 90, 3, false);}
				if(Time == 13490){spawnHazardLaser(475, 8, 90, 3, false);}
				if(Time == 13500){spawnHazardLaser(525, 8, 90, 3, false);}
				if(Time == 13510){spawnHazardLaser(575, 8, 90, 3, false);}
				if(Time == 13520){spawnHazardLaser(625, 8, 90, 3, false);}
				if(Time == 13530){spawnHazardLaser(675, 8, 90, 3, false);}
				if(Time == 13540){spawnHazardLaser(725, 8, 90, 3, false);}
				
				if(Time == 13740){spawnHazardLaser(775, 8, 90, 4, false);}
				if(Time == 13750){spawnHazardLaser(725, 8, 90, 4, false);}
				if(Time == 13760){spawnHazardLaser(675, 8, 90, 4, false);}
				if(Time == 13770){spawnHazardLaser(625, 8, 90, 4, false);}
				if(Time == 13780){spawnHazardLaser(575, 8, 90, 4, false);}
				if(Time == 13790){spawnHazardLaser(525, 8, 90, 4, false);}
				if(Time == 13800){spawnHazardLaser(475, 8, 90, 4, false);}
				if(Time == 13810){spawnHazardLaser(425, 8, 90, 4, false);}
				if(Time == 13820){spawnHazardLaser(375, 8, 90, 4, false);}
				if(Time == 13830){spawnHazardLaser(325, 8, 90, 4, false);}
				if(Time == 13840){spawnHazardLaser(275, 8, 90, 4, false);}
				if(Time == 13850){spawnHazardLaser(225, 8, 90, 4, false);}
				if(Time == 13860){spawnHazardLaser(175, 8, 90, 4, false);}
				if(Time == 13870){spawnHazardLaser(125, 8, 90, 4, false);}
				if(Time == 13880){spawnHazardLaser(75, 8, 90, 4, false);}
				
				if(Time == 14200){SoundMixer.soundTransform = new SoundTransform(0.85);}
				if(Time == 14200){spawnHazardLaser(725, 5, 280, 4, true);}
				if(Time == 14200){spawnHazardLaser(75, 5, 280, 3, true);}
				
				if(Time == 14630){spawnEnemy("slime", 450);}
				if(Time == 14640){spawnEnemy("slime", 350);}
				if(Time == 14650){spawnEnemy("slime", 250);}
				if(Time == 14660){spawnEnemy("slime", 150);}
				
				if(Time == 14760){spawnEnemy("slime", 425);}
				if(Time == 14770){spawnEnemy("slime", 325);}
				if(Time == 14780){spawnEnemy("slime", 225);}
				if(Time == 14790){spawnEnemy("slime", 125);}
				
				if(Time == 14900){spawnEnemy("slime", 400);}
				if(Time == 14910){spawnEnemy("slime", 300);}
				if(Time == 14920){spawnEnemy("slime", 200);}
				if(Time == 14930){spawnEnemy("slime", 100);}
				
				if(Time == 15030){spawnEnemy("slime", 450);}
				if(Time == 15040){spawnEnemy("slime", 350);}
				if(Time == 15050){spawnEnemy("slime", 250);}
				if(Time == 15060){spawnEnemy("slime", 150);}
				
				if(Time == 15200){spawnEnemy("wasp", 400, 6);}
				if(Time == 15210){spawnEnemy("wasp", 325, 6);}
				if(Time == 15220){spawnEnemy("wasp", 250, 6);}
				if(Time == 15230){spawnEnemy("wasp", 175, 6);}
				if(Time == 15240){spawnEnemy("wasp", 100, 6);}
				
				if(Time == 15300){spawnEnemy("wasp", 375, 6);}
				if(Time == 15310){spawnEnemy("wasp", 300, 6);}
				if(Time == 15320){spawnEnemy("wasp", 225, 6);}
				if(Time == 15330){spawnEnemy("wasp", 150, 6);}
				if(Time == 15340){spawnEnemy("wasp", 75, 6);}
				
				if(Time == 15440){spawnEnemy("wasp", 225, 7);}
				if(Time == 15440){spawnEnemy("wasp", 375, 7);}
				
				if(Time == 15470){spawnEnemy("cube", 250);}
				
				if(Time == 15500){spawnEnemy("wasp", 300, 7);}
				if(Time == 15500){spawnEnemy("wasp", 150, 7);}
				
				if(Time == 15660){spawnEnemy("wasp", 400, 7);}
				if(Time == 15660){spawnEnemy("wasp", 250, 7);}
				
				if(Time == 15690){spawnEnemy("cube", 300);}
				
				if(Time == 15720){spawnEnemy("wasp", 325, 7);}
				if(Time == 15720){spawnEnemy("wasp", 175, 7);}
				
				if(Time == 15780){spawnEnemy("wasp", 225, 7);}
				if(Time == 15780){spawnEnemy("wasp", 375, 7);}
				
				if(Time == 15810){spawnEnemy("cube", 350);}
				
				if(Time == 15840){spawnEnemy("wasp", 300, 7);}
				if(Time == 15840){spawnEnemy("wasp", 150, 7);}
				
				if(Time == 15900){spawnEnemy("wasp", 400, 7);}
				if(Time == 15900){spawnEnemy("wasp", 250, 7);}
				
				if(Time == 15930){spawnEnemy("cube", 400);}
				
				if(Time == 15960){spawnEnemy("wasp", 325, 7);}
				if(Time == 15960){spawnEnemy("wasp", 175, 7);}
				
				if(Time == 16020){spawnEnemy("wasp", 225, 7);}
				if(Time == 16020){spawnEnemy("wasp", 375, 7);}
				
				if(Time == 16160){spawnEnemy("slime", 300);}
				if(Time == 16160){spawnEnemy("slime", 425);}
			
				if(Time == 16260){spawnEnemy("slime", 250);}
				if(Time == 16260){spawnEnemy("slime", 375);}
				
				if(Time == 16400){spawnHazardLaser(0, 5, 180, 4, true);}
				if(Time == 16400){spawnHazardLaser(550, 5, 180, 1, true);}
				
				if(Time == 16500){spawnHazardLaser(800, 5, 180, 3, true);}
				if(Time == 16500){spawnHazardLaser(0, 5, 180, 2, true);}
				
				if(Time == 16600){spawnHazardLaser(800, 5, 180, 4, true);}
				if(Time == 16600){spawnHazardLaser(550, 5, 180, 1, true);}
				
				if(Time == 16700){spawnHazardLaser(0, 5, 180, 3, true);}
				if(Time == 16700){spawnHazardLaser(0, 5, 180, 2, true);}
				
				if(Time == 17000){SoundMixer.soundTransform = new SoundTransform(0.3);}
				if(Time == 17000){spawnHazardLaser(25, 8, 90, 2, false);}
				if(Time == 17010){spawnHazardLaser(75, 8, 90, 2, false);}
				if(Time == 17020){spawnHazardLaser(125, 8, 90, 2, false);}
				if(Time == 17030){spawnHazardLaser(175, 8, 90, 2, false);}
				if(Time == 17040){spawnHazardLaser(225, 8, 90, 2, false);}
				if(Time == 17050){spawnHazardLaser(275, 8, 90, 2, false);}
				if(Time == 17060){spawnHazardLaser(325, 8, 90, 2, false);}
				if(Time == 17070){spawnHazardLaser(375, 8, 90, 2, false);}
				if(Time == 17080){spawnHazardLaser(425, 8, 90, 2, false);}
				
				if(Time == 17180){spawnHazardLaser(25, 8, 90, 3, false);}
				if(Time == 17190){spawnHazardLaser(75, 8, 90, 3, false);}
				if(Time == 17200){spawnHazardLaser(125, 8, 90, 3, false);}
				if(Time == 17210){spawnHazardLaser(175, 8, 90, 3, false);}
				if(Time == 17220){spawnHazardLaser(225, 8, 90, 3, false);}
				if(Time == 17230){spawnHazardLaser(275, 8, 90, 3, false);}
				if(Time == 17240){spawnHazardLaser(325, 8, 90, 3, false);}
				if(Time == 17250){spawnHazardLaser(375, 8, 90, 3, false);}
				if(Time == 17260){spawnHazardLaser(425, 8, 90, 3, false);}
				if(Time == 17270){spawnHazardLaser(475, 8, 90, 3, false);}
				if(Time == 17280){spawnHazardLaser(525, 8, 90, 3, false);}
				if(Time == 17290){spawnHazardLaser(575, 8, 90, 3, false);}
				if(Time == 17300){spawnHazardLaser(625, 8, 90, 3, false);}
				if(Time == 17310){spawnHazardLaser(675, 8, 90, 3, false);}
				if(Time == 17320){spawnHazardLaser(725, 8, 90, 3, false);}
				
				if(Time == 17420){spawnHazardLaser(525, 8, 90, 1, false);}
				if(Time == 17430){spawnHazardLaser(475, 8, 90, 1, false);}
				if(Time == 17440){spawnHazardLaser(425, 8, 90, 1, false);}
				if(Time == 17450){spawnHazardLaser(375, 8, 90, 1, false);}
				if(Time == 17460){spawnHazardLaser(325, 8, 90, 1, false);}
				if(Time == 17470){spawnHazardLaser(275, 8, 90, 1, false);}
				if(Time == 17480){spawnHazardLaser(225, 8, 90, 1, false);}
				if(Time == 17490){spawnHazardLaser(175, 8, 90, 1, false);}
				if(Time == 17500){spawnHazardLaser(125, 8, 90, 1, false);}
				
				
			
				if(Time == 17650){spawnHazardLaser(25, 12, 40, 3, false);}
				if(Time == 17650){spawnHazardLaser(775, 12, 40, 3, false);}
				
				if(Time == 17700){spawnHazardLaser(75, 12, 40, 3, false);}
				if(Time == 17700){spawnHazardLaser(725, 12, 40, 3, false);}
				
				if(Time == 17750){spawnHazardLaser(125, 12, 40, 3, false);}
				if(Time == 17750){spawnHazardLaser(675, 12, 40, 3, false);}
				
				if(Time == 17800){spawnHazardLaser(175, 12, 40, 3, false);}
				if(Time == 17800){spawnHazardLaser(625, 12, 40, 3, false);}
				
				if(Time == 17850){spawnHazardLaser(225, 12, 40, 3, false);}
				if(Time == 17850){spawnHazardLaser(575, 12, 40, 3, false);}
				
				if(Time == 17900){spawnHazardLaser(275, 12, 40, 3, false);}
				if(Time == 17900){spawnHazardLaser(525, 12, 40, 3, false);}
				
				if(Time == 17950){spawnHazardLaser(325, 12, 600, 3, false);}
				if(Time == 17950){spawnHazardLaser(475, 12, 600, 3, false);}
				
				
				if(Time == 18050){spawnHazardLaser(0, 4, 180, 1, true);}
				if(Time == 18050){spawnHazardLaser(550, 4, 180, 2, true);}
				
		
				
				if(Time == 18320){spawnHazardLaser(25, 8, 90, 2, false);}
				if(Time == 18330){spawnHazardLaser(75, 8, 90, 2, false);}
				if(Time == 18340){spawnHazardLaser(125, 8, 90, 2, false);}
				if(Time == 18350){spawnHazardLaser(175, 8, 90, 2, false);}
				if(Time == 18360){spawnHazardLaser(225, 8, 90, 2, false);}
				if(Time == 18370){spawnHazardLaser(275, 8, 90, 2, false);}
				if(Time == 18380){spawnHazardLaser(325, 8, 90, 2, false);}
				if(Time == 18390){spawnHazardLaser(375, 8, 90, 2, false);}
				if(Time == 18400){spawnHazardLaser(425, 8, 90, 2, false);}
				
				if(Time == 18600){spawnHazardLaser(775, 8, 90, 4, false);}
				if(Time == 18610){spawnHazardLaser(725, 8, 90, 4, false);}
				if(Time == 18620){spawnHazardLaser(675, 8, 90, 4, false);}
				if(Time == 18630){spawnHazardLaser(625, 8, 90, 4, false);}
				if(Time == 18640){spawnHazardLaser(575, 8, 90, 4, false);}
				if(Time == 18650){spawnHazardLaser(525, 8, 90, 4, false);}
				if(Time == 18660){spawnHazardLaser(475, 8, 90, 4, false);}
				if(Time == 18670){spawnHazardLaser(425, 8, 90, 4, false);}
				if(Time == 18680){spawnHazardLaser(375, 8, 90, 4, false);}
				if(Time == 18690){spawnHazardLaser(325, 8, 90, 4, false);}
				if(Time == 18700){spawnHazardLaser(275, 8, 90, 4, false);}
				if(Time == 18710){spawnHazardLaser(225, 8, 90, 4, false);}
				if(Time == 18720){spawnHazardLaser(175, 8, 90, 4, false);}
				if(Time == 18730){spawnHazardLaser(125, 8, 90, 4, false);}
				if(Time == 18740){spawnHazardLaser(75, 8, 90, 4, false);}
				
				if(Time == 18920){spawnHazardLaser(25, 8, 90, 3, false);}
				if(Time == 18930){spawnHazardLaser(75, 8, 90, 3, false);}
				if(Time == 18940){spawnHazardLaser(125, 8, 90, 3, false);}
				if(Time == 18950){spawnHazardLaser(175, 8, 90, 3, false);}
				if(Time == 18960){spawnHazardLaser(225, 8, 90, 3, false);}
				if(Time == 18970){spawnHazardLaser(275, 8, 90, 3, false);}
				if(Time == 18980){spawnHazardLaser(325, 8, 90, 3, false);}
				if(Time == 18990){spawnHazardLaser(375, 8, 90, 3, false);}
				if(Time == 19000){spawnHazardLaser(425, 8, 90, 3, false);}
				if(Time == 19010){spawnHazardLaser(475, 8, 90, 3, false);}
				if(Time == 19020){spawnHazardLaser(525, 8, 90, 3, false);}
				if(Time == 19030){spawnHazardLaser(575, 8, 90, 3, false);}
				if(Time == 19040){spawnHazardLaser(625, 8, 90, 3, false);}
				if(Time == 19050){spawnHazardLaser(675, 8, 90, 3, false);}
				if(Time == 19060){spawnHazardLaser(725, 8, 90, 3, false);}
				
				if(Time == 19240){spawnHazardLaser(775, 8, 90, 4, false);}
				if(Time == 19250){spawnHazardLaser(725, 8, 90, 4, false);}
				if(Time == 19260){spawnHazardLaser(675, 8, 90, 4, false);}
				if(Time == 19270){spawnHazardLaser(625, 8, 90, 4, false);}
				if(Time == 19280){spawnHazardLaser(575, 8, 90, 4, false);}
				if(Time == 19290){spawnHazardLaser(525, 8, 90, 4, false);}
				if(Time == 19300){spawnHazardLaser(475, 8, 90, 4, false);}
				if(Time == 19310){spawnHazardLaser(425, 8, 90, 4, false);}
				if(Time == 19320){spawnHazardLaser(375, 8, 90, 4, false);}
				if(Time == 19330){spawnHazardLaser(325, 8, 90, 4, false);}
				if(Time == 19340){spawnHazardLaser(275, 8, 90, 4, false);}
				if(Time == 19350){spawnHazardLaser(225, 8, 90, 4, false);}
				if(Time == 19360){spawnHazardLaser(175, 8, 90, 4, false);}
				if(Time == 19370){spawnHazardLaser(125, 8, 90, 4, false);}
				if(Time == 19380){spawnHazardLaser(75, 8, 90, 4, false);}
				
				if(Time == 19560){spawnHazardLaser(25, 8, 90, 3, false);}
				if(Time == 19570){spawnHazardLaser(75, 8, 90, 3, false);}
				if(Time == 19580){spawnHazardLaser(125, 8, 90, 3, false);}
				if(Time == 19590){spawnHazardLaser(175, 8, 90, 3, false);}
				if(Time == 19600){spawnHazardLaser(225, 8, 90, 3, false);}
				if(Time == 19610){spawnHazardLaser(275, 8, 90, 3, false);}
				if(Time == 19620){spawnHazardLaser(325, 8, 90, 3, false);}
				if(Time == 19630){spawnHazardLaser(375, 8, 90, 3, false);}
				if(Time == 19640){spawnHazardLaser(425, 8, 90, 3, false);}
				if(Time == 19650){spawnHazardLaser(475, 8, 90, 3, false);}
				if(Time == 19660){spawnHazardLaser(525, 8, 90, 3, false);}
				if(Time == 19670){spawnHazardLaser(575, 8, 90, 3, false);}
				if(Time == 19680){spawnHazardLaser(625, 8, 90, 3, false);}
				if(Time == 19690){spawnHazardLaser(675, 8, 90, 3, false);}
				if(Time == 19700){spawnHazardLaser(725, 8, 90, 3, false);}
				
				if(Time == 19620){spawnHazardLaser(525, 8, 90, 1, false);}
				if(Time == 19630){spawnHazardLaser(475, 8, 90, 1, false);}
				if(Time == 19640){spawnHazardLaser(425, 8, 90, 1, false);}
				if(Time == 19650){spawnHazardLaser(375, 8, 90, 1, false);}
				if(Time == 19660){spawnHazardLaser(325, 8, 90, 1, false);}
				if(Time == 19670){spawnHazardLaser(275, 8, 90, 1, false);}
				if(Time == 19680){spawnHazardLaser(225, 8, 90, 1, false);}
				if(Time == 19690){spawnHazardLaser(175, 8, 90, 1, false);}
				if(Time == 19700){spawnHazardLaser(125, 8, 90, 1, false);}
				
				if(Time == 20050){SoundMixer.soundTransform = new SoundTransform(0.85);}
				
				if(Time == 20100){spawnEnemy("cube", 425);}
				if(Time == 20110){spawnEnemy("cube", 325);}
				if(Time == 20120){spawnEnemy("cube", 225);}
				if(Time == 20130){spawnEnemy("cube", 125);}
				
				if(Time == 20430){spawnEnemy("slime", 425);}
				if(Time == 20440){spawnEnemy("slime", 325);}
				if(Time == 20450){spawnEnemy("slime", 225);}
				if(Time == 20460){spawnEnemy("slime", 125);}
				
				if(Time == 20560){spawnEnemy("slime", 400);}
				if(Time == 20570){spawnEnemy("slime", 300);}
				if(Time == 20580){spawnEnemy("slime", 200);}
				if(Time == 20590){spawnEnemy("slime", 100);}
				
				if(Time == 20690){spawnEnemy("slime", 450);}
				if(Time == 20700){spawnEnemy("slime", 350);}
				if(Time == 20710){spawnEnemy("slime", 250);}
				if(Time == 20720){spawnEnemy("slime", 150);}
				
				if(Time == 20900){spawnEnemy("catalyst", 300);}
				if(Time == 20940){spawnEnemy("catalyst", 150);}
				
				if(Time == 21100){spawnEnemy("slime", 225);}
				if(Time == 21110){spawnEnemy("slime", 325);}
				if(Time == 21120){spawnEnemy("slime", 425);}
				
				if(Time == 21200){spawnEnemy("slime", 175);}
				if(Time == 21210){spawnEnemy("slime", 275);}
				if(Time == 21220){spawnEnemy("slime", 375);}
				
				if(Time == 21300){spawnEnemy("catalyst", 350);}
				if(Time == 21310){spawnEnemy("catalyst", 200);}
				
				if(Time == 21400){spawnEnemy("slime", 150);}
				if(Time == 21410){spawnEnemy("slime", 250);}
				if(Time == 21420){spawnEnemy("slime", 350);}
				if(Time == 21430){spawnEnemy("slime", 450);}
				
				if(Time == 21530){spawnEnemy("slime", 125);}
				if(Time == 21540){spawnEnemy("slime", 225);}
				if(Time == 21550){spawnEnemy("slime", 325);}
				if(Time == 21560){spawnEnemy("slime", 425);}
				
				if(Time == 21700){spawnEnemy("cube", 125);}
				if(Time == 21710){spawnEnemy("cube", 225);}
				if(Time == 21720){spawnEnemy("cube", 325);}
				if(Time == 21730){spawnEnemy("cube", 425);}
				
				if(Time == 22000){spawnEnemy("catalyst", 175);}
				if(Time == 22010){spawnEnemy("catalyst", 275);}
				if(Time == 22020){spawnEnemy("catalyst", 375);}
				
				if(Time == 22120){spawnEnemy("slime", 150);}
				if(Time == 22130){spawnEnemy("slime", 250);}
				if(Time == 22140){spawnEnemy("slime", 350);}
				if(Time == 22150){spawnEnemy("slime", 450);}
				
				if(Time == 22250){spawnEnemy("slime", 125);}
				if(Time == 22260){spawnEnemy("slime", 225);}
				if(Time == 22270){spawnEnemy("slime", 325);}
				if(Time == 22280){spawnEnemy("slime", 425);}
				
				if(Time == 22380){spawnEnemy("catalyst", 175);}
				if(Time == 22390){spawnEnemy("catalyst", 275);}
				if(Time == 22400){spawnEnemy("catalyst", 375);}
				
				if(Time == 22500){spawnEnemy("slime", 400);}
				if(Time == 22510){spawnEnemy("slime", 300);}
				if(Time == 22520){spawnEnemy("slime", 200);}
				if(Time == 22530){spawnEnemy("slime", 100);}
				
				if(Time == 22630){spawnEnemy("slime", 450);}
				if(Time == 22640){spawnEnemy("slime", 350);}
				if(Time == 22650){spawnEnemy("slime", 250);}
				if(Time == 22660){spawnEnemy("slime", 150);}
				
				if(Time == 22800){spawnEnemy("catalyst", 75);}
				if(Time == 22820){spawnEnemy("catalyst", 175);}
				if(Time == 22840){spawnEnemy("catalyst", 275);}
				if(Time == 22860){spawnEnemy("catalyst", 375);}
				if(Time == 22880){spawnEnemy("catalyst", 475);}
				if(Time == 22900){spawnEnemy("catalyst", 575);}
				
				if(Time == 23000){spawnEnemy("slime", 150);}
				if(Time == 23010){spawnEnemy("slime", 250);}
				if(Time == 23020){spawnEnemy("slime", 350);}
				if(Time == 23030){spawnEnemy("slime", 450);}
				
				if(Time == 23200){spawnEnemy("catalyst", 75);}
				if(Time == 23220){spawnEnemy("catalyst", 175);}
				if(Time == 23240){spawnEnemy("catalyst", 275);}
				if(Time == 23260){spawnEnemy("catalyst", 375);}
				if(Time == 23280){spawnEnemy("catalyst", 475);}
				if(Time == 23300){spawnEnemy("catalyst", 575);}
				
				if(Time == 23440){spawnEnemy("slime", 125);}
				if(Time == 23450){spawnEnemy("slime", 225);}
				if(Time == 23460){spawnEnemy("slime", 325);}
				if(Time == 23470){spawnEnemy("slime", 425);}
				
				if(Time == 23600){spawnEnemy("catalyst", 75);}
				if(Time == 23620){spawnEnemy("catalyst", 175);}
				if(Time == 23640){spawnEnemy("catalyst", 275);}
				if(Time == 23660){spawnEnemy("catalyst", 375);}
				if(Time == 23680){spawnEnemy("catalyst", 475);}
				if(Time == 23700){spawnEnemy("catalyst", 575);}
				
				if(Time == 24000){spawnEnemy("cube", 125);}
				if(Time == 24010){spawnEnemy("cube", 225);}
				if(Time == 24020){spawnEnemy("cube", 325);}
				if(Time == 24030){spawnEnemy("cube", 425);}
				
				if(Time == 24300){spawnEnemy("catalyst", 75);}
				if(Time == 24320){spawnEnemy("catalyst", 175);}
				if(Time == 24340){spawnEnemy("catalyst", 275);}
				if(Time == 24360){spawnEnemy("catalyst", 375);}
				if(Time == 24380){spawnEnemy("catalyst", 475);}
				if(Time == 24400){spawnEnemy("catalyst", 575);}
				
				if(Time == 24800){spawnEnemy("slime", 150);}
				if(Time == 24810){spawnEnemy("slime", 250);}
				if(Time == 24820){spawnEnemy("slime", 350);}
				if(Time == 24830){spawnEnemy("slime", 450);}
				
				if(Time == 24880){spawnEnemy("slime", 125);}
				if(Time == 24890){spawnEnemy("slime", 225);}
				if(Time == 24900){spawnEnemy("slime", 325);}
				if(Time == 24910){spawnEnemy("slime", 425);}
				
				if(Time == 24960){spawnEnemy("slime", 150);}
				if(Time == 24970){spawnEnemy("slime", 250);}
				if(Time == 24980){spawnEnemy("slime", 350);}
				if(Time == 24990){spawnEnemy("slime", 450);}
			
				if(Time == 25040){spawnEnemy("slime", 125);}
				if(Time == 25050){spawnEnemy("slime", 225);}
				if(Time == 25060){spawnEnemy("slime", 325);}
				if(Time == 25070){spawnEnemy("slime", 425);}
				
				if(Time == 25120){spawnEnemy("slime", 150);}
				if(Time == 25130){spawnEnemy("slime", 250);}
				if(Time == 25140){spawnEnemy("slime", 350);}
				
				if(Time == 25190){spawnEnemy("slime", 225);}
				if(Time == 25200){spawnEnemy("slime", 325);}
				if(Time == 25210){spawnEnemy("slime", 425);}
				
				if(Time == 25260){spawnEnemy("slime", 150);}
				if(Time == 25270){spawnEnemy("slime", 250);}
				if(Time == 25280){spawnEnemy("slime", 350);}
				
				if(Time == 25330){spawnEnemy("slime", 225);}
				if(Time == 25340){spawnEnemy("slime", 325);}
				if(Time == 25350){spawnEnemy("slime", 425);}
				
				if(Time == 25400){spawnEnemy("slime", 150);}
				if(Time == 25410){spawnEnemy("slime", 250);}
				
				if(Time == 25460){spawnEnemy("slime", 325);}
				if(Time == 25470){spawnEnemy("slime", 425);}
				
				if(Time == 25520){spawnEnemy("slime", 150);}
				if(Time == 25530){spawnEnemy("slime", 250);}
				
				if(Time == 25580){spawnEnemy("slime", 325);}
				if(Time == 25590){spawnEnemy("slime", 425);}
				
				if(Time == 25640){spawnEnemy("slime", 225);}
				
				if(Time == 25690){spawnEnemy("slime", 375);}
				
				if(Time == 25900){spawnEnemy("cube", 125);}
				if(Time == 25910){spawnEnemy("cube", 225);}
				if(Time == 25920){spawnEnemy("cube", 325);}
				if(Time == 25930){spawnEnemy("cube", 425);}
				
				if(Time == 26200){spawnBoss("slime");}
				if(Time == 26260){createPopup();}
			}
		}
		public function removeAll(){
			for(var i1:int = 0;i1<UILayer.numChildren;i1++){
				var target1:MovieClip = MovieClip(UILayer.getChildAt(i1));
				target1.removeEventListener(Event.ENTER_FRAME, target1.EnterFrame);
			}
			for(var i2:int = 0;i2<slashContainer.numChildren;i2++){
				var target2:MovieClip = MovieClip(slashContainer.getChildAt(i2));
				target2.removeEventListener(Event.ENTER_FRAME, target2.EnterFrame);
			}
			for(var i3:int = 0;i3<droneLaserContainer.numChildren;i3++){
				var target3:MovieClip = MovieClip(droneLaserContainer.getChildAt(i3));
				target3.removeEventListener(Event.ENTER_FRAME, target3.EnterFrame);
			}
			for(var i4:int = 0;i4<DroneLayer.numChildren;i4++){
				var target4:MovieClip = MovieClip(DroneLayer.getChildAt(i4));
				target4.removeEventListener(Event.ENTER_FRAME, target4.EnterFrame);
			}
			for(var i5:int = 0;i5<ObjectLayer.numChildren;i5++){
				var target5:MovieClip = MovieClip(ObjectLayer.getChildAt(i5));
				target5.removeEventListener(Event.ENTER_FRAME, target5.EnterFrame);
			}
			for(var i6:int = 0;i6<ButtonLayer.numChildren;i6++){
				var target6:MovieClip = MovieClip(ButtonLayer.getChildAt(i6));
				target6.Delete();
			}
			for(var i7:int = 0;i7<BackgroundLayer.numChildren;i7++){
				var target7:MovieClip = MovieClip(BackgroundLayer.getChildAt(i7));
				target7.removeEventListener(Event.ENTER_FRAME, target7.EnterFrame);
			}
			UILayer.removeChildren();
			slashContainer.removeChildren();
			droneLaserContainer.removeChildren();
			DroneLayer.removeChildren();
			ObjectLayer.removeChildren();
			ButtonLayer.removeChildren();
			BackgroundLayer.removeChildren();
			
			stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
	}

}