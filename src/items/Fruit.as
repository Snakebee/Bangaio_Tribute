package items 
{
	import org.flixel.*;
	import units.Player;
	import units.Scoreable;
	
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Fruit extends Scoreable implements Item
	{
		private var chargeAmt:uint = 0;
		private var moveTowardsPlayer:Boolean = false;
		
		public function Fruit() 
		{
			super(null, null);
			scoreColor = 0xffFF3300;
			
			immovable = true;
			enableExplosion = false;
			
			points = 10;
		}
		
		public function setPos(X:int, Y:int, _player:Player, _textGroup:FlxGroup, _fruitType:String):void
		{
			revive();
			moveTowardsPlayer = false;
			
			x = X;
			y = Y;
			
			if (textGroup == null)
			{
				textGroup = _textGroup;
				player = _player;
				
				if (_fruitType == "orange")
				{
					loadRotatedGraphic(AssetsRegistry.orangePNG, 1);
					chargeAmt = 1;
				}
				
				else if (_fruitType == "apple")
				{
					loadRotatedGraphic(AssetsRegistry.applePNG, 1);
					chargeAmt = 2;
				}
				
				else if (_fruitType == "banana")
				{
					loadRotatedGraphic(AssetsRegistry.bananaPNG, 1);
					chargeAmt = 4;
				}
				
				else if (_fruitType == "pineapple")
				{
					loadRotatedGraphic(AssetsRegistry.pineapplePNG, 1);
					chargeAmt = 8;
				}
				
				else if (_fruitType == "watermelon")
				{
					loadRotatedGraphic(AssetsRegistry.watermelonPNG, 1);
					chargeAmt = 16;
				}
			}
		}
		
		public function setPosAt(targetMidpoint:FlxPoint, _player:Player, _textGroup:FlxGroup, _fruitType:String):void
		{
			revive();
			moveTowardsPlayer = true;
			
			if (textGroup == null)
			{
				textGroup = _textGroup;
				player = _player;
				
				if (_fruitType == "orange")
				{
					loadRotatedGraphic(AssetsRegistry.orangePNG, 1);
					chargeAmt = 1;
				}
				
				else if (_fruitType == "apple")
				{
					loadRotatedGraphic(AssetsRegistry.applePNG, 1);
					chargeAmt = 2;
				}
				
				else if (_fruitType == "banana")
				{
					loadRotatedGraphic(AssetsRegistry.bananaPNG, 1);
					chargeAmt = 4;
				}
				
				else if (_fruitType == "pineapple")
				{
					loadRotatedGraphic(AssetsRegistry.pineapplePNG, 1);
					chargeAmt = 8;
				}
				
				else if (_fruitType == "watermelon")
				{
					loadRotatedGraphic(AssetsRegistry.watermelonPNG, 1);
					chargeAmt = 16;
				}
			}
			
			x = targetMidpoint.x - (this.width / 2);
			y = targetMidpoint.y - (this.height / 2);
		}
		
		public function pickUp(_player:Player):void
		{
			_player.setCharge(chargeAmt);
			
			_player.overDriveHud.updateOverdriveHud();
			
			kill();
			
			FlxG.play(AssetsRegistry.fruitPickup_MP3);
		}
		
		
		override public function update():void
		{
			super.update();
			
			if (moveTowardsPlayer)
			{
				angle = GameUtil.easeTowardsTarget(this, player, 8000, 0.1);
			}
		}
		
		
		override public function addScore():uint
		{
			var newScoreAmt:uint = player.multiplyFruit(points);
			
			player.score.increaseScore(newScoreAmt);
			
			return newScoreAmt;
		}
	}

}