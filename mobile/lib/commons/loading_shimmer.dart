import 'dart:async';
import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:flutter/material.dart';

class CommonShimmer extends StatefulWidget {
  const CommonShimmer({super.key});

  @override
  State<CommonShimmer> createState() => _CommonShimmerState();
}

class _CommonShimmerState extends State<CommonShimmer> {
  @override
  void initState() {
    Timer(const Duration(microseconds: 400), () { });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i <= 100; i++)
                Row(
                  children: [
                    AnimatedShimmer.round(
                      size: 60,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedShimmer(
                          height: 10,
                          width: 120,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          delayInMilliSeconds: Duration(milliseconds: i * 500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        AnimatedShimmer(
                          height: 10,
                          width: 180,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          delayInMilliSeconds: Duration(milliseconds: i * 500),
                        ),
                      ],
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
