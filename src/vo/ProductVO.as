package vo 
{
	
	public class ProductVO 
	{

		private var _productId:int;

		public function get productId():int
		{
			return _productId;
		}

		public function set productId(value:int):void
		{
			_productId = value;
		}
		
		
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
		
		
		private var _description:String;

		public function get description():String
		{
			return _description;
		}

		public function set description(value:String):void
		{
			_description = value;
		}
		
		
		//-------------------------------------------------------------------
		
		
		private var _price:Number;

		public function get price():Number
		{
			return _price;
		}

		public function set price(value:Number):void
		{
			_price = value;
		}
		
		
		//-------------------------------------------------------------------
		
		
		private var _image:String;

		public function get image():String
		{
			return _image;
		}

		public function set image(value:String):void
		{
			_image = value;
		}
		
		
		//-------------------------------------------------------------------
		
		
		private var _series:int;

		public function get series():int
		{
			return _series;
		}

		public function set series(value:int):void
		{
			_series = value;
		}
		
		
		//-------------------------------------------------------------------
		
		
		private var _triband:Boolean;

		public function get triband():Boolean
		{
			return _triband;
		}

		public function set triband(value:Boolean):void
		{
			_triband = value;
		}

		
		//-------------------------------------------------------------------
		
		
		private var _camera:Boolean;

		public function get camera():Boolean
		{
			return _camera;
		}

		public function set camera(value:Boolean):void
		{
			_camera = value;
		}
		
		
		//-------------------------------------------------------------------
		
		
		private var _video:Boolean;

		public function get video():Boolean
		{
			return _video;
		}

		public function set video(value:Boolean):void
		{
			_video = value;
		}
		
		
		//-------------------------------------------------------------------
		
		
		private var _highlight1:String;

		public function get highlight1():String
		{
			return _highlight1;
		}

		public function set highlight1(value:String):void
		{
			_highlight1 = value;
		}
		
		
		//-------------------------------------------------------------------
		
		
		private var _highlight2:String;

		public function get highlight2():String
		{
			return _highlight2;
		}

		public function set highlight2(value:String):void
		{
			_highlight2 = value;
		}
		
		
		//-------------------------------------------------------------------
		
		
		/**
		 * 
		 * @param name
		 * @param description
		 * @param price
		 * @param image
		 * @param series
		 * @param triband
		 * @param camera
		 * @param video
		 * @param highlight1
		 * @param highlight2
		 * 
		 */
		public function ProductVO( productId:int, name:String, description:String, price:Number, image:String, series:int, triband:Boolean, camera:Boolean, video:Boolean, highlight1:String, highlight2:String ) 
		{
			this.productId = productId;
			this.name = name;
			this.description = description;
			this.price = price;
			this.image = image;
			this.series = series;
			this.triband = triband;
			this.camera = camera;
			this.video = video;
			this.highlight1 = highlight1;
			this.highlight2 = highlight2;
		}
	}
}
