package components
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.FlexEvent;
	
	import vo.CategoryVO;

	public class Phone extends XMLLoading
	{
		import vo.ProductVO;

		private const DP_DATA_URL:String = "http://digitalprimates.net/flexstore/data/catalog.xml";
		
		private const NOKIA_3000:String = "Nokia 3000";
		private const NOKIA_6000:String = "Nokia 6000";
		private const NOKIA_7000:String = "Nokia 7000";
		private const NOKIA_9000:String = "Nokia 9000";
		
		[Bindable]
		protected var phoneCategories:ArrayCollection;
		
		//-------------------------------------------------------------------
		
		private function filter3( product:ProductVO ):Boolean 
		{
			return ( product.series.toString() == "3000" );
		}
		
		private function filter6( product:ProductVO ):Boolean 
		{
			return ( product.series.toString() == "6000" );
		}
		
		private function filter7( product:ProductVO ):Boolean 
		{
			return ( product.series.toString() == "7000" );
		}
		
		private function filter9( product:ProductVO ):Boolean 
		{
			return ( product.series.toString() == "9000" );
		}
		
		override public function get url():String
		{
			var url:String = DP_DATA_URL;
			return url;
		}
		
		//-------------------------------------------------------------------
		
		override protected function sortXML( xmlNodes:Array ):void
		{
			var products3Collection:ArrayCollection = new ArrayCollection( xmlNodes );
			var products6Collection:ArrayCollection = new ArrayCollection( xmlNodes );
			var products7Collection:ArrayCollection = new ArrayCollection( xmlNodes );
			var products9Collection:ArrayCollection = new ArrayCollection( xmlNodes );
			
			sortProductsByCategory( products3Collection, filter3 );
			sortProductsByCategory( products6Collection, filter6 );
			sortProductsByCategory( products7Collection, filter7 );
			sortProductsByCategory( products9Collection, filter9 );
			
			var filtered3Category:CategoryVO = new CategoryVO( NOKIA_3000, products3Collection );
			var filtered6Category:CategoryVO = new CategoryVO( NOKIA_6000, products6Collection );
			var filtered7Category:CategoryVO = new CategoryVO( NOKIA_7000, products7Collection );
			var filtered9Category:CategoryVO = new CategoryVO( NOKIA_9000, products9Collection );
			
			phoneCategories = new ArrayCollection();
			
			phoneCategories.addItem( filtered3Category ); 
			phoneCategories.addItem( filtered6Category ); 
			phoneCategories.addItem( filtered7Category ); 
			phoneCategories.addItem( filtered9Category ); 
		}
		

		
		override protected function parseXML( xmlNodes:XML ):Array 
		{
			nodeItems = new Array();
			
			for each( var productXML:XML in xmlNodes.product ) 
			{
				var productId:int = productXML[0].@productId;
				var name:String = productXML[0].name;
				var description:String = productXML[0].description;
				var price:Number = productXML[0].price;
				var image:String = productXML[0].image;
				var series:int = productXML[0].series;
				var triband:Boolean = productXML[0].triband;
				var camera:Boolean = productXML[0].camera;
				var video:Boolean = productXML[0].video;
				var highlight1:String = productXML[0].highlight1;
				var highlight2:String = productXML[0].highlight2;
				
				var product:ProductVO = new ProductVO( productId, name, description, price, image, series, triband, camera, video, highlight1, highlight2 );
				
				nodeItems.push(product);
				filteredPhones = nodeItems.con
			}
			
			return nodeItems;
		}
		
//		private function clone(source:Object):Array 
//		{ 
//			var myBA:ByteArray = new ByteArray(); 
//			myBA.writeObject(source); 
//			myBA.position = 0; 
//			return(myBA.readObject()); 
//		}

		//----------------------------------------------------
		[Bindable]
		protected var filteredPhones:Array = new Array();
		
		[Bindable]
		protected var descriptionFilter:String;
		
		[Bindable]
		protected var nameFilter:String;
		
		[Bindable]
		protected var video:Boolean = true;
		
		[Bindable]
		protected var camera:Boolean = true;
		
		[Bindable]
		protected var triband:Boolean = true;
		
		[Bindable]
		protected var priceMax:Number;
		
		
		protected function testRegex( regex:RegExp, value:String ):Boolean
		{
			return new RegExp( regex ).test( value ) ? true : false
		}
		
		//--------------------- FILTERS -----------------------
		protected function filterPrice( product:ProductVO ):Boolean
		{
			return ( product.price >= priceMax );
		}
		
		protected function filterVideo( product:ProductVO ):Boolean
		{
			return ( product.video == video );
		}
		
		protected function filterCamera( product:ProductVO ):Boolean
		{
			return ( product.camera == camera );
		}
		
		protected function filterTriband( product:ProductVO ):Boolean
		{
			return ( product.triband == triband );
		}
		
		protected function filterDescription( product:ProductVO ):Boolean
		{
			return ( testRegex(/(descriptionFilter)/, product.description) );
		}
		
		protected function filterName( product:ProductVO ):Boolean
		{
			return ( testRegex(/(nameFilter)/, product.name) );
		}

		//------------ APPLY FILTERS-------------------------------------------
		
		protected function applyFilters():Array
		{
			for( var i:int = filteredPhones.length - 1; i >= 0; i-- )
			{
				var phone:ProductVO = filteredPhones[i];
				if ( !( filterPrice(phone) && filterVideo(phone) && filterCamera(phone) && filterTriband(phone) && filterDescription(phone) && filterName(phone) ) )
				{
					trace("filtered length before: " + filteredPhones.length);
					filteredPhones.splice(i, 1);
					trace("i: " + i);
					trace("filtered length after: " + filteredPhones.length);
				}
			}
			filteredPhones;
			return filteredPhones;
		}
		
		protected function resetFilters():void
		{
			filteredPhones = nodeItems;
			trace(filteredPhones.length);
		}
		
		//----------------------------------------------------
		
		
		private function traceOutPhone(event:FlexEvent):void
		{
//			trace("phone initialized");
		}

		public function Phone()
		{
			super();
			this.addEventListener(FlexEvent.INITIALIZE, traceOutPhone);
		}
	}
}