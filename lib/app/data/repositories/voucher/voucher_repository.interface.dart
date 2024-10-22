abstract interface class IVoucherRepository {
  Future<dynamic> fetchVouchers({required String id});
  Future<dynamic> validaVouchers({required String codigoQRCode});
}
