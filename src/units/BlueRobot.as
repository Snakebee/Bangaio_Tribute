package units 
{
	import hud.CountdownTimer;
	import items.Fruit;
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import util.BulletTrailsContainer;
	import weapons.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BlueRobot extends Shooter implements Sentient
	{
		private var aware:Boolean = false;
		private var bananas:FlxGroup;
		private var jumping:Boolean = false;
		
		protected var jumpSpeed:int = 14000;
		
		public function BlueRobot() 
		{
			super(null, null, null, null, null, null, null);
			
			health = 40;
			points = 500;
			speed = 150;
			
			loadGraphic(AssetsRegistry.bluePNG, true, true, 35, 50);
			addAnimation("down", [1], 60);
			addAnimation("downward", [2], 60);
			addAnimation("straight", [3], 60);
			addAnimation("upward", [4], 60);
			addAnimation("up", [5], 60);
			
			maxVelocity.x = 100;
			
		}
		
		public function setPos(X:int, Y:int, _enemyBullets:FlxGroup, _player:Player,  _blueExplosions:FlxGroup, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _bananas:FlxGroup, _enemies:FlxGroup, _targets:Array, _bulletType:String = "normal"):void
		{
			revive();
			
			x = X;
			y = Y;
			
			if (!textGroup)
			{
				setupGun(_enemyBullets, _bulletTrails, _bulletType);
				gun.setBulletSpeed(250);
				gun.setFireRate(1000);
				
				player = _player;
				blueExplosions = _blueExplosions;
				map = _map;
				textGroup = _textGroup;
				bananas = _bananas;
				
				_enemies.add(this);
				_targets.push(this);
			}
			
		}
		
		override public function revive():void
		{
			super.revive();
			
			health = 40;
			points = 500;
			
			aware = false;
		}
		
		override public function update():void
		{
			
			super.update();
			
			inSight = map.ray(this.getMidpoint(), player.getMidpoint(), null, 1);
			
			if (inSight)
			{
				alert = true;
				
				// find the angle between enemy and player
				directionAngle = FlxVelocity.angleBetween(this, player, true);

				// find where the enemy should aim
				aim = GameUtil.findDirection(directionAngle);
				
				gun.fireFromAngle(aim);
			}
			
			if (alert)
			{
				// find which way enemy should face
				this.facing = GameUtil.findFacing(directionAngle);
					
			}
			
			move();
			
			// plays the animation for where the enemy is aiming
			// up-right, up-left
			if (aim == GameUtil.AIM_RIGHT_UP || aim == GameUtil.AIM_LEFT_UP)
				play("upward");
			// down-left, down-right
			else if ( aim == GameUtil.AIM_LEFT_DOWN || aim == GameUtil.AIM_RIGHT_DOWN)
				play ("downward");
			// down
			else if (aim == GameUtil.AIM_DOWN)
				play ("down");
			// up
			else if (aim == GameUtil.AIM_UP)
				play ("up");
			else
				play("straight");
			
		}
		
		private function move():void
		{
			
			if (justTouched(FLOOR))
			{
				
				if (!jumping)
				{
					jumping = true;
					
					velocity.x = velocity.y = acceleration.x = 0;
				}
			}
			
			else if (justTouched(WALL))
			{
				jump();
			}
			
			else if (isTouching(FLOOR))
			{
				if (this.getMidpoint().x < player.getMidpoint().x) velocity.x = maxVelocity.x;
				else velocity.x = -(maxVelocity.x);
			}
			
			else
			{	
				acceleration.y = GameData.g_const;
			}
		}
		
		private function jump():void
		{
			jumping = false;
			
			if (this.getMidpoint().x < player.getMidpoint().x) acceleration.x = maxVelocity.x;
			else acceleration.x = -(maxVelocity.x);
			
			acceleration.y -= jumpSpeed;
		}
		
		public function knockBack(source:FlxObject):void
		{
			if (this.getMidpoint().x < source.getMidpoint().x)
				{
					this.velocity.x = -(GameData.g_const)/2;
				}
				
				else
				{
					this.velocity.x = GameData.g_const/2;
				}
				
				if (this.getMidpoint().y < source.getMidpoint().y)
				{
					this.velocity.y = -(GameData.g_const)/2;
				}
				
				else
				{
					this.velocity.y = GameData.g_const/2;
				}
		}
		
		override public function kill():void
		{	
			super.kill();
			
			(bananas.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "banana");
		}
		
	}

}