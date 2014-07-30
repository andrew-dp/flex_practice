package vo 
{
	
	public class StreamVO 
	{
		
		//-------------------------------------------------------------------
		
		private var _name:String;

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}
		
		//-------------------------------------------------------------------
		
		private var _url:String;

		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
		}
		
		//-------------------------------------------------------------------
		
		private var _live:Boolean;

		public function get live():Boolean
		{
			return _live;
		}

		public function set live(value:Boolean):void
		{
			_live = value;
		}
		
		//-------------------------------------------------------------------
		
		/**
		 * 
		 * @param name
		 * @param url
		 * @param live
		 * 
		 */
		public function StreamVO( name:String, url:String, live:Boolean ) 
		{
			this.name = name
			this.url = url;
			this.live = live;
		}
	}
}