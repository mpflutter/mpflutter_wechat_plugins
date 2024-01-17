import 'package:flutter/material.dart';
import 'package:mpflutter_core/mpflutter_core.dart';
import 'package:mpflutter_wechat_api/mpflutter_wechat_api.dart';
import 'package:mpflutter_core/mpjs/mpjs.dart' as mpjs;

class MPFlutter_Wechat_VideoViewController
    extends MPFlutterPlatformViewController {
  VideoContext? _videoContext;

  _createVideoContext() {
    if (_videoContext == null) {
      if (pvid != null) {
        _videoContext = wx.createVideoContext(pvid!);
      }
    }
  }

  VideoContext? getVideoContext() {
    _createVideoContext();
    return _videoContext;
  }

  @override
  dispose() {
    _videoContext = null;
    return super.dispose();
  }
}

class MPFlutter_Wechat_VideoView extends StatelessWidget {
  final MPFlutter_Wechat_VideoViewController? controller;
  final String src;
  final int? duration;
  final bool? controls;
  final List<dynamic>? danmuList;
  final bool? danmuBtn;
  final bool? enableDanmu;
  final bool? autoplay;
  final bool? loop;
  final bool? muted;
  final double? initialTime;
  final bool? pageGesture;
  final int? direction;
  final bool? showProgress;
  final bool? showFullscreenBtn;
  final bool? showPlayBtn;
  final bool? showCenterPlayBtn;
  final bool? enableProgressGesture;
  final String? objectFit;
  final String? poster;
  final bool? showMuteBtn;
  final String? title;
  final String? playBtnPosition;
  final bool? enablePlayGesture;
  final bool? autoPauseIfNavigate;
  final bool? autoPauseIfOpenNative;
  final bool? vslideGesture;
  final bool? vslideGestureInFullscreen;
  final bool? showBottomProgress;
  final String? adUnitId;
  final String? posterForCrawler;
  final bool? showCastingButton;
  final int? pictureInPictureMode;
  final bool? pictureInPictureShowProgress;
  final bool? enableAutoRotation;
  final bool? showScreenLockButton;
  final bool? showSnapshotButton;
  final bool? showBackgroundPlaybackButton;
  final String? backgroundPoster;
  final String? referrerPolicy;
  final bool? isDrm;
  final bool? isLive;
  final String? provisionUrl;
  final String? certificateUrl;
  final String? licenseUrl;
  final int? preferredPeakBitRate;
  final Function(mpjs.JSObject)? onPlay;
  final Function(mpjs.JSObject)? onPause;
  final Function(mpjs.JSObject)? onEnded;
  final Function(mpjs.JSObject)? onTimeUpdate;
  final Function(mpjs.JSObject)? onFullscreenChange;
  final Function(mpjs.JSObject)? onWaiting;
  final Function(mpjs.JSObject)? onError;
  final Function(mpjs.JSObject)? onProgress;
  final Function(mpjs.JSObject)? onLoadedMetadata;
  final Function(mpjs.JSObject)? onControlsToggle;
  final Function(mpjs.JSObject)? onEnterPictureInPicture;
  final Function(mpjs.JSObject)? onLeavePictureInPicture;
  final Function(mpjs.JSObject)? onSeekComplete;
  final Function(mpjs.JSObject)? onCastingUserSelect;
  final Function(mpjs.JSObject)? onCastingStateChange;
  final Function(mpjs.JSObject)? onCastingInterrupt;

  MPFlutter_Wechat_VideoView({
    this.controller,
    required this.src,
    this.duration,
    this.controls,
    this.danmuList,
    this.danmuBtn,
    this.enableDanmu,
    this.autoplay,
    this.loop,
    this.muted,
    this.initialTime,
    this.pageGesture,
    this.direction,
    this.showProgress,
    this.showFullscreenBtn,
    this.showPlayBtn,
    this.showCenterPlayBtn,
    this.enableProgressGesture,
    this.objectFit,
    this.poster,
    this.showMuteBtn,
    this.title,
    this.playBtnPosition,
    this.enablePlayGesture,
    this.autoPauseIfNavigate,
    this.autoPauseIfOpenNative,
    this.vslideGesture,
    this.vslideGestureInFullscreen,
    this.showBottomProgress,
    this.adUnitId,
    this.posterForCrawler,
    this.showCastingButton,
    this.pictureInPictureMode,
    this.pictureInPictureShowProgress,
    this.enableAutoRotation,
    this.showScreenLockButton,
    this.showSnapshotButton,
    this.showBackgroundPlaybackButton,
    this.backgroundPoster,
    this.referrerPolicy,
    this.isDrm,
    this.isLive,
    this.provisionUrl,
    this.certificateUrl,
    this.licenseUrl,
    this.preferredPeakBitRate,
    this.onPlay,
    this.onPause,
    this.onEnded,
    this.onTimeUpdate,
    this.onFullscreenChange,
    this.onWaiting,
    this.onError,
    this.onProgress,
    this.onLoadedMetadata,
    this.onControlsToggle,
    this.onEnterPictureInPicture,
    this.onLeavePictureInPicture,
    this.onSeekComplete,
    this.onCastingUserSelect,
    this.onCastingStateChange,
    this.onCastingInterrupt,
  });

