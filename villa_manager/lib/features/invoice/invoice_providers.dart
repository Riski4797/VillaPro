import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/invoice_repository.dart';
import '../villa/villa_providers.dart';

final invoiceRepoProvider = Provider<InvoiceRepository>(
  (ref) => InvoiceRepository(ref.watch(databaseProvider)),
);

final invoiceSearchProvider = StateProvider<String>((_) => '');
final invoiceUnpaidOnlyProvider = StateProvider<bool>((_) => false);

final invoiceListProvider = StreamProvider<List<InvoiceWithTotal>>((ref) {
  final search = ref.watch(invoiceSearchProvider);
  final unpaidOnly = ref.watch(invoiceUnpaidOnlyProvider);
  return ref.watch(invoiceRepoProvider).watchAll(search: search).map((list) {
    if (!unpaidOnly) return list;
    return list.where((e) => e.invoice.status == 'unpaid').toList();
  });
});

final invoiceDetailProvider =
    FutureProvider.family<InvoiceDetail?, String>((ref, id) async {
  // re-fetch when repo changes via invalidate
  return ref.watch(invoiceRepoProvider).getDetail(id);
});

final bookingInvoiceIdsProvider = StreamProvider<Set<String>>(
  (ref) => ref.watch(invoiceRepoProvider).watchBookingIdsWithInvoice(),
);

final overdueUnpaidCountProvider = FutureProvider<int>(
  (ref) => ref.watch(invoiceRepoProvider).countOverdueUnpaid(),
);
