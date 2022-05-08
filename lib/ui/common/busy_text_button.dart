import 'package:flutter/material.dart';

class BusyTextButton extends StatelessWidget {
  final bool isBusy;
  final Function? onPressed;
  final String label;

  const BusyTextButton(
      {Key? key, this.isBusy = false, this.onPressed, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (onPressed != null) {
          await onPressed!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Stack(
            children: [
              Align(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2!.apply(
                        color: isBusy ? Colors.red : Colors.white,
                      ),
                ),
              ),
              isBusy
                  ? const Positioned.fill(
                      child: Align(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.blue.shade500,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
      ),
    );
  }
}
