import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void expectRight(Either<dynamic, dynamic> result, dynamic expected) {
  result.fold((left) {
    assert(false, "expected right, but was left");
  }, (right) {
    expect(right, expected);
  });
}

void expectLeft(Either<dynamic, dynamic> result, dynamic expected) {
  result.fold((left) {
    expect(left, expected);
  }, (right) {
    assert(false, "expected left, but was right");
  });
}
