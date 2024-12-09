import 'package:hive_flutter/hive_flutter.dart';

import 'key_adapter.dart';
import 'key_model.dart';

List<Box> boxes = [];
bool isInitialize = false;

Future<void> initializeHive() async {
  if (!isInitialize) {
    isInitialize = true;
    await Hive.initFlutter();
    Hive.registerAdapter<KeyModel>(KeyModelAdapter());
    //Hive.registerAdapter<ListModel>(ListAdapter());
    await openBoxes();
  }
}

Future<void> openBoxes() async {
  //Box ordMdl = await Hive.openBox<ListModel>(ListModel.boxName);
  /* int ord_idx = -1;
  if (boxes != null) {
    ord_idx = boxes.indexOf(ordMdl);
  }
  if (ord_idx >= 0) {
    boxes[ord_idx] = ordMdl;
  } else {
    boxes.add(ordMdl);
  } */
  Box keyMdl = await Hive.openBox<KeyModel>(KeyModel.boxName);
  int idx = -1;
  idx = boxes.indexOf(keyMdl);
  if (idx >= 0) {
    boxes[idx] = keyMdl;
  } else {
    boxes.add(keyMdl);
  }
}

void closeBoxes() {
  for (int i = 0; i < boxes.length; i++) {
    boxes[i].close();
  }
}
