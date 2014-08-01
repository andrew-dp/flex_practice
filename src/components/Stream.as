package components
{
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import vo.CategoryVO;
	
	public class Stream extends XMLLoading
	{
		import vo.StreamVO;
		
		private const DP_SOURCES_URL:String = "http://digitalprimates.net/dash/streams/sources.xml";
		
		private const DASH_EDGESUITE_URL:String = "dash.edgesuite.net";
		private const DEMO_UNIFIED_STREAMING_URL:String = "demo.unified-streaming.com";
		private const DIGITAL_PRIMATES_URL:String = "www.digitalprimates.net";
		
		[Bindable]
		protected var streamCategories:ArrayCollection;
		
		//-------------------------------------------------------------------
		
		private function dashFilter( source:StreamVO ):Boolean
		{
			return ( source.streamName == DASH_EDGESUITE_URL );
		}
		
		private function demoUnifiedFilter( source:StreamVO ):Boolean
		{
			return ( source.streamName == DEMO_UNIFIED_STREAMING_URL );
		}
		
		private function digitalPrimatesFilter( source:StreamVO ):Boolean
		{
			return ( source.streamName == DIGITAL_PRIMATES_URL );
		}
		
		//-------------------------------------------------------------------
		
		override protected function sortXML( xmlNodes:Array ):void
		{
			var dashCollection:ArrayCollection = new ArrayCollection( xmlNodes );
			var unifiedCollection:ArrayCollection = new ArrayCollection( xmlNodes );
			var digitalPrimatesCollection:ArrayCollection = new ArrayCollection( xmlNodes );
			
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
		
		override public function get url():String
		{
			var url:String = DP_SOURCES_URL;
			return url;
		}
		
		//-------------------------------------------------------------------
		
		private function testRegex( regex:RegExp, value:String ):Boolean
		{
			return new RegExp( regex ).test( value ) ? true : false
		}
		
		//-------------------------------------------------------------------
		
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

		
		override protected function parseXML( xmlNodes:XML ):Array
		{
			nodeItems = new Array();
			
			for each( var itemXML:XML in xmlNodes.item )
			{
				var name:String = itemXML[0].name;
				var url:String = itemXML[0].url;
				var streamName:String = getStreamName( url );
				var live:Boolean = itemXML[0].live;
				
				var item:StreamVO = new StreamVO( name, streamName, url, live );
				
				nodeItems.push( item );
			}
			return nodeItems;
		}
		
		private function traceOutStream(event:FlexEvent):void
		{
			trace("stream initialized");
		}

		public function Stream()
		{
			super();
			this.addEventListener(FlexEvent.INITIALIZE, traceOutStream)
		}
	}
}