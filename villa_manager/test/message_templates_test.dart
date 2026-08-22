import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:villa_manager/core/utils/message_templates.dart';
import 'package:villa_manager/data/database/app_database.dart';

Villa _v() => Villa(
      id: '1',
      name: 'Villa Test',
      location: 'Ubud',
      ownerName: 'Pak Ketut',
      ownerContact: '62812345',
      ownerBank: 'BCA 1234567890',
      butlerName: 'Bli Wayan',
      butlerContact: '62899999',
      isButlerSameAsOwner: false,
      isActive: true,
      description: 'Villa nyaman',
      uniqueSellingPoints: '["Private pool","View sawah"]',
      amenities: '["WiFi","AC"]',
      houseRules: 'No party',
      priceWeekday: 1500000,
      priceWeekend: 1800000,
      priceHighSeason: 2500000,
      commissionPercent: 10,
      commissionType: 'percent',
      commissionFixed: 0,
      privateNotes: 'rahasia',
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    );

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  test('teaser excludes private notes', () {
    final t = villaShareText(_v(), ShareTemplate.teaser);
    expect(t.contains('Villa Test'), true);
    expect(t.contains('Ubud'), true);
    expect(t.contains('rahasia'), false);
  });

  test('detail has USP and amenities', () {
    final t = villaShareText(_v(), ShareTemplate.detail);
    expect(t.contains('Private pool'), true);
    expect(t.contains('WiFi'), true);
    expect(t.contains('No party'), true);
  });

  test('priceList is short', () {
    final t = villaShareText(_v(), ShareTemplate.priceList);
    expect(t.contains('Weekday'), true);
    expect(t.contains('High season'), true);
    expect(t.contains('Keunggulan'), false);
  });

  test('butlerNotificationText includes guest and dates', () {
    final b = Booking(
      id: 'b1',
      villaId: '1',
      guestName: 'Pak Handoko',
      guestContact: '628111222',
      checkIn: DateTime(2026, 9, 1),
      checkOut: DateTime(2026, 9, 4),
      pricePerNightSnapshot: 1500000,
      status: 'confirmed',
      notes: '',
      createdAt: DateTime(2026, 8, 1),
    );
    final msg = butlerNotificationText(villa: _v(), booking: b);
    expect(msg.contains('Bli Wayan'), true);
    expect(msg.contains('Pak Handoko'), true);
    expect(msg.contains('3 malam'), true);
  });
}
