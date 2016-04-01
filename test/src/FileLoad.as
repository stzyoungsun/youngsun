package
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	
	import PlayerClass;
	
	public class FileLoad
	{
		private var _savePlayerData : String;
		private var _vetorPlayer:Vector.<PlayerClass> = new Vector.<PlayerClass>;
		private var _countPlayer : Number = 0;
		
		public  function getData() : Vector.<PlayerClass>
		{
			return _vetorPlayer;
		}
		public function getPlayerCount() : Number
		{
			return _countPlayer;
		}
		/**
		 * 
		 * @param fileName	data 파일의 경로
		 * 파일의 데이터를 String에 저장
		 */		
		public function FileLoad(fileName : String)
		{ 
			//파일에 데이터를 string에 한번에 저장
			var file : File = new File();
			var stream : FileStream = new FileStream();
			
			file = File.applicationDirectory.resolvePath(fileName);
			
			if(file.exists)
			{
				stream.open(file,FileMode.READ);
				_savePlayerData = stream.readMultiByte(stream.bytesAvailable,"utf-8");
				_savePlayerData += '&';		//문자열에 마지막을 표시		
			}
			else
			{
				trace("File Open Error");
			}
			
			stream.close();
		}
		/**
		 *Text 파일에어 읽어온 string 값을 원하는 데이터로 사용하기 위한 조작 함수 
		 * ',' 로 구분 하여 ID, Name, Score, WinCount, LoseCount 부분으로 나눔
		 * Name을 제외 한 4 부분은 숫자 이외는 다른 값이 올 수 없음 -> 그 외 따른 예외처리
		 * Nmae은 아무 값이나 올 수 있음 (개행 문자 가능)
		 * # 개행 문자나, 공백 문자 등의 예외 처리
		 */		
		public function saveData() : void
		{
			//','으로 문자열 쪼개어 객체에 저장
			var cnt :Number= 1;
			var cntTemp : Number = 1;
			var countComa : Number = 0;
			var strTemp : String = " ";
			
			while(_savePlayerData.charAt(cnt) != '&')
			{
				if(_savePlayerData.charAt(cnt) == ',' || countComa == 5)
				{
					switch(countComa)
					{
						case 0:
							_vetorPlayer[_countPlayer] = new PlayerClass();
							if(strTemp.charAt(cntTemp) == ',')
								_vetorPlayer[_countPlayer].ID = 0;
							else
								_vetorPlayer[_countPlayer].ID =  parseInt(strTemp);
							break;
						case 1:
							if(strTemp == " ")
								_vetorPlayer[_countPlayer].Name = " ";
							else
								_vetorPlayer[_countPlayer].Name =  strTemp;
							break;
						case 2:
							if(strTemp.charAt(cntTemp) == ',')
								_vetorPlayer[_countPlayer].Score = 0;
							else
								_vetorPlayer[_countPlayer].Score =  parseInt(strTemp);
							break;
						case 3:
							if(strTemp.charAt(cntTemp) == ',')
								_vetorPlayer[_countPlayer].WinCount = 0;
							else
								_vetorPlayer[_countPlayer].WinCount =  parseInt(strTemp);
							break;
						default:
							if(strTemp.charAt(cntTemp) == ',')
								_vetorPlayer[_countPlayer].LoseCount = 0;
							else
								_vetorPlayer[_countPlayer].LoseCount =  parseInt(strTemp);
							_countPlayer++;
							countComa = -1;
							break;
					}
					if(countComa != -1)
						cnt++;
					
					countComa++;
					strTemp = " ";
				}
				else 
				{
					if(countComa == 0 || countComa == 2 || countComa == 3 || countComa == 4)	//ID, Score, Wincount, LoseCount 숫자만 와야 할 경우
					{
						if(countComa == 4) countComa++;
						while(_savePlayerData.charAt(cnt) != ',')
						{
							if(_savePlayerData.charAt(cnt) >= '0' && _savePlayerData.charAt(cnt) <= '9')
								strTemp += _savePlayerData.charAt(cnt);
							
							if(_savePlayerData.charAt(cnt++) == '\n')
							{
								
								break;
							}
						}
					}
					else
					{
						while(_savePlayerData.charAt(cnt) != ',')		//Name 부분
						{
							strTemp += _savePlayerData.charAt(cnt++);
						}
					}
				}
			}
		}
		
	}
}