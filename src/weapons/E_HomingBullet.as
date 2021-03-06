package weapons 
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class E_HomingBullet extends BulletExt
	{
		
		public const SPEED:uint = 4500;
		public const TURN_SPEED:Number = 0.1;
		
		public function E_HomingBullet() 
		{
			super();
			
			loadRotatedGraphic(AssetsRegistry.e_homingBulletPNG, 800);
			
			offset.x = 11;
			width = 16;
			offset.y = 11;
			height = 16;
			
			trailColor = 0xffFF0000;
		}
		
		override public function update():void
		{
			super.update();
			
			if (touching) kill();
			
			if (player != null && player.exists)
			{
				angle = GameUtil.easeTowardsTarget(this, player, SPEED, TURN_SPEED);
			}
		}
		
	}

}