package funkin.backend.system.framerate;

import openfl.text.TextFormat;
import openfl.display.Sprite;
import openfl.text.TextField;
import funkin.backend.system.macros.GitCommitMacro;
import lime.app.Application;

class CodenameBuildField extends TextField {
	public function new() {
		super();
		defaultTextFormat = Framerate.textFormat;
		autoSize = LEFT;
		multiline = wordWrap = false;
		text = 'Awesome CNE Fork v${Application.current.meta.get('version')} \nCommit ${GitCommitMacro.commitNumber} (${GitCommitMacro.commitHash})';
		selectable = false;
	}
}
