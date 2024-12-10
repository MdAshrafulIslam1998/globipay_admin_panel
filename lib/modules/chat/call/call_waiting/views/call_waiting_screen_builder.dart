import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/services/navigator/app_navigator_service.dart';
import 'package:globipay_admin_panel/data/models/call_model.dart';
import 'package:globipay_admin_panel/modules/chat/call/call_waiting/controller/call_waiting_controller.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';
import 'package:permission_handler/permission_handler.dart';

class CallWaitingScreenBuilder extends StatefulWidget {

  final CallModel data;

  const CallWaitingScreenBuilder({Key? key, required this.data}) : super(key: key);

  @override
  State<CallWaitingScreenBuilder> createState() => _CallWaitingScreenBuilderState();
}

class _CallWaitingScreenBuilderState extends BaseViewState<CallWaitingScreenBuilder,CallWaitingController> {
  late AudioPlayer audioPlayer;
  bool isAudioPlaying = false;
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _initAudio();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _initAudio() async {
    try {
      // Load and play the ringtone
      await audioPlayer.play(AssetSource('sounds/ios_ringtone.mp3'));
      await audioPlayer.setReleaseMode(ReleaseMode.loop); // This will make it loop
      isAudioPlaying = true;
    } catch (e) {
      print('Error playing ringtone: $e');
    }
  }


  @override
  Widget body(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.black,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CupertinoColors.systemBlue.darkColor.withOpacity(0.8),
                CupertinoColors.black,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Enhanced Continuous Pulse Animation
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Multiple Pulse Layers
                          ...List.generate(3, (index) {
                            return PulseAnimationWidget(
                              delay: Duration(milliseconds: index * 400),
                              child: Container(
                                width: 180 + (index * 40.0),
                                height: 180 + (index * 40.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: CupertinoColors.white.withOpacity(0.15),
                                    width: 2,
                                  ),
                                ),
                              ),
                            );
                          }),
                          // Profile Image with Float Animation
                          FloatingAnimationWidget(
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: CupertinoColors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: CupertinoColors.systemBlue.withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                                image:  DecorationImage(
                                  image: NetworkImage(
                                   widget.data.callerImage,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Enhanced Name Animation
                      ShimmerText(
                        text: widget.data.callerName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Blinking Call Status
                      BlinkingText(
                        text: 'Incoming video call...',
                        style: TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                // Enhanced Call Actions
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCallButton(
                        icon: CupertinoIcons.phone_down_fill,
                        color: CupertinoColors.destructiveRed,
                        onPressed: () {
                          audioPlayer.stop();
                          Navigator.of(context).pop();
                        },
                        label: 'Decline',
                        isDecline: true,
                      ),
                      _buildCallButton(
                        icon: CupertinoIcons.video_camera_solid,
                        color: CupertinoColors.activeGreen,
                        onPressed: () async {
                          await audioPlayer.stop();
                          CallModel call = CallModel(
                            isJoin: true,
                            callerName: widget.data.callerName,
                            callerImage:
                            widget.data.callerImage,
                            channelName: widget.data.channelName,
                            videoToken: widget.data.videoToken,
                          );
                          await requestCameraAndMicPermissions(call);
                        },
                        label: 'Accept',
                        isAccept: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget _buildCallButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required String label,
    bool isAccept = false,
    bool isDecline = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: isAccept ? 800 : 600),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: BounceOnHoverButton(
                child: Container(
                  width: 70,
                  height: 70,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(35),
                    color: color,
                    onPressed: () async {
                      HapticFeedback.mediumImpact();
                      if (isAudioPlaying) {
                        await audioPlayer.stop();
                        isAudioPlaying = false;
                      }
                      onPressed();
                    },
                    child: Icon(
                      icon,
                      color: CupertinoColors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        FadeSlideText(
          text: label,
          style: const TextStyle(
            color: CupertinoColors.white,
            fontSize: 14,
          ),
          delay: isAccept ? 400 : 200,
        ),
      ],
    );
  }
}

// Continuous Pulse Animation Widget
class PulseAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const PulseAnimationWidget({
    Key? key,
    required this.child,
    required this.delay,
  }) : super(key: key);

  @override
  _PulseAnimationWidgetState createState() => _PulseAnimationWidgetState();
}

class _PulseAnimationWidgetState extends State<PulseAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(widget.delay, () {
      _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Opacity(
            opacity: 1.5 - _animation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

// Floating Animation Widget
class FloatingAnimationWidget extends StatefulWidget {
  final Widget child;

  const FloatingAnimationWidget({Key? key, required this.child}) : super(key: key);

  @override
  _FloatingAnimationWidgetState createState() => _FloatingAnimationWidgetState();
}

class _FloatingAnimationWidgetState extends State<FloatingAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: widget.child,
        );
      },
    );
  }
}

// Shimmer Text Animation
class ShimmerText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const ShimmerText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  @override
  _ShimmerTextState createState() => _ShimmerTextState();
}

class _ShimmerTextState extends State<ShimmerText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                CupertinoColors.white,
                CupertinoColors.white.withOpacity(0.5),
                CupertinoColors.white,
              ],
              stops: [0.0, _animation.value, 1.0],
              begin: const Alignment(-1.0, -0.5),
              end: const Alignment(1.0, 0.5),
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.style,
          ),
        );
      },
    );
  }
}

// Blinking Text Animation
class BlinkingText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const BlinkingText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  @override
  _BlinkingTextState createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Text(
        widget.text,
        style: widget.style,
      ),
    );
  }
}

// Bounce on Hover Button
class BounceOnHoverButton extends StatefulWidget {
  final Widget child;

  const BounceOnHoverButton({Key? key, required this.child}) : super(key: key);

  @override
  _BounceOnHoverButtonState createState() => _BounceOnHoverButtonState();
}

class _BounceOnHoverButtonState extends State<BounceOnHoverButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
        _controller.forward();
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

// Fade Slide Text Animation
class FadeSlideText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int delay;

  const FadeSlideText({
    Key? key,
    required this.text,
    required this.style,
    this.delay = 0,
  }) : super(key: key);

  @override
  _FadeSlideTextState createState() => _FadeSlideTextState();
}

class _FadeSlideTextState extends State<FadeSlideText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Text(
          widget.text,
          style: widget.style,
        ),
      ),
    );
  }
}

// Permission handling method implementation
Future<void> requestCameraAndMicPermissions(CallModel call) async {
  try {
    final cameraStatus = await Permission.camera.request();
    final micStatus = await Permission.microphone.request();

    if (cameraStatus.isGranted && micStatus.isGranted) {

      AppRoutes.pushAndReplaceNamed(
        RoutePath.videoCall,
        extra: call,
      );
    } else {
      // Show iOS-style permission denied alert with haptic feedback
      HapticFeedback.mediumImpact();
      showCupertinoDialog(
        context: AppNavigatorService.navigatorKey.currentState!.context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Permissions Required'),
          content: const Text(
            'Camera and microphone access is required for video calls. Please enable them in Settings.',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Settings'),
              onPressed: () {
                HapticFeedback.lightImpact();
                openAppSettings();
              },
            ),
          ],
        ),
      );
    }
  } catch (e) {
    print('Error requesting permissions: $e');
    // Show error dialog with haptic feedback
    HapticFeedback.heavyImpact();
    showCupertinoDialog(
      context: AppNavigatorService.navigatorKey.currentState!.context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: const Text(
          'Failed to request camera and microphone permissions. Please try again.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}