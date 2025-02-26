package funkin.menus;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import funkin.editors.ui.*;
import funkin.backend.FunkinText;

class BetaWarningState extends MusicBeatState {
	var titleAlphabet:Alphabet;
	var disclaimer:FunkinText;

	var transitioning:Bool = false;

	public override function create() {
		super.create();
				
		titleAlphabet = new Alphabet(0, 0, "WARNING", true);
		titleAlphabet.screenCenter(X);
		add(titleAlphabet);

		disclaimer = new FunkinText(16, titleAlphabet.y + titleAlphabet.height + 10, FlxG.width - 32, "", 32);
		disclaimer.alignment = CENTER;
		disclaimer.applyMarkup('This engine is still in a *${Main.releaseCycle}* state. That means *majority of the features* are either *buggy* or *non finished*. If you find any bugs, please report them to the "my-awesome-cne-fork" GitHub.\n\nPlease notice that *a lot of mods* may not be compatible with this fork as of script modification\n\nPress ENTER to continue',
			[
				new FlxTextFormatMarkerPair(new FlxTextFormat(0xFFFF4444), "*")
			]
		);
		add(disclaimer);

		var off = Std.int((FlxG.height - (disclaimer.y + disclaimer.height)) / 2);
		disclaimer.y += off;
		titleAlphabet.y += off;

	/*	FlxG.state.openSubState(new UIWarningSubstate("Warning!", 'This engine is still in a ${Main.releaseCycle} state.', [
			{
				label: 'I got it',
				color: 0x969533,
				onClick: function (_) { goToTitle(); }
			},
			{
				label: 'Yeah',
				color: 0x969533,
				onClick: function (_) { goToTitle(); }
			}
		])); */

		DiscordUtil.call("onMenuLoaded", ["Beta Warning"]);
	}

	public override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.ACCEPT && transitioning) {
			FlxG.camera.stopFX(); FlxG.camera.visible = false;
			goToTitle();
		}

		if (controls.ACCEPT && !transitioning) {
			transitioning = true;
			CoolUtil.playMenuSFX(CONFIRM);
			FlxG.camera.flash(FlxColor.WHITE, 1, function() {
				FlxG.camera.fade(FlxColor.BLACK, 2.5, false, goToTitle);
			});
		}
	}

	private function goToTitle() {
		MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
		FlxG.switchState(new TitleState());
	}
}