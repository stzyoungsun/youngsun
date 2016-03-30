package
{
	import HashTable;
	
	public class Hash_Value
	{
		import PlayerClass;
		import HashTable;
		
		private var m_HashValue:Vector.<PlayerClass> = new Vector.<PlayerClass>;
		private var m_InsertCount : Number = 0;
		
		//private var m_MatchedPlayer:Vector.<PlayerClass> = new Vector.<PlayerClass>;
		//private var m_MatchedCount : int = 0;
		
		public function Hash_Value()
		{
			
		}
		
		public function GetGroup() : Vector.<PlayerClass>
		{
			return m_HashValue;
		}
		public function InsertSort(Player : PlayerClass, MyScore : Number) : void 
		{
			//객체에 데이터와 사용자가 입력한 점수의 차이에 따른 정렬 후 그룹에 저장
			
			m_InsertCount++;
			Player.ScoreGap = Math.abs(Player.Score - MyScore);
			var TempPlayer : PlayerClass;
			
			for(var mVar : int = m_InsertCount-1;mVar>=0;mVar--)
			{
				if(m_InsertCount == 1)
					m_HashValue[mVar] = Player;
				else{
					if(mVar == m_InsertCount-1)
					{
						m_HashValue[mVar] = Player;
					}
					else if(m_HashValue[mVar].ScoreGap > Player.ScoreGap)
					{
						TempPlayer  = m_HashValue[mVar];
						m_HashValue[mVar] = m_HashValue[mVar+1];
						m_HashValue[mVar+1] = TempPlayer;
					}
				}
			}
		}
		public function OutputPlayer() : void
		{
			//Matching이 끝난 데이터 출력
			for(var mVar : int = 0; mVar < m_InsertCount; mVar++)
			{
				if(HashTable.m_MatchedCount == 5) return;
				HashTable.m_MatchedPlayer[HashTable.m_MatchedCount++] = m_HashValue[mVar];
			}
				
		}
	}
}