package units 
{
	import maps.LevelMap;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class SolidBlock extends Scoreable
	{
		
		private var map:LevelMap;
		private var xMapCoord:int = 0;
		private var yMapCoord:int = 0;
		
		public function SolidBlock(_map:LevelMap, _player:Player, _blueExplosions:FlxGroup, _textGroup:FlxGroup, xCoord:int, yCoord:int) 
		{
			super(_player,_textGroup,  _blueExplosions);
			
			immovable = true;
			
			map = _map;
			
			xMapCoord = xCoord;
			yMapCoord = yCoord;
			
			health = 10;
			points = 10;
			
			loadGraphic(AssetsRegistry.solidBlockPNG);
			
			//TODO, set to invisible, collideable tile
			map.setTile(xCoord, yCoord, 14);
		}
		
		override public function kill():void
		{
			super.kill();
			
			map.setTile(xMapCoord, yMapCoord, 0);
		}
		
	}

}