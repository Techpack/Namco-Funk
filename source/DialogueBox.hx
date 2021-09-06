package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var portraitLeftPac:FlxSprite;
	var portraitLeftTaizo:FlxSprite;
	var portraitLeftTaizoSur:FlxSprite;
	var portraitLeftAnna:FlxSprite;
	var Boyf:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
				case 'world':
				FlxG.sound.playMusic(Paths.music('Lunchbox', 'shared'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xF0066ff);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('portraits/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

				case 'world':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('portraits/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);

				case 'dig dug':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('portraits/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);

				case 'rally':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('portraits/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);

				case 'annalynn':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('portraits/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('portraits/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		//if (Playstate.SONG.song.tolowercase() == 'world')

		portraitLeftPac = new FlxSprite(-20, 40);
		portraitLeftPac.frames = Paths.getSparrowAtlas('portraits/pac_port');
		portraitLeftPac.animation.addByPrefix('enter', 'PAC Portrait Enter', 24, false);
		portraitLeftPac.setGraphicSize(Std.int(portraitLeftPac.width * PlayState.daPixelZoom * 0.9));
		portraitLeftPac.updateHitbox();
		portraitLeftPac.scrollFactor.set();
		add(portraitLeftPac);
		portraitLeftPac.visible = false;

		portraitLeftTaizo = new FlxSprite(-20, 40);
		portraitLeftTaizo.frames = Paths.getSparrowAtlas('portraits/dig_stern');
		portraitLeftTaizo.animation.addByPrefix('enter', 'PAC Portrait Enter', 24, false);
		portraitLeftTaizo.setGraphicSize(Std.int(portraitLeftTaizo.width * PlayState.daPixelZoom * 0.9));
		portraitLeftTaizo.updateHitbox();
		portraitLeftTaizo.scrollFactor.set();
		add(portraitLeftTaizo);
		portraitLeftTaizo.visible = false;

		portraitLeftTaizoSur = new FlxSprite(-20, 40);
		portraitLeftTaizoSur.frames = Paths.getSparrowAtlas('portraits/dig_prise');
		portraitLeftTaizoSur.animation.addByPrefix('enter', 'PAC Portrait Enter', 24, false);
		portraitLeftTaizoSur.setGraphicSize(Std.int(portraitLeftTaizoSur.width * PlayState.daPixelZoom * 0.9));
		portraitLeftTaizoSur.updateHitbox();
		portraitLeftTaizoSur.scrollFactor.set();
		add(portraitLeftTaizoSur);
		portraitLeftTaizoSur.visible = false;

		portraitLeftAnna = new FlxSprite(-20, 40);
		portraitLeftAnna.frames = Paths.getSparrowAtlas('portraits/anna');
		portraitLeftAnna.animation.addByPrefix('enter', 'PAC Portrait Enter', 24, false);
		portraitLeftAnna.setGraphicSize(Std.int(portraitLeftAnna.width * PlayState.daPixelZoom * 0.9));
		portraitLeftAnna.updateHitbox();
		portraitLeftAnna.scrollFactor.set();
		add(portraitLeftAnna);
		portraitLeftAnna.visible = false;

		

		Boyf = new FlxSprite(0, 40);
		Boyf.frames = Paths.getSparrowAtlas('portraits/BF_Port', 'shared');
		Boyf.animation.addByPrefix('enter', 'BF Enter', 24, false);
		Boyf.updateHitbox();
		Boyf.scrollFactor.set();
		add(Boyf);
		Boyf.visible = false;



		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xF0088FF;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFFFFFFF;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				portraitLeftPac.visible  = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

				case 'PacMan':
				portraitRight.visible = false;
				portraitLeftPac.visible  = true;
				if (!portraitLeftPac.visible)
				{
					portraitLeftPac.visible = true;
					portraitLeftPac.animation.play('enter');
				}

				case 'Taizo':
				portraitRight.visible = false;
				portraitLeftTaizoSur.visible  = false;
				portraitLeftAnna.visible  = false;
				portraitLeftTaizo.visible  = true;
				if (!portraitLeftTaizo.visible)
				{
					portraitLeftTaizo.visible = true;
					portraitLeftTaizo.animation.play('enter');
				}


				case 'Anna':
				portraitRight.visible = false;
				portraitLeftTaizoSur.visible  = false;
				portraitLeftTaizo.visible  = false;
				portraitLeftAnna.visible  = true;
				if (!portraitLeftAnna.visible)
				{
					portraitLeftAnna.visible = true;
					portraitLeftAnna.animation.play('enter');
				}


				case 'Taizo_Sur':
				portraitRight.visible = false;
				portraitLeftTaizo.visible  = false;
				portraitLeftTaizoSur.visible  = true;
				if (!portraitLeftTaizoSur.visible)
				{
					portraitLeftTaizoSur.visible = true;
					portraitLeftTaizoSur.animation.play('enter');
				}

				
				
			case 'bf':
				portraitLeft.visible = false;
				portraitLeftPac.visible  = false;
				portraitLeftTaizo.visible  = false;
				portraitLeftTaizoSur.visible  = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
				
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
