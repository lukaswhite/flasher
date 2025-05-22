import 'package:flutter/material.dart';

class Flasher extends StatefulWidget {
  
  final Widget child;
  final Curve curve;  
  final Duration flashDuration;  
  final Duration duration;
  final Duration fadeOutDuration;
  final Duration fadeOutDelay;
  final bool fadeOutOnComplete;
  final int? repeat;
  final bool active;
  
  Flasher({
    super.key,
    this.curve = Curves.ease,
    this.flashDuration = const Duration(milliseconds: 150),
    this.duration = const Duration(milliseconds: 250),
    this.fadeOutDuration = const Duration(milliseconds: 350),
    this.fadeOutDelay = const Duration(milliseconds: 150,),
    this.fadeOutOnComplete = true,
    this.repeat,
    this.active = true,
    required this.child,
  });

  Flasher.fadeOutAfter({
    super.key,
    this.curve = Curves.ease,
    this.flashDuration = const Duration(milliseconds: 150),
    this.duration = const Duration(milliseconds: 250),
    this.fadeOutDuration = const Duration(milliseconds: 350),
    this.fadeOutDelay = const Duration(milliseconds: 150,),
    this.active = true,
    required this.repeat,
    required this.child,
  }): fadeOutOnComplete = true;

  @override
  State<Flasher> createState() => _FlasherState();
}

class _FlasherState extends State<Flasher> with TickerProviderStateMixin {
  
  late AnimationController _controller;
  late AnimationController _fadeOutController;
  late Duration totalDuration;  
  late Animation _animation;
  late Animation _fadeOutAnimation;
  int _counter = 0;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    
    totalDuration = widget.flashDuration + widget.duration;
    
    double flashPc = widget.flashDuration.inMilliseconds / totalDuration.inMilliseconds * 100;    
    double visiblePc = 100.0 - flashPc;    
    
    _controller = AnimationController(vsync: this, duration: totalDuration);
    _fadeOutController = AnimationController(vsync: this, duration: widget.fadeOutDuration,);

    final Animatable<double> tweenSequence = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(1.0),
          weight: visiblePc,          
        ), 
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 0)
              .chain(CurveTween(curve: widget.curve)),
          weight: flashPc,          
        ), 
      ],
    );

    _animation = tweenSequence.animate(_controller);
    _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0).animate(_fadeOutController);

    _controller.addListener(
      () {
        setState(() {
          opacity = _animation.value;        
        });        
      },
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _counter++;
        _controller.reverse();
        if (widget.repeat != null && _counter >= widget.repeat!) {
          _stop();
        }
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
      setState(() {});
    });

    _fadeOutController.addListener(
      () {
        setState(() {
          opacity = _fadeOutAnimation.value;        
        });        
      },
    );

    if (widget.active) {
      _controller.forward();
    }
  }

  _stop() {
    Future.delayed(widget.duration, () {
      _controller.stop();
      if (widget.fadeOutOnComplete) {
        Future.delayed(widget.fadeOutDelay).then(
          (_) => _fadeOutController.forward(),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity, 
      child: widget.child,
    );
  }
}