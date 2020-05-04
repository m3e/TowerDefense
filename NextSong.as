package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import sounds.SoundManager;
	import common.Commons;


	public class NextSong extends MovieClip {


		public function NextSong() {

			addEventListener(Event.ADDED_TO_STAGE, added)
			// constructor code
		}
		private function added(e: Event): void {
			addEventListener(MouseEvent.CLICK, clicked)


		}
		private function clicked(e: Event): void {

			SoundManager.setPlaylistIndex("battleMap")
			try {
				SoundManager.playNextSongInPlaylist()
			} catch(e:Error) {
				throw new Error("shit failed");
				}

		}

	}

}