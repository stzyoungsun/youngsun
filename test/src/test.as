package
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	
	import HashTable;
	
	import MainClass;
	
	import PlayerClass;
	
	public class test extends Sprite
	{
		private var myTextBox_FirstOutput:TextField = new TextField(); 		//"input You're Score" 출력 필드
		private var myTextBox_Input:TextField = new TextField(); 			//텍스트 입력 출력 필드
		private var myTextBox_SecondOutput:TextField = new TextField(); 	//결과 값 출력 필드
		
		private var mMainclass : MainClass = new MainClass();
		private var myText:String = ""; 
		public function test()
		{
			
			myTextBox_FirstOutput.width = 100;
			myTextBox_FirstOutput.height = 100;
			addChild(myTextBox_FirstOutput);
			myTextBox_FirstOutput.text = "Input You're Score : ";
			
			myTextBox_Input.type = TextFieldType.INPUT;
			myTextBox_Input.background = true;
			addChild(myTextBox_Input); 
			
			myTextBox_Input.width = 300;
			myTextBox_Input.height = 50;
			myTextBox_Input.x = 100;
			myTextBox_Input.addEventListener(KeyboardEvent.KEY_DOWN,reportKeyDown);
		
		}
		public function reportKeyDown(event : KeyboardEvent) : void
		{
			if(event.keyCode == Keyboard.ENTER)
			{
				var Myscore : String = myTextBox_Input.text;
				MainClass.m_MyScroe = parseInt(Myscore);
				mMainclass.initalize();
				mMainclass.Progress();
				
				addChild(myTextBox_SecondOutput);
				myTextBox_SecondOutput.width = 300;
				myTextBox_SecondOutput.height = 500;
				myTextBox_SecondOutput.y = 30;
				Text_Out();
				myTextBox_SecondOutput.text = myText;
			}
				
		}
	
		public function Text_Out() : void
		{
			//윈도우 창에 출력 하기 위한 함수
		
			var PreNum : int = 0;
			var GroupCount : int =0;
			var TempVector : Vector.<PlayerClass> = new Vector.<PlayerClass>;
			var Tempcnt : int = 0;
			
			for(var mVar : int =0;mVar < HashTable.m_MatchedCount; mVar++)
			{
				if(PreNum == HashTable.m_MatchedPlayer[mVar].HashKey || mVar == 0 && mVar != HashTable.m_MatchedCount-1 && HashTable.m_MatchedCount != 1) 	//매칭된 플레이어의 숫자가 1명초과 5명 이하일 경우
				{
					GroupCount++;
					TempVector[Tempcnt++] = HashTable.m_MatchedPlayer[mVar];
				}
				else if(HashTable.m_MatchedCount == 1) 		//매칭된 플레이어의 숫자가 1명일 경우
				{
					GroupCount++;
					TempVector[Tempcnt++] = HashTable.m_MatchedPlayer[mVar];
				}
				else
				{
					myText+="> Matched Group: "+ TempVector[0].HashKey + "(" + GroupCount + " Plyaer)\n"
					for(var mVar2 : int =0;mVar2 < GroupCount; mVar2++)
					{
						myText+="User(id : " +TempVector[mVar2].ID + ", name: "+TempVector[mVar2].Name +", score: "+ TempVector[mVar2].Score + ",win : "+TempVector[mVar2].WinCount + ", lose: " + TempVector[mVar2].LoseCount +")\n"
					}
					myText+="\n";
					GroupCount = 0;
					Tempcnt = 0;
					
					TempVector[Tempcnt++] = HashTable.m_MatchedPlayer[mVar];
					GroupCount++;
				}
				if(mVar == HashTable.m_MatchedCount-1)
				{
					myText+="> Matched Group: "+ TempVector[0].HashKey + "(" + GroupCount + " Plyaer)\n"
					for(var mVar3 : int =0;mVar3 < GroupCount; mVar3++)
					{
						myText+="User(id : " +TempVector[mVar3].ID + ", name: "+TempVector[mVar3].Name +", score: "+ TempVector[mVar3].Score + ",win : "+TempVector[mVar3].WinCount + ", lose: " + TempVector[mVar3].LoseCount +")\n"
					}
				}
				PreNum = HashTable.m_MatchedPlayer[mVar].HashKey;
			}
		}
	}
}