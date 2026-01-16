import 'package:get/get.dart';
import 'playing_videos_controller.dart';

class PlayingVideosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayingVideosController>(() => PlayingVideosController());
  }
}