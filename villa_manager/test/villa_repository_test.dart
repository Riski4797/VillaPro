import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:villa_manager/data/database/app_database.dart';
import 'package:villa_manager/data/repositories/villa_repository.dart';

void main() {
  late AppDatabase db;
  late VillaRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = VillaRepository(db);
  });

  tearDown(() => db.close());

  test('insert and update villa works without error', () async {
    final id = await repo.upsert(
      name: 'Villa A',
      location: 'Ubud',
      priceWeekday: 1000000,
    );

    expect(id, isNotEmpty);

    // Now update the villa
    final updatedId = await repo.upsert(
      id: id,
      name: 'Villa A Edited',
      location: 'Canggu',
      priceWeekday: 1200000,
      commissionType: 'fixed',
      commissionFixed: 100000,
    );

    expect(updatedId, id);

    final villa = await repo.getById(id);
    expect(villa, isNotNull);
    expect(villa!.name, 'Villa A Edited');
    expect(villa.location, 'Canggu');
    expect(villa.priceWeekday, 1200000);
    expect(villa.commissionType, 'fixed');
    expect(villa.commissionFixed, 100000);
  });
}
