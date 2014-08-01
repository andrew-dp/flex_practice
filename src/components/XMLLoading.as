package components
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.GroupingCollection;
	import mx.containers.Canvas;
	
	
	public class XMLLoading extends Canvas
	{
		import mx.collections.ArrayCollection;
		import mx.events.FlexEvent;
		
		protected var xmlLoader:URLLoader;
		protected var returnXML:XML;
		
		[Bindable]
		protected var xmlNodes:Array;
		
		[Bindable]
		protected var nodeItems:Array;
		
		[Bindable]
		public var gc:GroupingCollection;

		public function get url():String
		{
			var url:String = "foo";
			return url;
		}
		
		protected function sortProductsByCategory( productsCollection:ArrayCollection, filter:Function ):void
		{
			productsCollection.filterFunction = filter;
			productsCollection.refresh();
		}
		
		protected function sortXML( xmlNodes:Array ):void
		{
			throw new Error("This should be implemented by sub-class");
		}
		
		protected function parseXML( catalogXML:XML ):Array 
		{
			throw new Error("This should be implemented by sub-class");
			return null;
		}
		
		protected function handle_xmlLoaderComplete(e:Event):void 
		{
			returnXML = XML(e.target.data);
			xmlNodes = new Array();
			xmlNodes = parseXML(returnXML);
			
			sortXML(xmlNodes);
			
			gc.refresh();
		}
		
		protected function sourceBaseInitializer(event:FlexEvent):void
		{
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, handle_xmlLoaderComplete);
			xmlLoader.load(new URLRequest(url));
		}
		
		public function traceOut(event:FlexEvent):void
		{
			trace("XMLLoading initialized");
		}
		
		public function XMLLoading()
		{
			super();
			this.addEventListener(FlexEvent.INITIALIZE, traceOut);
		}
	}
}