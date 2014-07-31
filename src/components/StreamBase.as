package components
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.GroupingCollection;
	import mx.containers.Canvas;
	
	public class StreamBase extends Canvas
	{
		import mx.collections.ArrayCollection;
		import mx.events.FlexEvent;
		
		import vo.CategoryVO;
		import vo.StreamVO;
		
		private const DP_SOURCES_URL:String = "http://digitalprimates.net/dash/streams/sources.xml";
		
		private const DASH_EDGESUITE_URL:String = "dash.edgesuite.net";
		private const DEMO_UNIFIED_STREAMING_URL:String = "demo.unified-streaming.com";
		private const DIGITAL_PRIMATES_URL:String = "www.digitalprimates.net";
		
		private var xmlLoader:URLLoader;
		private var sourcesXML:XML;
		
		[Bindable]
		public var gc:GroupingCollection;
		
		[Bindable]
		protected var sources:Array;
		
		[Bindable]
		protected var streamCategories:ArrayCollection;
		
		//-------------------------------------------------------------------
		
		private function testRegex( regex:RegExp, value:String ):Boolean
		{
			return new RegExp(regex).test(value) ? true : false
		}
		
		//-------------------------------------------------------------------
		
		private function dashFilter( source:StreamVO ):Boolean
		{
			return testRegex(/(dash.edgesuite)/, source.url);
		}
		
		private function demoUnifiedFilter( source:StreamVO ):Boolean
		{
			return testRegex(/(unified-streaming)/, source.url);
		}
		
		private function digitalPrimatesFilter( source:StreamVO ):Boolean
		{
			return testRegex(/(digitalprimates.net)/, source.url);
		}
		
		//-------------------------------------------------------------------
		
		private function sortProductsByCategory( productsCollection:ArrayCollection, filter:Function ):void
		{
			productsCollection.filterFunction = filter;
			productsCollection.refresh();
		}
		
		//-------------------------------------------------------------------
		
		private function sortSources( sources:Array ):void
		{
			var dashCollection:ArrayCollection = new ArrayCollection( sources );
			var unifiedCollection:ArrayCollection = new ArrayCollection( sources );
			var digitalPrimatesCollection:ArrayCollection = new ArrayCollection( sources );
			
			sortProductsByCategory( dashCollection, dashFilter );
			sortProductsByCategory( unifiedCollection, demoUnifiedFilter );
			sortProductsByCategory( digitalPrimatesCollection, digitalPrimatesFilter );
			
			var dashCategory:CategoryVO = new CategoryVO( DASH_EDGESUITE_URL, dashCollection );
			var unifiedCategory:CategoryVO = new CategoryVO( DEMO_UNIFIED_STREAMING_URL, unifiedCollection );
			var digitalPrimatesCategory:CategoryVO = new CategoryVO( DIGITAL_PRIMATES_URL, digitalPrimatesCollection );
			
			streamCategories = new ArrayCollection();
			
			streamCategories.addItem( dashCategory );
			streamCategories.addItem( unifiedCategory );
			streamCategories.addItem( digitalPrimatesCategory );
		}
		
		private function getStreamName( url:String ):String
		{
			var stream:String;
			
			if ( testRegex(/(dash.edgesuite)/, url) )
			{
				stream =  DASH_EDGESUITE_URL;
			} 
			else if ( testRegex(/(unified-streaming)/, url) )
			{
				stream = DEMO_UNIFIED_STREAMING_URL;
			}
			else if ( testRegex(/(digitalprimates.net)/, url) )
			{
				stream = DIGITAL_PRIMATES_URL;
			}
			
			return stream;
		}
		
		
		private function parseXML( sourcesXML:XML ):Array
		{
			sources = new Array();
			
			for each( var itemXML:XML in sourcesXML.item )
			{
				var name:String = itemXML[0].name;
				var url:String = itemXML[0].url;
				var streamName:String = getStreamName( url );
				var live:Boolean = itemXML[0].live;
				
				var item:StreamVO = new StreamVO( name, streamName, url, live );
				
				sources.push(item);
			}
			return sources;
		}
		
		
		private function handle_xmlLoaderComplete(e:Event):void 
		{
			sourcesXML = XML(e.target.data);
			sources = new Array();
			sources = parseXML(sourcesXML);
			
			sortSources( sources );
			
			gc.refresh();
		}
		
		
		protected function streamBaseInitializer(event:FlexEvent):void
		{
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, handle_xmlLoaderComplete);
			xmlLoader.load(new URLRequest(DP_SOURCES_URL));
		}
		
		public function StreamBase()
		{
			super();
		}
	}
}