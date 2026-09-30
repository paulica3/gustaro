import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gustaro/src/recent/recent_scans.dart';

void main() {
  late UserDatabase db;
  late DateTime now;
  RecentScansStore store({int limit = 50}) =>
      RecentScansStore(db, limit: limit, clock: () => now);

  setUp(() {
    db = UserDatabase(NativeDatabase.memory());
    now = DateTime.utc(2026, 10, 1, 12);
  });
  tearDown(() => db.close());

  void tick() => now = now.add(const Duration(minutes: 1));

  test('lists newest first', () async {
    final s = store();
    await s.record(1);
    tick();
    await s.record(2);
    expect((await s.list()).map((r) => r.vintageId), [2, 1]);
  });

  test(
    'viewing again moves an entry to the top without duplicating it',
    () async {
      final s = store();
      await s.record(1);
      tick();
      await s.record(2);
      tick();
      await s.record(1);
      final list = await s.list();
      expect(list.map((r) => r.vintageId), [1, 2]);
      expect(list.first.viewedAt.isAtSameMomentAs(now), isTrue);
    },
  );

  test('keeps only the newest [limit] entries', () async {
    final s = store(limit: 3);
    for (var id = 1; id <= 5; id++) {
      await s.record(id);
      tick();
    }
    expect((await s.list()).map((r) => r.vintageId), [5, 4, 3]);
  });

  test('clear removes everything', () async {
    final s = store();
    await s.record(1);
    await s.clear();
    expect(await s.list(), isEmpty);
  });
}
