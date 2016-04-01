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
		private var	TextBox_FirstOutput:TextField = new TextField(); 		//"input You're Score" 출력 필드.
		private var TextBox_Input:TextField = new TextField(); 			//텍스트 입력 출력 필드
		private var TextBox_SecondOutput:TextField = new TextField(); 	//결과 값 출력 필드
		
		private var mMainclass : MainClass = new MainClass();
		
		public function test()
		{
			TextBox_FirstOutput.width = 100;
			TextBox_FirstOutput.height = 100;
			addChild(TextBox_FirstOutput);
			TextBox_FirstOutput.text = "Input You're Score : ";
			
			TextBox_Input.type = TextFieldType.INPUT;
			TextBox_Input.background = true;
			addChild(TextBox_Input);
			TextBox_Input.border = true;
			
			TextBox_Input.width = 100;
			TextBox_Input.height = 20;
			TextBox_Input.x = 100;
			TextBox_Input.addEventListener(KeyboardEvent.KEY_DOWN,reportKeyDown);
		
		}
		/**
		 * 
		 * @param event Keyborad 
		 * Enter 텍스트 필드의 데이터를 메모리에 저장 하고 MainClass가 시작
		 */		
		public function reportKeyDown(event : KeyboardEvent) : void
		{
			if(event.keyCode == Keyboard.ENTER)		//Enter 키가 눌렸을 경우
			{
				var Inputscore : String = TextBox_Input.text;
				Inputscore = CheckScroe(Inputscore);
				MainClass.m_InputScroe = parseInt(Inputscore);
				if(MainClass.m_InputScroe <= 0) return;
				
				mMainclass.initalize();
				mMainclass.Progress();
				mMainclass.Render();
				
				addChild(TextBox_SecondOutput);
				TextBox_SecondOutput.width = 500;
				TextBox_SecondOutput.height = 500;
				TextBox_SecondOutput.y = 30;
				
				TextBox_SecondOutput.text = MainClass.OutText;
			}
		}
		/**
		 * 
		 * @param Score ',' '.' 이 포함 되어 있는 점수 값
		 * @return 순수 하게 숫자로만 이루어진 점수 값
		 * 
		 */		
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