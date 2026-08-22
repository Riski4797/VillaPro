import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:villa_manager/data/database/app_database.dart';
import 'package:villa_manager/data/repositories/booking_repository.dart';
import 'package:villa_manager/data/repositories/villa_repository.dart';
import 'package:villa_manager/features/booking/booking_form_screen.dart';
import 'package:villa_manager/features/booking/booking_list_screen.dart';
import 'package:villa_manager/features/booking/booking_providers.dart';
import 'package:villa_manager/features/villa/villa_providers.dart';

void main() {
  late AppDatabase db;
  late String bookingId;

  setUpAll(() => initializeDateFormatting('id_ID'));

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    final villaId = await VillaRepository(db).upsert(name: 'Villa Widget');
    bookingId = await BookingRepository(db).upsert(
      villaId: villaId,
      guestName: 'Tamu Widget Dengan Nama Panjang',
      guestContact: '628123456789012345',
      checkIn: DateTime(2026, 9, 1),
      checkOut: DateTime(2026, 9, 4),
      pricePerNightSnapshot: 1000000,
    );
  });

  tearDown(() async {
    await db.close();
  });

  Widget app(Widget child) => ProviderScope(
    overrides: [
      databaseProvider.overrideWithValue(db),
      todayProvider.overrideWith((_) => Stream.value(DateTime(2026, 8, 22))),
    ],
    child: MaterialApp(home: child),
  );

  testWidgets('booking edit loads existing data', (tester) async {
    await tester.pumpWidget(app(BookingFormScreen(bookingId: bookingId)));
    await tester.pumpAndSettle();

    expect(find.text('Edit Booking'), findsOneWidget);
    expect(find.text('Tamu Widget Dengan Nama Panjang'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump(const Duration(milliseconds: 1));
  });

  testWidgets('booking card does not overflow at 360 logical pixels', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(app(const BookingListScreen()));
    await tester.pumpAndSettle();

    expect(
      find.text('Tamu Widget Dengan Nama Panjang · 628123456789012345'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump(const Duration(milliseconds: 1));
  });
}
