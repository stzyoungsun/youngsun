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
		private var PlayerCnt : Number = 0;
		public  function GetData() : Vector.<PlayerClass>
		{
			return m_Player;
		}
		public function GetPlayerCount() : Number
		{
			return PlayerCnt;
		}
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
		}
		
		public function DataSave() : void
		{
			//','으로 문자열 쪼개어 객체에 저장
			
			var cnt :Number= 1;
			var cntTemp : Number = 1;
			var ComaCnt : Number = 0;
			
			
			var strTemp : String = " ";
			
			while(m_data.charAt(cnt-1) != '&')
			{
				if(m_data.charAt(cnt) == ',' || ComaCnt == 5)
				{
					switch(ComaCnt)
					{
						case 0:
							m_Player[PlayerCnt] = new PlayerClass();
							if(strTemp.charAt(cntTemp) == ',')
								m_Player[PlayerCnt].ID = 0;
							else
								m_Player[PlayerCnt].ID =  parseInt(strTemp);
							break;
						case 1:
							if(strTemp == " ")
								m_Player[PlayerCnt].Name = " ";
							else
								m_Player[PlayerCnt].Name =  strTemp;
							break;
						case 2:
					
							if(strTemp.charAt(cntTemp) == ',')
								m_Player[PlayerCnt].Score = 0;
							else
								m_Player[PlayerCnt].Score =  parseInt(strTemp);
							break;
						case 3:
						
							if(strTemp.charAt(cntTemp) == ',')
								m_Player[PlayerCnt].WinCount = 0;
							else
								m_Player[PlayerCnt].WinCount =  parseInt(strTemp);
							break;
						default:
							
							if(strTemp.charAt(cntTemp) == ',')
								m_Player[PlayerCnt].LoseCount = 0;
							else
								m_Player[PlayerCnt].LoseCount =  parseInt(strTemp);
							
							PlayerCnt++;
							ComaCnt = -1;
							
							break;
					}
					cnt++;
					ComaCnt++;
					strTemp = " ";
				}
				else 
				{
					if(ComaCnt == 4)	//마지막 LoseCount 부분에서 공백이나, 개행문자, 쓰레기값들을 걸러네기 위한 부분
					{
						while(m_data.charAt(cnt) == ' ')
						{
							strTemp += m_data.charAt(cnt++);
						}
						
						while(m_data.charAt(cnt) >= '0' && m_data.charAt(cnt) <= '9')
						{
							strTemp += m_data.charAt(cnt++);
						}
						
						ComaCnt++;
					}
					else
						strTemp += m_data.charAt(cnt++);
				}
			}
		}
	
	}
}