package funkin.editors;

import funkin.options.type.*;
import funkin.options.OptionsScreen;
import funkin.options.TreeMenu;
import funkin.backend.utils.NativeAPI;

class DebugOptions extends TreeMenu {
	public static var mainOptions:Array<OptionCategory> = [
		{
			name: 'Debug Options >',
			desc: 'All the debug options',
			state: DebugOptionsScreen
		},
		{
			name: 'Windows Util Tester >',
			desc: 'Use this menu to test some WindowsUtil.hx functions.',
			state: WinUtilTester
		}
	];
	public override function create() {
		super.create();

		FlxG.camera.fade(0xFF000000, 0.5, true);

		var bg:FlxSprite = new FlxSprite(-80).loadAnimatedGraphic(Paths.image('menus/menuBGBlue'));
		// bg.scrollFactor.set();
		bg.scale.set(1.15, 1.15);
		bg.updateHitbox();
		bg.screenCenter();
		bg.scrollFactor.set();
		bg.antialiasing = true;
		add(bg);

		main = new OptionsScreen("Debug Tools", "Select a category to continue.", [for(o in mainOptions) new TextOption(o.name, o.desc, function() {
			if (o.substate != null) {
				persistentUpdate = false;
				persistentDraw = true;
				if (o.substate is MusicBeatSubstate) {
					openSubState(o.substate);
				} else {
					openSubState(Type.createInstance(o.substate, []));
				}
			} else {
				if (o.state is OptionsScreen) {
					optionsTree.add(o.state);
				} else {
					optionsTree.add(Type.createInstance(o.state, []));
				}
			}
		})]);
	}
}

class DebugOptionsScreen extends OptionsScreen {
	public override function new() {
		super("Debug Options", "Use this menu to change debug options.");
		#if windows
		add(new TextOption(
			"Show Console",
			"Select this to show the debug console, which contains log information about the game.",
			function() {
				NativeAPI.allocConsole();
			}));
		#end
		add(new Checkbox(
			"Editor SFXs",
			"If checked, will play sound effects when working on editors (ex: will play sfxs when checking checkboxes...)",
			"editorSFX"));
		add(new Checkbox(
			"Pretty Print",
			"If checked, the saved files from the editor will be formatted to be easily viewable (does not apply to xmls...)",
			"editorPrettyPrint"));
		add(new Checkbox(
			"Intensive Blur",
			"If checked, will use more intensive blur that may be laggier but look better.",
			"intensiveBlur"));
		add(new Checkbox(
			"Editor Autosaves",
			"If checked, this will autosave your files in the editor, with the settings listed below.",
			"charterAutoSaves"));
		add(new NumOption(
			"Autosaving Time",
			"This controls how often the editor will autosave your file (in seconds...)",
			60, 60*10, 30,
			"charterAutoSaveTime"
		));
		add(new NumOption(
			"Save Warning Time",
			"This controls how long the editor will warn you before it autosaves (in seconds..., 0 to disable)",
			0, 15, 1,
			"charterAutoSaveWarningTime"
		));
		add(new Checkbox(
			"Autosaves Folder",
			"If checked, this will autosave your file in a seperate folder with a time stamp instead of overriding your current file. (song/autosaves/)",
			"charterAutoSavesSeperateFolder"));
	}
}

class WinUtilTester extends OptionsScreen {
	var iconsArray:Array<Dynamic> = [
		WindowsUtil.MessageBoxIconType.MSG_NONE, 
		WindowsUtil.MessageBoxIconType.MSG_WARNING, 
		WindowsUtil.MessageBoxIconType.MSG_INFORMATION,
		WindowsUtil.MessageBoxIconType.MSG_QUESTION,
		WindowsUtil.MessageBoxIconType.MSG_ERROR
	];

	var buttonsArray:Array<Dynamic> = [
		WindowsUtil.MessageBoxButtonType.MSGBTN_ARI, 
		WindowsUtil.MessageBoxButtonType.MSGBTN_CTC, 
		WindowsUtil.MessageBoxButtonType.MSGBTN_HELP,
		WindowsUtil.MessageBoxButtonType.MSGBTN_OK,
		WindowsUtil.MessageBoxButtonType.MSGBTN_OKCANCEL,
		WindowsUtil.MessageBoxButtonType.MSGBTN_RETRYCANCEL,
		WindowsUtil.MessageBoxButtonType.MSGBTN_YESNO,
		WindowsUtil.MessageBoxButtonType.MSGBTN_YNC,
	];
	public override function new() {
		super("Windows Util tester", 'Test some WindowsUtil.hx functions here');
		add(new TextOption(
			"Message Box",
			"Tests Message Box, most things will be random everytime except title and window message",
			function() {
				WindowsUtil.ShowMessageBox("NO MORE INNOCENCE", "i have invaded your computer, muhehehe", iconsArray[FlxG.random.int(0, 4)], buttonsArray[FlxG.random.int(0, 7)]);
			}));
		add(new TextOption(
			"Window Bar Color",
			"Changes your window bar to a random color",
			function() {
				WindowsUtil.ChangeWindowBarColor(FlxG.random.int(0, 255), FlxG.random.int(0, 255), FlxG.random.int(0, 255));
			}));
		add(new TextOption(
			"Window Border Color",
			"Changes your window border to a random color",
			function() {
				WindowsUtil.ChangeWindowBorderColor(FlxG.random.int(0, 255), FlxG.random.int(0, 255), FlxG.random.int(0, 255));
			}));
		add(new TextOption(
			"Linked Window Color",
			"Changes both your window bar and border to a random color",
			function() {
				WindowsUtil.LinkedChangeWindowColors(FlxG.random.int(0, 255), FlxG.random.int(0, 255), FlxG.random.int(0, 255));
			}));
	}
}