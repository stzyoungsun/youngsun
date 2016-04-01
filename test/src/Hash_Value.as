package
{
	import HashTable;
	
	public class Hash_Value
	{
		import PlayerClass;
		import HashTable;
		
		private var _vectorPlayer:Vector.<PlayerClass> = new Vector.<PlayerClass>;
		private var _insertCount : Number = 0;
		
		public function Hash_Value()
		{
			
		}
		public function getInsertCount() : Number{
			return _insertCount;
		}
		public function getGroup() : Vector.<PlayerClass>{
			return _vectorPlayer;
		}
		/**
		 * 
		 * @param Player		Player 객체
		 * @param InputScore	입력 한 Score
		 * 동일 한 Group의 플레이어들을 사용자와의 점수 차이를 이용하여 오름차순 정렬
		 */		
		public function insertSort(Player : PlayerClass, InputScore : Number) : void 
		{
			//동일 한 그룹에 다른 값이 왔을 경우 사용자의 점수 차이를 이용하여 오름 차순으로 Vector에 삽입
			
			_insertCount++;
			Player.ScoreGap = Math.abs(Player.Score - InputScore);
			var tempPlayer : PlayerClass;
			
			for(var mVar : int = _insertCount-1;mVar>=0;mVar--)
			{
				if(_insertCount == 1)
					_vectorPlayer[mVar] = Player;
				else{
					if(mVar == _insertCount-1)
					{
						_vectorPlayer[mVar] = Player;
					}
					else if(_vectorPlayer[mVar].ScoreGap > Player.ScoreGap)
					{
						tempPlayer  = _vectorPlayer[mVar];
						_vectorPlayer[mVar] = _vectorPlayer[mVar+1];
						_vectorPlayer[mVar+1] = tempPlayer;
					}
				}
			}
		}
		
		public function outputPlayer() : void
		{
			//Matching이 끝난 데이터를 MachedPlayer 배열에 저장
			for(var mVar : int = 0; mVar < _insertCount; mVar++)
			{
				if(HashTable.Static_MatchedCount == Define.MAX_MATCHED_COUNT) return;
				
				HashTable.Static_MatchedPlayer[HashTable.Static_MatchedCount++] = _vectorPlayer[mVar];
			}
				
		}
	}
}