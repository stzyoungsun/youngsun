package
{
	import HashTable;
	
	public class Hash_Value
	{
		import PlayerClass;
		import HashTable;
		
		private var m_HashValue:Vector.<PlayerClass> = new Vector.<PlayerClass>;
		private var m_InsertCount : Number = 0;
		
		public function Hash_Value()
		{
			
		}
		public function GetInsertCount() : Number{
			return m_InsertCount;
		}
		public function GetGroup() : Vector.<PlayerClass>{
			return m_HashValue;
		}
		/**
		 * 
		 * @param Player		Player 객체
		 * @param InputScore	입력 한 Score
		 * 동일 한 Group의 플레이어들을 사용자와의 점수 차이를 이용하여 오름차순 정렬
		 */		
		public function InsertSort(Player : PlayerClass, InputScore : Number) : void 
		{
			//동일 한 그룹에 다른 값이 왔을 경우 사용자의 점수 차이를 이용하여 오름 차순으로 Vector에 삽입
			
			m_InsertCount++;
			Player.ScoreGap = Math.abs(Player.Score - InputScore);
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
			//Matching이 끝난 데이터를 MachedPlayer 배열에 저장
			for(var mVar : int = 0; mVar < m_InsertCount; mVar++)
			{
				if(HashTable.Static_MatchedCount == Define.MAX_MATCHED_COUNT) return;
				
				HashTable.Static_MatchedPlayer[HashTable.Static_MatchedCount++] = m_HashValue[mVar];
			}
				
		}
	}
}