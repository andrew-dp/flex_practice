package components
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.GroupingCollection;
	import mx.containers.Canvas;
	
	public class PhoneBase extends Canvas
	{
		import mx.collections.ArrayCollection;
		import mx.events.FlexEvent;
		
		import vo.CategoryVO;
		import vo.ProductVO;
		
		[Bindable]
		public var gc:GroupingCollection;
		
		private const DP_DATA_URL:String = "http://digitalprimates.net/flexstore/data/catalog.xml";
		
		private const NOKIA_3000:String = "Nokia 3000";
		private const NOKIA_6000:String = "Nokia 6000";
		private const NOKIA_7000:String = "Nokia 7000";
		private const NOKIA_9000:String = "Nokia 9000";
		
		[Bindable]
		protected var products:Array;
		
		[Bindable]
		protected var phoneCategories:ArrayCollection;
		
		private var xmlLoader:URLLoader;
		private var catalogXML:XML;
		
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
		
		//-------------------------------------------------------------------
		
		private function sortProductsByCategory( productsCollection:ArrayCollection, filter:Function ):void
		{
			productsCollection.filterFunction = filter;
			productsCollection.refresh();
		}
		
		//-------------------------------------------------------------------
		
		private function sortProducts( products:Array ):void
		{
			var products3Collection:ArrayCollection = new ArrayCollection( products );
			var products6Collection:ArrayCollection = new ArrayCollection( products );
			var products7Collection:ArrayCollection = new ArrayCollection( products );
			var products9Collection:ArrayCollection = new ArrayCollection( products );
			
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
		
		private function parseXML( catalogXML:XML ):Array 
		{
			products = new Array();
			
			for each( var productXML:XML in catalogXML.product ) 
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
				
				products.push(product);
			}
			
			return products;
		}
		
		private function handle_xmlLoaderComplete(e:Event):void 
		{
			catalogXML = XML(e.target.data);
			products = new Array();
			products = parseXML(catalogXML);
			
			sortProducts(products);
			
			gc.refresh();
		}
		
		protected function phoneBaseInitializer(event:FlexEvent):void
		{
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, handle_xmlLoaderComplete);
			xmlLoader.load(new URLRequest(DP_DATA_URL));
		}
		
		
		public function PhoneBase()
		{
			super();
		}
	}
}