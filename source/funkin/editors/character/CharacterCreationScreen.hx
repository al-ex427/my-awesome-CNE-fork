package funkin.editors.character;

import flixel.text.FlxText.FlxTextFormat;
import flixel.text.FlxText.FlxTextFormatMarkerPair;
import flixel.group.FlxGroup;
import haxe.io.Bytes;
import funkin.backend.assets.ModsFolder;
import funkin.backend.utils.XMLUtil;
import funkin.backend.utils.CoolUtil;
import funkin.game.Character;


//..CREDITS TO Jamextreme140 FOR THIS SCRIPT..\\
//
class CharacterCreationScreen extends UISubstateWindow {
	private var onSave:(xml:Xml) -> Void = null;

	public var spriteTextBox:UITextBox;
	public var iconTextBox:UITextBox;
    public var iconSprite:FlxSprite;

    public var gameOverCharTextBox:UITextBox;
    public var antialiasingCheckbox:UICheckbox;

    public var flipXCheckbox:UICheckbox;

    public var iconColorWheel:UIColorwheel;

	public var positionXStepper:UINumericStepper;
	public var positionYStepper:UINumericStepper;

	public var cameraXStepper:UINumericStepper;
	public var cameraYStepper:UINumericStepper;

	public var scaleStepper:UINumericStepper;
	public var singTimeStepper:UINumericStepper;

	public var isPlayerCheckbox:UICheckbox;
	public var isGFCheckbox:UICheckbox;

	public var scriptExtension:UITextBox;
	public var isShortLived:UICheckbox;
	public var loadBefore:UICheckbox;


	public var saveButton:UIButton;
	public var closeButton:UIButton;

	var playerButton:UIButton;
    var opponentButton:UIButton;

	var chooseTypeGroup:FlxGroup = new FlxGroup();
	var mainPage:FlxGroup = new FlxGroup();
	
	


	public var pages:Array<FlxGroup> = [];
	public var curPage:Int = 0;

	public function new() {
		super();
	}

	public override function create() {
		winTitle = "Creating Character";
		winWidth = 1014;
		winHeight = 600;

		super.create();

		//Choose Type stuff
	    #if REGION
		playerButton = new UIButton(windowSpr.x + 320, windowSpr.y + 320, 'Player', function() {
		//	charType = 1;
			playerButton.canBeHovered = playerButton.selectable = false;
			opponentButton.canBeHovered = opponentButton.selectable = false;
			chooseTypeGroup.visible = false;
		//	initialize();
			mainPage.visible = true;
		}, 160);
	
		opponentButton = new UIButton(playerButton.x + playerButton.bWidth + 30, windowSpr.y + 320, 'Opponent/Extra', function() {
		//	charType = 0;
			playerButton.canBeHovered = playerButton.selectable = false;
			opponentButton.canBeHovered = opponentButton.selectable = false;
			chooseTypeGroup.visible = false;
			//initialize();
			mainPage.visible = true;
		}, 160);

		#end
		//Main Page Stuff
		#if REGION

		saveButton = new UIButton(windowSpr.x + windowSpr.bWidth - 20 - 125, windowSpr.y + windowSpr.bHeight - 16 - 32, "Save & Close", function() {
			//saveCharacterInfo();
			close();
		}, 125);
		mainPage.add(saveButton);

		closeButton = new UIButton(saveButton.x - 20, saveButton.y, "Close", function() {
			if (onSave != null) onSave(null);
			close();
		}, 125);
		closeButton.x -= closeButton.bWidth;
		closeButton.color = 0xFFFF0000;
		
		mainPage.add(closeButton);
		

		pages.push(cast add(chooseTypeGroup));
		pages.push(cast add(mainPage));
		#end
	}

}