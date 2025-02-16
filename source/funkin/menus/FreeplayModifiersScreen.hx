package funkin.menus;

import flixel.tweens.FlxTween;
import funkin.options.type.*;

class FreeplayModifiersScreen extends MusicBeatSubstate {
	
	var curSelected:Int = 0;

	var modifiers:Array<String> = ["Modifier 1", "Modifier 2", "Modifer 3"];
	var alphabets:FlxTypedGroup<Alphabet>;
	
	public override function create() {
		super.create();
		var bg = new FlxSprite(0, 0).makeSolid(FlxG.width, FlxG.height, 0xFF000000);
		bg.updateHitbox();
		bg.scrollFactor.set();
		add(bg);

		alphabets = new FlxTypedGroup<Alphabet>();
		add(alphabets);

		for(i=>modifier in modifiers) {
			var modifyer = new Alphabet(5, 25 + (i * 230	), modifiers[i], true);
			alphabets.add(modifyer);

		}
		
		bg.alpha = 0;
		FlxTween.tween(bg, {alpha: 0.5}, 0.25, {ease: FlxEase.cubeOut});


	}
	public override function update(elapsed:Float) {
		super.update(elapsed);
		if (controls.BACK)
			close();

	}

}