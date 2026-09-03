import 'package:flutter_test/flutter_test.dart';

import 'package:oc_studio/src/core/constants.dart';
import 'package:oc_studio/src/core/utils.dart';

void main() {
  test('关系强度固定五档', () {
    expect(RelationStrength.all.length, 5);
    expect(RelationStrength.all.map((s) => s.label),
        ['亲密', '友好', '疏远', '敌对', '仇视']);
  });

  test('newId 返回非空 UUID', () {
    final a = newId();
    final b = newId();
    expect(a, isNotEmpty);
    expect(a, isNot(b));
  });
}
