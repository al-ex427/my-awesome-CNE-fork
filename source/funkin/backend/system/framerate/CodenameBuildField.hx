package funkin.backend.system.framerate;

import openfl.text.TextFormat;
import openfl.display.Sprite;
import openfl.text.TextField;
import funkin.backend.system.macros.GitCommitMacro;

class CodenameBuildField extends TextField {
	public function new() {
		super();
		defaultTextFormat = Framerate.textFormat;
		autoSize = LEFT;
		multiline = wordWrap = false;
		text = "alex's " + 'CNE Fork (${Main.releaseCycle})\nCommit ${GitCommitMacro.commitNumber} (${GitCommitMacro.commitHash})'; //couldnt use ' in this
		selectable = false;
	}
}
