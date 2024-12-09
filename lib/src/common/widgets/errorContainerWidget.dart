// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yslcrm/src/utils/ErrorMessageKeys.dart';

class ErrorContainerWidget extends StatelessWidget {
  final String errorMsg;
  final Function onRetry;
  const ErrorContainerWidget(
      {super.key, required this.errorMsg, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            (errorMsg.contains(ErrorMessageKeys.noInternet))
                ? Container(
                    width: MediaQuery.of(context).size.width * (0.7),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top +
                            MediaQuery.of(context).size.height * (0.05)),
                    height: MediaQuery.of(context).size.height * (0.4),
                    child: Lottie.asset("assets/animations/noInternet.json"))
                : SizedBox(height: MediaQuery.of(context).size.height * (0.2)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(errorMsg,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontSize: 16,
                        fontWeight: FontWeight.w300))),
            SizedBox(height: MediaQuery.of(context).size.height * (0.035)),
            ElevatedButton(
                onPressed: () {
                  onRetry.call();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primaryContainer),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                child: Text(
                  'Retry',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 21,
                      letterSpacing: 0.6),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * (0.15)),
          ],
        ));
  }
}
