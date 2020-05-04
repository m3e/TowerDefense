package sounds {

	import flash.display.MovieClip;

	import flash.media.SoundChannel;
	import com.greensock.*;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.events.Event;
	import flash.net.SharedObject;
	import common.Commons;


	public class SoundManager extends MovieClip {

		private static var queue: LoaderMax;

		private static var sharedData: SharedObject = SharedObject.getLocal("LocalSave");
		public static var sfxVolume: Number = 1;
		public static var bgVolume: Number = 1;

		private static var soundsArray: Array = new Array;
		private static var sfxs: Array = new Array;
		private static var mergeLoopsArray: Array = new Array;

		private static var currentSong: Sound;
		private static var currentSongName: String;
		private static var currentSongSoundChannel: SoundChannel;

		private static var playlistArray: Array = new Array;
		private static var playlistIndex: int = 0;


		public function SoundManager() {
			sharedData = SharedObject.getLocal("LocalSave");
			sfxVolume = sharedData.data.fxVolume;
			if (isNaN(sfxVolume)) {
				sfxVolume = 1;
			}
			bgVolume = sharedData.data.bgVolume;
			if (isNaN(bgVolume)) {
				bgVolume = 1;
			}
			queue = Commons.queue;
			TweenPlugin.activate([VolumePlugin]);
			setSoundsArray();
			setPlaylistArray();
			addEventListener(Event.ENTER_FRAME, frameEvent);
		}
		private static function setSoundsArray(): void {
			//name,currentPlaying,limit,pan?,howmuch?
			soundsArray = [
				["default", 0, 29, false],
				["flame", 0, 8, true, .2],
				["zapsound", 0, 5, true, .4],
				["swordhit", 0, 3, true, .3],
				["arrowshot", 0, 5, true, .6],
				["cannonfire", 0, 6, true, .75],
				["buildtower", 0, 2, true, .1],
				["icehit", 0, 3, true, .4],
				["bulletshot", 0, 4, true, .2],
				["lavasplash", 0, 4, true, .4],
				["torchSfx", 0, 4, false],
				["darkshot", 0, 3, true, .4]
			];
		}
		//Setup
		private static function setPlaylistArray(): void {
			//Main Menu
			playlistArray.push(returnPlaylistArray("mainTheme", 3));
			playlistArray.push(returnPlaylistArray("battleMap", 6));
			playlistArray.push(returnPlaylistArray("victoryMusic", 2));
		}
		private static function returnPlaylistArray(playlistName: String, numSongs: int): Array {
			var songIndex: int = 2
			var playlist: Array = [playlistName, songIndex];


			for (var i: int = 0; i < numSongs; i++) {
				playlist.push(String(playlistName + i));
			}
			
			return playlist;
		}
		public static function setSfxVolume(SfxVolume: Number): void {
			sfxVolume = SfxVolume;
			changeSfxVolume();
		}
		public static function setMusicVolume(MusicVolume: Number): void {
			bgVolume = MusicVolume;

			if (currentSongName != null) {
				var s: SoundTransform = new SoundTransform(bgVolume);
				currentSongSoundChannel.soundTransform = s;
			}
		}
		private static function changeSfxVolume(): void {
			//Creating local copy in case sfx_complete occurs while changing volumes
			var copySfx: Array = common.Commons.newTheMap(sfxs);
			if (copySfx.length > 0) {
				var trans: SoundTransform = new SoundTransform(sfxVolume);
				for (var i: int = 0; i < copySfx.length; i++) {
					copySfx[i][0].soundTransform = trans;
				}
			}
			copySfx = [];
		}
		private static function getSoundsArray(fxName: String): Array {
			var a: Array = [];
			for (var i: int = 0; i < soundsArray.length; i++) {
				if (soundsArray[i][0] == fxName) {
					a = soundsArray[i];
					break;
				}
			}
			if (a == []) {
				//trace("getSoundsArray == null.  fxName: ",fxName);
				//trace("soundsArray: ",soundsArray);
			}
			return a;
		}
		public static function sfx(fxName: String, tweenIn: Boolean = false, looping: Boolean = false, mergeOverSeconds: Number = 0, soundParent: SoundChannel = null): SoundChannel {
			var a: Array = getSoundsArray(fxName);
			//section that controls available sound channels
			if (a.length > 0) {
				var numPlay: int = a[1];
				var limit: int = a[2];
			}
			//...
			if (a.length == 0 || (sfxs.length < 26 && numPlay < limit && (fxName != "default" && fxName != null))) {
				var song: Sound = queue.getContent(fxName);

				if (a.length > 0) {
					a[1]++;
				}
				var p: Number = 0;
				if (a[3] == true) {
					p = Math.random() * (2 * a[4]) - a[4];
				}
				var trans: SoundTransform = new SoundTransform(sfxVolume, p);
				var sound: SoundChannel = song.play(0, 0, trans);
				if (tweenIn == true) {
					TweenLite.from(sound, 1, {
						volume: 0
					});
				}

				var sArray: Array = [sound, fxName, tweenIn, looping, mergeOverSeconds, song, soundParent];
				sfxs.push(sArray);

				if (mergeOverSeconds > 0) {
					if (sArray[6] == null) {
						sArray[6] = sound;
					}
					mergeLoopsArray.push(sArray);
				}
				if (sound == null) {
					/*trace("sfx null: ",song,fxName);
					trace("numPlay, limit: ",numPlay,limit,"sfxs.length: ", sfxs.length);
					trace("sounds/trans: ",sound, trans);
					trace("mla: ",mergeLoopsArray);
					trace("loopsArray");
					trace("soundsarray:");*/
					for (var qp: int = 0; qp < soundsArray.length; qp++) {
						//trace(soundsArray[qp]);
					}
				}
				sound.addEventListener(Event.SOUND_COMPLETE, removeSfx);

			}
			return sound;
		}
		private function frameEvent(e: Event): void {
			for (var i: int = 0; i < mergeLoopsArray.length; i++) {
				if (mergeLoopsArray[i][0].position >= mergeLoopsArray[i][5].length - (mergeLoopsArray[i][4] * 1000)) {
					var fxName: String = sfxs[i][1];
					var tweenIn: Boolean = sfxs[i][2];
					var looping: Boolean = sfxs[i][3];
					var mergeOverSeconds: Number = sfxs[i][4];
					var soundParent: SoundChannel = sfxs[i][6];
					sfx(fxName, tweenIn, looping, mergeOverSeconds, soundParent);
					mergeLoopsArray.splice(i, 1);
					i--;
				}
			}
		}
		public static function stopSfx(targetSfx: SoundChannel, easeOut: Boolean = false): void {
			var soundsToStop: Array = new Array;
			for (var i: int = 0; i < sfxs.length; i++) {
				if (sfxs[i][0] == targetSfx) {
					soundsToStop.push(sfxs[i]);

					break;
				}
			}
			for (var k: int = 0; k < mergeLoopsArray.length; k++) {
				if (mergeLoopsArray[k][6] != null && mergeLoopsArray[k][6] == targetSfx) {
					soundsToStop.push(mergeLoopsArray[k]);
					mergeLoopsArray.splice(k, 1);
					k--;
				}
			}
			var newE: Event = new Event(Event.SOUND_COMPLETE);
			for (var p: int = 0; p < soundsToStop.length; p++) {
				soundsToStop[p][3] = false;
			}
			for (var q: int = 0; q < soundsToStop.length; q++) {
				TweenLite.to(soundsToStop[q][0], 1, {
					volume: 0,
					onComplete: tweenToEnd,
					onCompleteParams: [soundsToStop[q][0], null]
				});
				soundsToStop[q][0].dispatchEvent(newE);
			}
		}
		public static function removeSfx(e: Event): void {
			var eventSoundChannel: * = e.currentTarget;
			eventSoundChannel.removeEventListener(Event.SOUND_COMPLETE, removeSfx);
			for (var i: int = 0; i < sfxs.length; i++) {
				if (sfxs[i][0] == eventSoundChannel) {

					var fxName: String = sfxs[i][1];
					var tweenIn: Boolean = sfxs[i][2];
					var looping: Boolean = sfxs[i][3];
					var mergeOverSeconds: Number = sfxs[i][4];

					var soundParent: SoundChannel = sfxs[i][6];

					var a: Array = getSoundsArray(sfxs[i][1]);
					a[1]--;

					sfxs[i][5] = null;
					sfxs.splice(i, 1);
					if (looping == true && mergeOverSeconds == 0) {
						sfx(fxName, tweenIn, looping, mergeOverSeconds, soundParent);
					}


					break;
				}
			}
			eventSoundChannel = null;
		}
		private static function tweenToEnd(sc: SoundChannel, s: Sound): void {
			sc.stop();
			sc = null;
			s = null;
		}
		public static function playSong(songName: String): void {
			if (currentSongSoundChannel != null) {
				stopSong();
			}
			currentSongName = songName;
			//trace("LoaderStatus.READY: ", queue.getChildrenByStatus(LoaderStatus.READY))
			//trace("LoaderStatus.LOADING: ", queue.getChildrenByStatus(LoaderStatus.LOADING))
			//trace("LoaderStatus.PAUSED: ", queue.getChildrenByStatus(LoaderStatus.PAUSED))
			//trace("LoaderStatus.COMPLETED: ", queue.getChildrenByStatus(LoaderStatus.COMPLETED))
			//trace("LoaderStatus.FAILED: ", queue.getChildrenByStatus(LoaderStatus.FAILED))

			var song: Sound = queue.getContent(songName)
			var trans: SoundTransform = new SoundTransform(bgVolume);
			if (song != null) {
				var soundChannel: SoundChannel = song.play(0, 0, trans);
				currentSong = song;
				currentSongSoundChannel = soundChannel;
				TweenLite.from(soundChannel, 1.5, {
					volume: 0,
					ease: Linear.ease
				});
				soundChannel.addEventListener(Event.SOUND_COMPLETE, removeSongProperties);
			}
			else
			{
				playNextSongInPlaylist();
			}
		}
		private static function removeSongProperties(e: Event): void {
			currentSongSoundChannel.removeEventListener(Event.SOUND_COMPLETE, removeSongProperties);
			currentSong = null;
			currentSongName = null;
			currentSongSoundChannel = null;
			if (e != null) {
				playNextSongInPlaylist();
			}
		}
		private static function stopSong(): void {
			var tempSoundChannel: SoundChannel = currentSongSoundChannel;
			var tempSong: Sound = currentSong;
			TweenLite.to(tempSoundChannel, 1, {
				volume: 0,
				onComplete: tweenToEnd,
				onCompleteParams: [tempSoundChannel, tempSong]
			});
			removeSongProperties(Event(null));
		}
		//Control
		public static function setPlaylistIndex(pName: String): void {
			for (var i: int = 0; i < playlistArray.length; i++) {
				if (playlistArray[i][0] == pName) {
					playlistIndex = i;
					//trace("PL Name: ",playlistArray[i][0])
					//trace("PL Index: ", playlistIndex)
					break;
				}
			}
		}
		private static function setSongIndex(sName: String): void {
			for (var i: int = 0; i < playlistArray.length; i++) {
				for (var p: int = 0; p < playlistArray[i].length; p++) {
					if (playlistArray[i][p] == sName) {
						playlistIndex = i;
						playlistArray[i][1] = p
						break;
					}
				}
			}
		}
		public static function getCurrentPlaylistName(): String {
			var a: String = playlistArray[playlistIndex][0]

			return a
		}
		public static function playNextSongInPlaylist(): void {
			//trace(playlistArray[playlistIndex]);
			var pl: Array = playlistArray[playlistIndex]
			if ((pl[1] + 1) < pl.length) {
				pl[1]++;
			} else {
				pl[1] = 2;
			}
			playSong(pl[pl[1]]);
		}
	}
}