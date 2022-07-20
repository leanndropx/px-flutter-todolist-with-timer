import 'dart:async';
import 'dart:js';
import 'package:flutter/material.dart';


class TimerModel {

  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  late Timer timer;
  late BuildContext context;

  bool get isTen => seconds >= 10;
  bool get isTenMinute => minutes >= 10;

  void ShowTimerDialog() {
    //Navigator.of(context).pop();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text(
              '00:${isTenMinute ? minutes : '0${minutes}'}:${isTen ? seconds : '0${seconds}'}',
              style:
              const TextStyle(fontSize: 40, color: Color(0xff00d7f3)),
            ),
          ),
          insetPadding: EdgeInsets.all(12),
          backgroundColor: Colors.black.withAlpha(800),
          actions: [
            TextButton(
              onPressed: QuitTimerDialogAndResetTimer,
              child: const Text(
                'Fechar',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),

            TextButton(
                onPressed: ResetTimer,
                child: const Text(
                  'Zerar',
                  style: TextStyle(color: Color(0xff00d7f3)),
                )),

            TextButton(
                onPressed: StopTimer,
                child: const Text(
                  'Parar',
                  style: TextStyle(color: Color(0xff00d7f3)),
                )),

            TextButton(
                onPressed: StartTimer,
                child: const Text(
                  'Iniciar',
                  style: TextStyle(color: Colors.greenAccent),
                ))
          ],
        ));
  }
  
  void StartTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (seconds >= 0) {
          if (seconds == 59) {
            minutes++;
            seconds = 0;
          }

          seconds++;
          Navigator.of(context).pop();
          ShowTimerDialog();
        } else {
          timer.cancel();
        }
      });
    }

  void ResetTimer(){
      timer.cancel();
      seconds = 0;
      minutes = 0;
      hours = 0;
      Navigator.pop(context);
      ShowTimerDialog();
    }

  void StopTimer(){
    timer.cancel();
  }

  void QuitTimerDialogAndResetTimer(){
      timer.cancel();
      Navigator.of(context).pop();
      seconds = 0;
      minutes = 0;
      hours = 0;
    }

}