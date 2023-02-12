import 'package:flutter/material.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final OnboardPageData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if(data.backgroundWidget != null) data.backgroundWidget!,
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              Flexible(
                flex: 20,
                child: Image.asset(data.image),
              ),
              const Spacer(),
              Text(
                data.title.toUpperCase(),
                style: TextStyle(
                  color: data.titleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
                maxLines: 1,
              ),
              const Spacer(),
              Text(
                data.subTitle.toLowerCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: data.subTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                maxLines: 2,
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class OnboardPageData {
  final String title;
  final String subTitle;
  final Color backgroundColor;
  final String image;
  final Color titleColor;
  final Color subTitleColor;
  final Widget? backgroundWidget;
  const OnboardPageData({
    required this.backgroundColor,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.subTitleColor,
    required this.titleColor,
    this.backgroundWidget,
  });
}
