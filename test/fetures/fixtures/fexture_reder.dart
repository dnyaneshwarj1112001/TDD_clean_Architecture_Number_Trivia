import 'dart:io';

String fixture(String name) => File("test/fetures/fixtures/$name").readAsStringSync();
