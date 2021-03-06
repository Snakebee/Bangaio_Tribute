package units 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	import hud.CountdownTimer;
	import maps.LevelMap;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import util.BulletTrailsContainer;
	import items.Fruit
	import weapons.*; 
	 
	public class Flak extends Shooter
	{	
		private var pineapples:FlxGroup;
		
		//timer vars
		private var fireRate:Number = 3000;
		private var nextFire:Number = 0;
		
		public function Flak() 
		{
			super(null, null, null, null, null, null, null);
			
			this.immovable = true;
			
			health = 160;
			points = 500;
			
			loadGraphic(AssetsRegistry.flakPNG);
		}
		
		public function setPos(X:int, Y:int, _enemyBullets:FlxGroup, _player:Player,  _blueExplosions:FlxGroup, _map:LevelMap, _bulletTrails:BulletTrailsContainer, _textGroup:FlxGroup, _bulletType:String, _pineapples:FlxGroup, _enemies:FlxGroup, _targets:Array):void
		{
			revive();
			
			this.x = X;
			this.y = Y;
			
			if (!textGroup)
			{
				player = _player;
				blueExplosions = _blueExplosions
				map = _map;
				textGroup = _textGroup;
				pineapples = _pineapples;
				
				_enemies.add(this);
				_targets.push(this);
				
				setupGun(_enemyBullets, _bulletTrails, _bulletType);
				gun.setBulletSpeed(250);
				gun.setFireRate(0);
				gun.setBulletOffset(0, 0);
			}
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
			}
			
			if (this.onScreen() && inSight && (CountdownTimer.getTimer() > nextFire))
			{
				nextFire = CountdownTimer.getTimer() + fireRate;
				
				gun.missleOverdrive(20);
			}
		}
		
		override public function revive():void
		{
			super.revive();
			
			health = 160;
			points = 500;
			
			nextFire = CountdownTimer.getTimer() + fireRate/2;
		}
		
		override public function kill():void
		{
			(pineapples.recycle(Fruit) as Fruit).setPosAt(this.getMidpoint(), player, textGroup, "pineapple");

			super.kill();
		}
		
	}

}