import 'package:uuid/uuid.dart';

final Uuid _uuid = Uuid();

String newId() => _uuid.v4();
