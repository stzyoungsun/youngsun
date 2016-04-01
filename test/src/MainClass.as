
package
{
	import FileLoad;
	
	import HashTable;
	
	public class MainClass
	/**
	 * 모든 클래스 들을 관리하는 MainClass 
	 */
	{
		private var _loadFile : FileLoad; 		
		private var _hashTable : HashTable;
		
		public static var inputScroe : Number = 0;
		public static var saveTextBox:String = ""; 
		
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
			
			_loadFile = new FileLoad("data.txt");
			_loadFile.saveData();		//텍스트에서 불러온 데이터 PlayerClass 객체에 저장
			
			_hashTable = new HashTable(_loadFile.getData(),_loadFile.getPlayerCount(),inputScroe);
			_hashTable.Create_HashTable();		//HashTable 생성
			_hashTable.Insert_Data();			//HashTable에 각각 그룹에 데이터 입력
		}
		/**
		 *플레이어 매칭 호출 
		 * 
		 */		
		public  function progress() : void
		{
			_hashTable.Matched();		//사용자가 입력 한 점수에 따른 매칭 시작
		}	
		/**
		 *매칭 된 플레이어를 출력 하는 부분 
		 * 
		 */		
		public function render() : void
		{
			outText();
		}
		public function outText() : void
		{
			//윈도우 창에 출력 하기 위한 함수
			saveTextBox = " ";
			var preNum : int = 0;
			var countGroup : int =0;
			var vectorTemp : Vector.<PlayerClass> = new Vector.<PlayerClass>;
			var countTemp : int = 0;
			
			for(var mVar : int =0;mVar < HashTable.Static_MatchedCount; mVar++)
			{
				if(preNum == HashTable.Static_MatchedPlayer[mVar].HashKey || mVar == 0 && mVar != HashTable.Static_MatchedCount-1 && HashTable.Static_MatchedCount != 1) 	//매칭된 플레이어의 숫자가 1명초과 5명 이하일 경우
				{
					countGroup++;
					vectorTemp[countTemp++] = HashTable.Static_MatchedPlayer[mVar];
				}
				else if(HashTable.Static_MatchedCount == 1) 		//매칭된 플레이어의 숫자가 1명일 경우
				{
					countGroup++;
					vectorTemp[countTemp++] = HashTable.Static_MatchedPlayer[mVar];
				}
				else
				{
					saveTextBox+="> Matched Group: "+ vectorTemp[0].HashKey + "(" + countGroup + " Plyaer)\n"
					for(var mVar2 : int =0;mVar2 < countGroup; mVar2++)
					{
						saveTextBox+="User(id : " +vectorTemp[mVar2].ID + ", name: "+vectorTemp[mVar2].Name +", score: "+ vectorTemp[mVar2].Score + ",win : "+vectorTemp[mVar2].WinCount + ", lose: " + vectorTemp[mVar2].LoseCount +")\n"
					}
					saveTextBox+="\n";
					countGroup = 0;
					countTemp = 0;
					
					vectorTemp[countTemp++] = HashTable.Static_MatchedPlayer[mVar];
					countGroup++;
				}
				
				if(mVar == HashTable.Static_MatchedCount-1)
				{
					saveTextBox+="> Matched Group: "+ vectorTemp[0].HashKey + "(" + countGroup + " Plyaer)\n"
					for(var mVar3 : int =0;mVar3 < countGroup; mVar3++)
					{
						saveTextBox+="User(id : " +vectorTemp[mVar3].ID + ", name: "+vectorTemp[mVar3].Name +", score: "+ vectorTemp[mVar3].Score + ",win : "+vectorTemp[mVar3].WinCount + ", lose: " + vectorTemp[mVar3].LoseCount +")\n"
					}
				}
				preNum = HashTable.Static_MatchedPlayer[mVar].HashKey;
			}
		}
	}
}