
package
{
	import FileLoad;
	
	import HashTable;
	
	public class MainClass
	/**
	 * 모든 클래스 들을 관리하는 MainClass 
	 */
	{
		private var mFileLoad : FileLoad; 		
		private var mHashTable : HashTable;
		
		public static var m_InputScroe : Number = 0;
		public static var OutText:String = ""; 
		
		public function MainClass()
		{
		}
		/**
		 * 각각 클래스 및 데이터 초기화 저장 하는 부분 
		 * 
		 */		
		public  function initalize() : void
		{
			HashTable.Static_MatchedCount = 0;
			
			mFileLoad = new FileLoad("data.txt");
			mFileLoad.DataSave();		//텍스트에서 불러온 데이터 PlayerClass 객체에 저장
			
			mHashTable = new HashTable(mFileLoad.GetData(),mFileLoad.GetPlayerCount(),m_InputScroe);
			mHashTable.Create_HashTable();		//HashTable 생성
			mHashTable.Insert_Data();			//HashTable에 각각 그룹에 데이터 입력
		}
		/**
		 *플레이어 매칭 호출 
		 * 
		 */		
		public  function Progress() : void
		{
			mHashTable.Matched();		//사용자가 입력 한 점수에 따른 매칭 시작
		}	
		/**
		 *매칭 된 플레이어를 출력 하는 부분 
		 * 
		 */		
		public function Render() : void
		{
			TextOut();
		}
		public function TextOut() : void
		{
			//윈도우 창에 출력 하기 위한 함수
			OutText = " ";
			var PreNum : int = 0;
			var GroupCount : int =0;
			var TempVector : Vector.<PlayerClass> = new Vector.<PlayerClass>;
			var Tempcnt : int = 0;
			
			for(var mVar : int =0;mVar < HashTable.Static_MatchedCount; mVar++)
			{
				if(PreNum == HashTable.Static_MatchedPlayer[mVar].HashKey || mVar == 0 && mVar != HashTable.Static_MatchedCount-1 && HashTable.Static_MatchedCount != 1) 	//매칭된 플레이어의 숫자가 1명초과 5명 이하일 경우
				{
					GroupCount++;
					TempVector[Tempcnt++] = HashTable.Static_MatchedPlayer[mVar];
				}
				else if(HashTable.Static_MatchedCount == 1) 		//매칭된 플레이어의 숫자가 1명일 경우
				{
					GroupCount++;
					TempVector[Tempcnt++] = HashTable.Static_MatchedPlayer[mVar];
				}
				else
				{
					OutText+="> Matched Group: "+ TempVector[0].HashKey + "(" + GroupCount + " Plyaer)\n"
					for(var mVar2 : int =0;mVar2 < GroupCount; mVar2++)
					{
						OutText+="User(id : " +TempVector[mVar2].ID + ", name: "+TempVector[mVar2].Name +", score: "+ TempVector[mVar2].Score + ",win : "+TempVector[mVar2].WinCount + ", lose: " + TempVector[mVar2].LoseCount +")\n"
					}
					OutText+="\n";
					GroupCount = 0;
					Tempcnt = 0;
					
					TempVector[Tempcnt++] = HashTable.Static_MatchedPlayer[mVar];
					GroupCount++;
				}
				
				if(mVar == HashTable.Static_MatchedCount-1)
				{
					OutText+="> Matched Group: "+ TempVector[0].HashKey + "(" + GroupCount + " Plyaer)\n"
					for(var mVar3 : int =0;mVar3 < GroupCount; mVar3++)
					{
						OutText+="User(id : " +TempVector[mVar3].ID + ", name: "+TempVector[mVar3].Name +", score: "+ TempVector[mVar3].Score + ",win : "+TempVector[mVar3].WinCount + ", lose: " + TempVector[mVar3].LoseCount +")\n"
					}
				}
				PreNum = HashTable.Static_MatchedPlayer[mVar].HashKey;
			}
		}
	}
}