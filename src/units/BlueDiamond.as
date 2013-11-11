package units 
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class BlueDiamond extends Scoreable
	{
		
		public function BlueDiamond(_textGroup:FlxGroup) 
		{
			super(_textGroup);
			
			immovable = true;
			
			points = 10;
			health = 10;
			
			loadGraphic(AssetsRegistry.blueDiamondPNG);
		}
		
	}

}