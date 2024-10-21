abstract interface class IVoucherRepository {
  Future<dynamic> fetchVouchers({required String id});
}
