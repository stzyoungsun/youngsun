
package
{
	import flash.utils.Dictionary;
	
	import Define;
	
	import Hash_Value;
	
	import PlayerClass;
	
	public class HashTable
	{
		private var m_HashTable : Dictionary = new Dictionary();
		private var m_Group :Vector.<Hash_Value> = new Vector.<Hash_Value>;
		
		private var m_Player:Vector.<PlayerClass> = new Vector.<PlayerClass>;
		private var m_InputScore : Number;
		private var m_PlayerCount : Number;
		
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
			m_Player = Player;
			m_PlayerCount = PlyerCount;
			m_InputScore = InputScore;
		}
		
		public function Insert_Data(): void
		{
			//각각 Key 값에 맞는 그룹에 데이터 저장 (오름차순 저장)
			for(var mVar:int = 0; mVar<m_PlayerCount;mVar++)	
			{
				m_Player[mVar].HashKey = Hashing(m_Player[mVar].Score);
				m_Group[m_Player[mVar].HashKey-1].InsertSort(m_Player[mVar],m_InputScore);
			}
		}
		
		public function Matched() : void
		{
			//사용자가 입력 한 점수에 따라 총 5명의 플레이어 매칭
			
			var GroupType : int = -99;
			var InputDataKey : int = Hashing(m_InputScore);
			var HighTemp : int = 0;
			var LowTemp : int = 0;
			
			while(Static_MatchedCount < Define.MAX_MATCHED_COUNT)
			{
				if(HighTemp > 11) break;
				
				if(GroupType == -99)
				{
					GroupType = 0;
					if(m_HashTable[InputDataKey].GetInsertCount() == 0)		//Group내에 플레이어가 없을 경우
						continue;
					m_HashTable[InputDataKey].OutputPlayer();
				}
				else if(GroupType == 0 || GroupType == -1)
				{
					GroupType = 1;
					HighTemp++;
					
					if(InputDataKey+HighTemp > Define.MAX_GROUP_COUNT)
						continue;
					if(m_HashTable[InputDataKey+HighTemp].GetInsertCount() == 0)	//Group내에 플레이어가 없을 경우 
						continue;
					m_HashTable[InputDataKey+HighTemp].OutputPlayer();
				}
				else
				{
					GroupType = -1;
					LowTemp--;
					
					if(InputDataKey+LowTemp <= 0)
						continue;
					if(m_HashTable[InputDataKey+LowTemp].GetInsertCount() == 0)	//Group내에 플레이어가 없을 경우 
						continue;
					m_HashTable[InputDataKey+LowTemp].OutputPlayer();
					
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
			
			var GroupNum : int = 0;
			 
			if(PlayerScore <= 0)
				return -1;
			
			if(PlayerScore%Define.GROUP_RANGE == 0)
			{
				GroupNum = PlayerScore/Define.GROUP_RANGE;
				if(GroupNum > Define.MAX_GROUP_COUNT) GroupNum = Define.MAX_GROUP_COUNT;
			}
			else
			{
				GroupNum = (PlayerScore/Define.GROUP_RANGE)+1;
				if(GroupNum > Define.MAX_GROUP_COUNT) GroupNum = Define.MAX_GROUP_COUNT;
			}
			return GroupNum;
		}
		
		public function Create_HashTable() : void
		{
			//1~11번의 HashTable 생성
			for(var mVar : int = 0; mVar<Define.MAX_GROUP_COUNT;mVar++)
			{
				m_Group[mVar] = new Hash_Value();
				m_HashTable[mVar+1] = m_Group[mVar];
			}
				
			
		}
	}
}