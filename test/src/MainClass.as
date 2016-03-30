
package
{
	import FileLoad;
	
	import HashTable;
	
	import PlayerClass;
	
	public class MainClass
	{
		private var mFileLoad : FileLoad = new FileLoad("D:\\test\\test\\data.txt");		
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
			for(var mVar:int = 0; mVar<mFileLoad.GetPlayerCount();mVar++)	//데이터가 잘 입력 되었는지 테스트 (빈 공간 공백 처리)
			{
				trace(mFileLoad.GetData()[mVar].ID);
				trace(mFileLoad.GetData()[mVar].Name);
				trace(mFileLoad.GetData()[mVar].Score);
				trace(mFileLoad.GetData()[mVar].WinCount);
				trace(mFileLoad.GetData()[mVar].LoseCount);
			}
			mHashTable.Matched();
			
		}
		
		public  function Render() : void
		{
			//HashTable에 저장 된 Matched 플레이어 데이터 양식에 맞게 출력
			
			var PreNum : int = 0;
			var GroupCount : int =0;
			
			var TempVector : Vector.<PlayerClass> = new Vector.<PlayerClass>;
			var Tempcnt : int = 0;
			for(var mVar : int =0;mVar < 5; mVar++)
			{
				if(PreNum == HashTable.m_MatchedPlayer[mVar].HashKey || mVar == 0)
				{
					GroupCount++;
					TempVector[Tempcnt++] = HashTable.m_MatchedPlayer[mVar];
				}
				else
				{
					trace("> Matched Group: "+ TempVector[0].HashKey + "(" + GroupCount + " Plyaer)");
					for(var mVar2 : int =0;mVar2 < GroupCount; mVar2++)
					{
						trace("User(id : " +TempVector[mVar2].ID + ", name: "+TempVector[mVar2].Name +", score: "+ TempVector[mVar2].Score + ",win : "+TempVector[mVar2].WinCount + ", lose: " + TempVector[mVar2].LoseCount +")"); 
					}
					GroupCount = 0;
					Tempcnt = 0;
					
					TempVector[Tempcnt++] = HashTable.m_MatchedPlayer[mVar];
					GroupCount++;
					
					if(mVar == 4)
					{
						trace("> Matched Group: "+ TempVector[0].HashKey + "(" + GroupCount + " Plyaer)");
						for(var mVar3 : int =0;mVar3 < GroupCount; mVar3++)
						{
							trace("User(id : " +TempVector[mVar3].ID + ", name: "+TempVector[mVar3].Name +", score: "+ TempVector[mVar3].Score + ",win : "+TempVector[mVar3].WinCount + ", lose: " + TempVector[mVar3].LoseCount +")"); 
						}
					}
				}
				PreNum = HashTable.m_MatchedPlayer[mVar].HashKey;
			}
		}
		
	}
}