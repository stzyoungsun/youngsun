package
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	
	import PlayerClass;
	
	public class FileLoad
	{
		private var m_data : String;
		private var m_Player:Vector.<PlayerClass> = new Vector.<PlayerClass>;
		private var m_PlayerCnt : Number = 0;
		
		public  function GetData() : Vector.<PlayerClass>
		{
			return m_Player;
		}
		public function GetPlayerCount() : Number
		{
			return m_PlayerCnt;
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
				m_data = stream.readMultiByte(stream.bytesAvailable,"utf-8");
				m_data += '&';		//문자열에 마지막을 표시		
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
		public function DataSave() : void
		{
			//','으로 문자열 쪼개어 객체에 저장
			var cnt :Number= 1;
			var cntTemp : Number = 1;
			var ComaCnt : Number = 0;
			var strTemp : String = " ";
			
			while(m_data.charAt(cnt) != '&')
			{
				if(m_data.charAt(cnt) == ',' || ComaCnt == 5)
				{
					switch(ComaCnt)
					{
						case 0:
							m_Player[m_PlayerCnt] = new PlayerClass();
							if(strTemp.charAt(cntTemp) == ',')
								m_Player[m_PlayerCnt].ID = 0;
							else
								m_Player[m_PlayerCnt].ID =  parseInt(strTemp);
							break;
						case 1:
							if(strTemp == " ")
								m_Player[m_PlayerCnt].Name = " ";
							else
								m_Player[m_PlayerCnt].Name =  strTemp;
							break;
						case 2:
							if(strTemp.charAt(cntTemp) == ',')
								m_Player[m_PlayerCnt].Score = 0;
							else
								m_Player[m_PlayerCnt].Score =  parseInt(strTemp);
							break;
						case 3:
							if(strTemp.charAt(cntTemp) == ',')
								m_Player[m_PlayerCnt].WinCount = 0;
							else
								m_Player[m_PlayerCnt].WinCount =  parseInt(strTemp);
							break;
						default:
							if(strTemp.charAt(cntTemp) == ',')
								m_Player[m_PlayerCnt].LoseCount = 0;
							else
								m_Player[m_PlayerCnt].LoseCount =  parseInt(strTemp);
							m_PlayerCnt++;
							ComaCnt = -1;
							break;
					}
					if(ComaCnt != -1)
						cnt++;
					
					ComaCnt++;
					strTemp = " ";
				}
				else 
				{
					if(ComaCnt == 0 || ComaCnt == 2 || ComaCnt == 3 || ComaCnt == 4)	//ID, Score, Wincount, LoseCount 숫자만 와야 할 경우
					{
						if(ComaCnt == 4) ComaCnt++;
						while(m_data.charAt(cnt) != ',')
						{
							if(m_data.charAt(cnt) >= '0' && m_data.charAt(cnt) <= '9')
								strTemp += m_data.charAt(cnt);
							
							if(m_data.charAt(cnt++) == '\n')
							{
								
								break;
							}
						}
					}
					else
					{
						while(m_data.charAt(cnt) != ',')		//Name 부분
						{
							strTemp += m_data.charAt(cnt++);
						}
					}
				}
			}
		}
		
	}
}