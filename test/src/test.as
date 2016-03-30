package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import MainClass;
	import HashTable;
	import PlayerClss;
	
	public class test extends Sprite
	{
		private var myTextBox:TextField = new TextField(); 
		private var myText:String = ""; 
		public function test()
		{
			var mMainclass : MainClass = new MainClass();
			mMainclass.initalize();
			mMainclass.Progress()
			mMainclass.Render();
			addChild(myTextBox); 
			Text_Out();	//윈도우 창에 출력
			myTextBox.width = 600;
			myTextBox.height = 800;
			myTextBox.text = myText; 
			
		}
		
		public function Text_Out() : void
		{
			//윈도우 창에 출력 하기 위한 함수
			
			var PreNum : int = 0;
			var GroupCount : int =0;
			
			var TempVector : Vector.<PlayerClass> = new Vector.<PlayerClass>;
			var Tempcnt : int = 0;
			
			for(var mVar : int =0;mVar < 5; mVar++)
			{
				if(PreNum == HashTable.m_MatchedPlayer[mVar].HashKey || mVar == 0 && mVar != 4)
				{
					GroupCount++;
					TempVector[Tempcnt++] = HashTable.m_MatchedPlayer[mVar];
				}
				else
				{
					myText+="> Matched Group: "+ TempVector[0].HashKey + "(" + GroupCount + " Plyaer)\n"
					//trace("> Matched Group: "+ TempVector[0].HashKey + "(" + GroupCount + " Plyaer)");
					for(var mVar2 : int =0;mVar2 < GroupCount; mVar2++)
					{
						myText+="User(id : " +TempVector[mVar2].ID + ", name: "+TempVector[mVar2].Name +", score: "+ TempVector[mVar2].Score + ",win : "+TempVector[mVar2].WinCount + ", lose: " + TempVector[mVar2].LoseCount +")\n"
						//trace("User(id : " +TempVector[mVar2].ID + ", name: "+TempVector[mVar2].Name +", score: "+ TempVector[mVar2].Score + ",win : "+TempVector[mVar2].WinCount + ", lose: " + TempVector[mVar2].LoseCount +")"); 
					}
					myText+="\n";
					GroupCount = 0;
					Tempcnt = 0;
					
					TempVector[Tempcnt++] = HashTable.m_MatchedPlayer[mVar];
					GroupCount++;
				}
				if(mVar == 4)
				{
					myText+="> Matched Group: "+ TempVector[0].HashKey + "(" + GroupCount + " Plyaer)\n"
					//trace("> Matched Group: "+ TempVector[0].HashKey + "(" + GroupCount + " Plyaer)");
					for(var mVar3 : int =0;mVar3 < GroupCount; mVar3++)
					{
						myText+="User(id : " +TempVector[mVar3].ID + ", name: "+TempVector[mVar3].Name +", score: "+ TempVector[mVar3].Score + ",win : "+TempVector[mVar3].WinCount + ", lose: " + TempVector[mVar3].LoseCount +")\n"
						//trace("User(id : " +TempVector[mVar3].ID + ", name: "+TempVector[mVar3].Name +", score: "+ TempVector[mVar3].Score + ",win : "+TempVector[mVar3].WinCount + ", lose: " + TempVector[mVar3].LoseCount +")"); 
					}
				}
				PreNum = HashTable.m_MatchedPlayer[mVar].HashKey;
			}
		}
	}
}