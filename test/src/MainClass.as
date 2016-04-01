
package
{
	import FileLoad;
	import HashTable;
	
	public class MainClass
	{
		private var mFileLoad : FileLoad; 		
		private var mHashTable : HashTable;
		
		public static var m_MyScroe : Number = 0;
		public static var myText:String = ""; 
		public function MainClass()
		{
		}
		
		public  function initalize() : void
		{
			HashTable.m_MatchedCount = 0;
			
			mFileLoad = new FileLoad("data.txt");
			mFileLoad.DataSave();		//텍스트에서 불러온 데이터 PlayerClass 객체에 저장
			
			mHashTable = new HashTable(mFileLoad.GetData(),mFileLoad.GetPlayerCount(),m_MyScroe);
			mHashTable.Create_HashTable();		//HashTable 생성
			mHashTable.Insert_Data();			//HashTable에 각각 그룹에 데이터 입력
		}
		
		public  function Progress() : void
		{
			mHashTable.Matched();		//사용자가 입력 한 점수에 따른 매칭 시작
		}	
		
		public function Render() : void
		{
			//윈도우 창에 출력 하기 위한 함수
			myText = " ";
			var PreNum : int = 0;
			var GroupCount : int =0;
			var TempVector : Vector.<PlayerClass> = new Vector.<PlayerClass>;
			var Tempcnt : int = 0;
			
			for(var mVar : int =0;mVar < HashTable.m_MatchedCount; mVar++)
			{
				if(PreNum == HashTable.m_MatchedPlayer[mVar].HashKey || mVar == 0 && mVar != HashTable.m_MatchedCount-1 && HashTable.m_MatchedCount != 1) 	//매칭된 플레이어의 숫자가 1명초과 5명 이하일 경우
				{
					GroupCount++;
					TempVector[Tempcnt++] = HashTable.m_MatchedPlayer[mVar];
				}
				else if(HashTable.m_MatchedCount == 1) 		//매칭된 플레이어의 숫자가 1명일 경우
				{
					GroupCount++;
					TempVector[Tempcnt++] = HashTable.m_MatchedPlayer[mVar];
				}
				else
				{
					myText+="> Matched Group: "+ TempVector[0].HashKey + "(" + GroupCount + " Plyaer)\n"
					for(var mVar2 : int =0;mVar2 < GroupCount; mVar2++)
					{
						myText+="User(id : " +TempVector[mVar2].ID + ", name: "+TempVector[mVar2].Name +", score: "+ TempVector[mVar2].Score + ",win : "+TempVector[mVar2].WinCount + ", lose: " + TempVector[mVar2].LoseCount +")\n"
					}
					myText+="\n";
					GroupCount = 0;
					Tempcnt = 0;
					
					TempVector[Tempcnt++] = HashTable.m_MatchedPlayer[mVar];
					GroupCount++;
				}
				if(mVar == HashTable.m_MatchedCount-1)
				{
					myText+="> Matched Group: "+ TempVector[0].HashKey + "(" + GroupCount + " Plyaer)\n"
					for(var mVar3 : int =0;mVar3 < GroupCount; mVar3++)
					{
						myText+="User(id : " +TempVector[mVar3].ID + ", name: "+TempVector[mVar3].Name +", score: "+ TempVector[mVar3].Score + ",win : "+TempVector[mVar3].WinCount + ", lose: " + TempVector[mVar3].LoseCount +")\n"
					}
				}
				PreNum = HashTable.m_MatchedPlayer[mVar].HashKey;
			}
		}	
	}
}