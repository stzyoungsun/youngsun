
package
{
	import FileLoad;
	import HashTable;
	
	public class MainClass
	{
		private var mFileLoad : FileLoad; 		
		private var mHashTable : HashTable;
		
		public static var m_MyScroe : Number = 0;
		
		public function MainClass()
		{
		}
		
		public  function initalize() : void
		{
			HashTable.m_MatchedCount = 0;
			
			mFileLoad = new FileLoad("data.txt");
			mFileLoad.DataSave();		//텍스트에서 불러온 데이터 PlayerClass 객체에 저장
			
			mHashTable = new HashTable(mFileLoad.GetData(),mFileLoad.GetPlayerCount(),m_MyScroe);
			mHashTable.Create_HashTable();
			mHashTable.Insert_Data();
		}
		
		public  function Progress() : void
		{
			mHashTable.Matched();
		}	
	}
}