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
		private var	_firstOutputTextBox:TextField = new TextField(); 		//"input You're Score" 출력 필드.
		private var _inputTextBox:TextField = new TextField(); 			//텍스트 입력 출력 필드
		private var _secondOutputTextBox:TextField = new TextField(); 	//결과 값 출력 필드
		
		private var _mainClass : MainClass = new MainClass();
		
		public function test()
		{
			_firstOutputTextBox.width = 100;
			_firstOutputTextBox.height = 100;
			addChild(_firstOutputTextBox);
			_firstOutputTextBox.text = "Input You're Score : ";
			
			_inputTextBox.type = TextFieldType.INPUT;
			_inputTextBox.background = true;
			addChild(_inputTextBox);
			_inputTextBox.border = true;
			
			_inputTextBox.width = 100;
			_inputTextBox.height = 20;
			_inputTextBox.x = 100;
			_inputTextBox.addEventListener(KeyboardEvent.KEY_DOWN,reportKeyDown);
		
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
				var Inputscore : String = _inputTextBox.text;
				Inputscore = checkScroe(Inputscore);
				MainClass.inputScroe = parseInt(Inputscore);
				if(MainClass.inputScroe <= 0) return;
				
				_mainClass.initalize();
				_mainClass.progress();
				_mainClass.render();
				
				addChild(_secondOutputTextBox);
				_secondOutputTextBox.width = 500;
				_secondOutputTextBox.height = 500;
				_secondOutputTextBox.y = 30;
				
				_secondOutputTextBox.text = MainClass.saveTextBox;
			}
		}
		/**
		 * 
		 * @param Score ',' '.' 이 포함 되어 있는 점수 값
		 * @return 순수 하게 숫자로만 이루어진 점수 값
		 * 
		 */		
		public function checkScroe(Score : String) : String		//사용자가 입력 한 점수에 있는 ',' '.'를 제거하기 위해서
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