  @override
  Widget build(BuildContext context) {
    return MPFlutterPlatformView(
      controller: controller,
      viewClazz: "MPFlutter_Wechat_VideoView",
      viewProps: {
        "src": src,
        "duration": duration,
        "controls": controls ?? true,
        "danmu_list": danmuList,
        "danmu_btn": danmuBtn ?? false,
        "enable_danmu": enableDanmu ?? false,
        "autoplay": autoplay ?? false,
        "loop": loop ?? false,
        "muted": muted ?? false,
        "initial_time": initialTime ?? 0,
        "page_gesture": pageGesture ?? false,
        "direction": direction,
        "show_progress": showProgress ?? true,
        "show_fullscreen_btn": showFullscreenBtn ?? true,
        "show_play_btn": showPlayBtn ?? true,
        "show_center_play_btn": showCenterPlayBtn ?? true,
        "enable_progress_gesture": enableProgressGesture ?? true,
        "object_fit": objectFit ?? "contain",
        "poster": poster,
        "show_mute_btn": showMuteBtn ?? false,
        "title": title,
        "play_btn_position": playBtnPosition ?? "bottom",
        "enable_play_gesture": enablePlayGesture ?? false,
        "auto_pause_if_navigate": autoPauseIfNavigate ?? true,
        "auto_pause_if_open_native": autoPauseIfOpenNative ?? true,
        "vslide_gesture": vslideGesture ?? false,
        "vslide_gesture_in_fullscreen": vslideGestureInFullscreen ?? true,
        "show_bottom_progress": showBottomProgress ?? true,
        "ad_unit_id": adUnitId,
        "poster_for_crawler": posterForCrawler,
        "show_casting_button": showCastingButton ?? false,
        "picture_in_picture_mode": pictureInPictureMode,
        "picture_in_picture_show_progress":
            pictureInPictureShowProgress ?? false,
        "enable_auto_rotation": enableAutoRotation ?? false,
        "show_screen_lock_button": showScreenLockButton ?? false,
        "show_snapshot_button": showSnapshotButton ?? false,
        "show_background_playback_button":
            showBackgroundPlaybackButton ?? false,
        "background_poster": backgroundPoster,
        "referrer_policy": referrerPolicy ?? "no-referrer",
        "is_drm": isDrm ?? false,
        "is_live": isLive ?? false,
        "provision_url": provisionUrl,
        "certificate_url": certificateUrl,
        "license_url": licenseUrl,
        "preferred_peak_bit_rate": preferredPeakBitRate,
      },
      eventCallback: (originEvent, detail) {
        final event = originEvent.toLowerCase();
        if (event == "play") {
          onPlay?.call(detail);
        } else if (event == "pause") {
          onPause?.call(detail);
        } else if (event == "ended") {
          onEnded?.call(detail);
        } else if (event == "timeupdate") {
          onTimeUpdate?.call(detail);
        } else if (event == "fullscreenchange") {
          onFullscreenChange?.call(detail);
        } else if (event == "waiting") {
          onWaiting?.call(detail);
        } else if (event == "error") {
          onError?.call(detail);
        } else if (event == "progress") {
          onProgress?.call(detail);
        } else if (event == "loadedmetadata") {
          onLoadedMetadata?.call(detail);
        } else if (event == "controlstoggle") {
          onControlsToggle?.call(detail);
        } else if (event == "enterpictureinpicture") {
          onEnterPictureInPicture?.call(detail);
        } else if (event == "leavepictureinpicture") {
          onLeavePictureInPicture?.call(detail);
        } else if (event == "seekcomplete") {
          onSeekComplete?.call(detail);
        } else if (event == "castinguserselect") {
          onCastingUserSelect?.call(detail);
        } else if (event == "castingstatechange") {
          onCastingStateChange?.call(detail);
        } else if (event == "castinginterrupt") {
          onCastingInterrupt?.call(detail);
        }
      },
    );
  }
}
