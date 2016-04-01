
package
{
	import flash.utils.Dictionary;
	
	import Define;
	
	import Hash_Value;
	
	import PlayerClass;
	
	public class HashTable
	{
		private var _hashTable : Dictionary = new Dictionary();
		private var _group :Vector.<Hash_Value> = new Vector.<Hash_Value>;
		
		private var _vetorPlayer:Vector.<PlayerClass> = new Vector.<PlayerClass>;
		private var _inputScore : Number;
		private var _countPlayer : Number;
		
		public static var Static_MatchedCount : Number = 0;
		public static var Static_MatchedPlayer:Vector.<PlayerClass> = new Vector.<PlayerClass>;
		/**
		 * 
		 * @param Player 		파일에서 불러온 Player 데이터
		 * @param PlyerCount	파일에 저장 되어 있던 Player 숫자	
		 * @param InputScore	사용자가 입력 한 점수		
		 * HashTable 멤버 변수에 매개 변수 값 저장
		 */		
		public function HashTable(Player :Vector.<PlayerClass>,PlyerCount : Number, InputScore : Number )
		{
			//객체에 저장 된 데이터를 이용한 생성자
			_vetorPlayer = Player;
			_countPlayer = PlyerCount;
			_inputScore = InputScore;
		}
		
		public function Insert_Data(): void
		{
			//각각 Key 값에 맞는 그룹에 데이터 저장 (오름차순 저장)
			for(var mVar:int = 0; mVar<_countPlayer;mVar++)	
			{
				_vetorPlayer[mVar].HashKey = Hashing(_vetorPlayer[mVar].Score);
				_group[_vetorPlayer[mVar].HashKey-1].insertSort(_vetorPlayer[mVar],_inputScore);
			}
		}
		
		public function Matched() : void
		{
			//사용자가 입력 한 점수에 따라 총 5명의 플레이어 매칭
			
			var typeGroup : int = -99;
			var inputDataKey : int = Hashing(_inputScore);
			var highTemp : int = 0;
			var lowTemp : int = 0;
			
			while(Static_MatchedCount < Define.MAX_MATCHED_COUNT)
			{
				if(highTemp > 11) break;
				
				if(typeGroup == -99)
				{
					typeGroup = 0;
					if(_hashTable[inputDataKey].getInsertCount() == 0)		//Group내에 플레이어가 없을 경우
						continue;
					_hashTable[inputDataKey].outputPlayer();
				}
				else if(typeGroup == 0 || typeGroup == -1)
				{
					typeGroup = 1;
					highTemp++;
					
					if(inputDataKey+highTemp > Define.MAX_GROUP_COUNT)
						continue;
					if(_hashTable[inputDataKey+highTemp].getInsertCount() == 0)	//Group내에 플레이어가 없을 경우 
						continue;
					_hashTable[inputDataKey+highTemp].outputPlayer();
				}
				else
				{
					typeGroup = -1;
					lowTemp--;
					
					if(inputDataKey+lowTemp <= 0)
						continue;
					if(_hashTable[inputDataKey+lowTemp].getInsertCount() == 0)	//Group내에 플레이어가 없을 경우 
						continue;
					_hashTable[inputDataKey+lowTemp].outputPlayer();
					
				}
			}
		}
		
		/**
		 * 플레이어 점수에 따라 Hash Key 설정
		 * @param PlayerScore 플레이어의 점수 값
		 * @return 플레이어 점수 값에 따른 HashKey 값
		 * 
		 */
		public function Hashing(PlayerScore : Number) : int
		{
			
			var groupNum : int = 0;
			 
			if(PlayerScore <= 0)
				return -1;
			
			if(PlayerScore%Define.GROUP_RANGE == 0)
			{
				groupNum = PlayerScore/Define.GROUP_RANGE;
				if(groupNum > Define.MAX_GROUP_COUNT) groupNum = Define.MAX_GROUP_COUNT;
			}
			else
			{
				groupNum = (PlayerScore/Define.GROUP_RANGE)+1;
				if(groupNum > Define.MAX_GROUP_COUNT) groupNum = Define.MAX_GROUP_COUNT;
			}
			return groupNum;
		}
		
		public function Create_HashTable() : void
		{
			//1~11번의 HashTable 생성
			for(var mVar : int = 0; mVar<Define.MAX_GROUP_COUNT;mVar++)
			{
				_group[mVar] = new Hash_Value();
				_hashTable[mVar+1] = _group[mVar];
			}
				
			
		}
	}
}