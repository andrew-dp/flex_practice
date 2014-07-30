package vo
{
	import mx.collections.ArrayCollection;

	public class CategoryVO
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
		
		private var _children:ArrayCollection;

		public function get children():ArrayCollection
		{
			return _children;
		}

		public function set children(value:ArrayCollection):void
		{
			_children = value;
		}
		
		//-------------------------------------------------------------------
		
		public function CategoryVO( name:String, children:ArrayCollection )
		{
			this.name = name;
			this.children = children;
		}
	}
}
