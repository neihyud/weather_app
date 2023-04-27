  DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(currentForeCast.dt! * 1000);

    var day = "${dateTime.day}".padLeft(2, '0');
    var month = "${dateTime.month}".padLeft(2, '0');

    var hour = "${dateTime.hour}".padLeft(2, '0');
    var minute = "${dateTime.minute}".padLeft(2, '0');
