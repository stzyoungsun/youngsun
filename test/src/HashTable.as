
package
{
	import flash.utils.Dictionary;
	import PlayerClass;
	import Hash_Value;
	
	public class HashTable
	{
		private var group1 : Hash_Value = new Hash_Value();
		private var group2 : Hash_Value = new Hash_Value();
		private var group3 : Hash_Value = new Hash_Value();
		private var group4 : Hash_Value = new Hash_Value();
		private var group5 : Hash_Value = new Hash_Value();
		private var group6 : Hash_Value = new Hash_Value();
		private var group7 : Hash_Value = new Hash_Value();
		private var group8 : Hash_Value = new Hash_Value();
		private var group9 : Hash_Value = new Hash_Value();
		private var group10 : Hash_Value = new Hash_Value();
		private var group11 : Hash_Value = new Hash_Value();
		
		private var m_Player:Vector.<PlayerClass> = new Vector.<PlayerClass>;
		private var m_MyScore : Number;
		private var m_PlayerCount : Number;
		
		private var m_HashTable : Dictionary = new Dictionary();
		
		public static var m_MatchedCount : Number = 0;
		public static var m_MatchedPlayer:Vector.<PlayerClass> = new Vector.<PlayerClass>;
		
		public function HashTable(Player :Vector.<PlayerClass>,PlyerCount : Number, MyScore : Number )
		{
			//객체에 저장 된 데이터를 이용한 생성자
			m_Player = Player;
			m_PlayerCount = PlyerCount;
			m_MyScore = MyScore;
		}
		
		public function Insert_Data(): void
		{
			//각각 Key 값에 맞는 그룹에 데이터 저장 (오름차순 저장)
			
			for(var mVar:int = 0; mVar<m_PlayerCount;mVar++)	
			{
				m_Player[mVar].HashKey = Hashing(m_Player[mVar].Score);
				switch(m_Player[mVar].HashKey)
				{
					case 1:
						group1.InsertSort(m_Player[mVar],m_MyScore);
						break;
					case 2:
						group2.InsertSort(m_Player[mVar],m_MyScore);
						break;
					case 3:
						group3.InsertSort(m_Player[mVar],m_MyScore);
						break;
					case 4:
						group4.InsertSort(m_Player[mVar],m_MyScore);
						break;
					case 5:
						group5.InsertSort(m_Player[mVar],m_MyScore);
						break;
					case 6:
						group6.InsertSort(m_Player[mVar],m_MyScore);
						break;
					case 7:
						group7.InsertSort(m_Player[mVar],m_MyScore);
						break;
					case 8:
						group8.InsertSort(m_Player[mVar],m_MyScore);
						break;
					case 9:
						group9.InsertSort(m_Player[mVar],m_MyScore);
						break;
					case 10:
						group10.InsertSort(m_Player[mVar],m_MyScore);
						break;
					case 11:
						group11.InsertSort(m_Player[mVar],m_MyScore);
						break;
				}	
			}
		}
		
		public function Matched() : void
		{
			//사용자가 입력 한 점수에 따라 총 5명의 플레이어 매칭
			
			var GroupType : int = -99;
			var MyKey : int = Hashing(m_MyScore);
			var HighTemp : int = 0;
			var LowTemp : int = 0;
			
			while(m_MatchedCount < 5)
			{
				if(HighTemp > 13) break;
				
				if(GroupType == -99)
				{
					GroupType = 0;
					m_HashTable[MyKey].OutputPlayer();
				}
				else if(GroupType == 0 || GroupType == -1)
				{
					GroupType = 1;
					HighTemp++;
					if(MyKey+HighTemp > 11)
						continue;
					m_HashTable[MyKey+HighTemp].OutputPlayer();
				}
				else
				{
					GroupType = -1;
					LowTemp--;
					if(MyKey+LowTemp <= 0)
						continue;
					m_HashTable[MyKey+LowTemp].OutputPlayer();
					
				}
			}
		}
		
		public function Hashing(PlayerScore : Number) : int
		{
			//플레이어 점수에 따라 Hash Key 설정
			var GroupNum : int = 0;
			 
			if(PlayerScore <= 0)
				return -1;
			
			if(PlayerScore%100000 == 0)
			{
				GroupNum = PlayerScore/100000;
				if(GroupNum > 11) GroupNum = 11;
			}
			else
			{
				GroupNum = (PlayerScore/100000)+1;
				if(GroupNum > 11) GroupNum = 11;
			}
			return GroupNum;
		}
		
		public function Create_HashTable() : void
		{
			//1~11번의 HashTable 생성
			m_HashTable[1] = group1;
			m_HashTable[2] = group2;
			m_HashTable[3] = group3;
			m_HashTable[4] = group4;
			m_HashTable[5] = group5;
			m_HashTable[6] = group6;
			m_HashTable[7] = group7;
			m_HashTable[8] = group8;
			m_HashTable[9] = group9;
			m_HashTable[10] = group10;
			m_HashTable[11] = group11;
		}
	}
}