package
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	
	import MainClass;
	
	public class test extends Sprite
	{
		private var myTextBox_FirstOutput:TextField = new TextField(); 		//"input You're Score" 출력 필드
		private var myTextBox_Input:TextField = new TextField(); 			//텍스트 입력 출력 필드
		private var myTextBox_SecondOutput:TextField = new TextField(); 	//결과 값 출력 필드
		
		private var mMainclass : MainClass = new MainClass();
		
		public function test()
		{
			myTextBox_FirstOutput.width = 100;
			myTextBox_FirstOutput.height = 100;
			addChild(myTextBox_FirstOutput);
			myTextBox_FirstOutput.text = "Input You're Score : ";
			
			myTextBox_Input.type = TextFieldType.INPUT;
			myTextBox_Input.background = true;
			addChild(myTextBox_Input);
			myTextBox_Input.border = true;
			
			myTextBox_Input.width = 100;
			myTextBox_Input.height = 20;
			myTextBox_Input.x = 100;
			myTextBox_Input.addEventListener(KeyboardEvent.KEY_DOWN,reportKeyDown);
		
		}
		public function reportKeyDown(event : KeyboardEvent) : void
		{
			if(event.keyCode == Keyboard.ENTER)		//Enter 키가 눌렸을 경우
			{
				var Myscore : String = myTextBox_Input.text;
				Myscore = CheckScroe(Myscore);
				MainClass.m_MyScroe = parseInt(Myscore);
				if(MainClass.m_MyScroe <= 0) return;
				
				mMainclass.initalize();
				mMainclass.Progress();
				mMainclass.Render();
				
				addChild(myTextBox_SecondOutput);
				myTextBox_SecondOutput.width = 500;
				myTextBox_SecondOutput.height = 500;
				myTextBox_SecondOutput.y = 30;
				
				myTextBox_SecondOutput.text = MainClass.myText;
			}
				
		}
		public function CheckScroe(Score : String) : String		//사용자가 입력 한 점수에 있는 ',' '.'를 제거하기 위해서
		{
			var strTemp : Array = Score.split(/,|\./);
			var ResultScore : String ="";
			for(var mVar : Number = 0; mVar < strTemp.length; mVar++)
			{
				ResultScore+=strTemp[mVar];
			}
			
			return ResultScore;
		}
		
	}
}