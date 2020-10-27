import 'package:adventskalender/extensions/i_date_time_service_extensions.dart';
import 'package:adventskalender/services/data_time_service/fake_date_time_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Before 01/12, expect AdventStatus.before', () {
    expect(
      FakeDateTimeService(year: 2020, month: 11, day: 30).adventStatus,
      AdventStatus.before,
    );
  });

  test('After 01/12 but before 24/12, expect AdventStatus.during', () {
    expect(
      FakeDateTimeService(year: 2020, month: 12, day: 02).adventStatus,
      AdventStatus.during,
    );
    expect(
      FakeDateTimeService(year: 2020, month: 12, day: 24).adventStatus,
      AdventStatus.during,
    );
  });

  test('After 24/12, expect AdventStatus.after', () {
    expect(
      FakeDateTimeService(year: 2020, month: 11, day: 25).adventStatus,
      AdventStatus.before,
    );
  });
}
