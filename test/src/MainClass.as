
package
{
	import FileLoad;
	import HashTable;
	
	public class MainClass
	{
		private var mFileLoad : FileLoad = new FileLoad("data.txt");		
		private var mHashTable : HashTable;
		private var m_MyScroe : Number;
		
		public function MainClass()
		{
		}
		
		public  function initalize() : void
		{
			m_MyScroe = 350000;
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