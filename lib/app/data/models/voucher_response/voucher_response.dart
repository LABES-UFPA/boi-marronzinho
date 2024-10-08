import 'dart:convert';
import 'dart:typed_data';

class VoucherResponse {
  final String id;
  final String usuarioId;
  final String nomeOficina;
  final String descricao;
  final String qrcode;

  VoucherResponse({
    required this.id,
    required this.usuarioId,
    required this.nomeOficina,
    required this.descricao,
    required this.qrcode,
  });

  factory VoucherResponse.fromMap(Map<String, dynamic> map) {
    return VoucherResponse(
      id: map['id'],
      usuarioId: map['usuarioId'],
      nomeOficina: map['nomeOficina'],
      descricao: map['descricao'],
      qrcode: map['qrcode'] ?? '',
    );
  }

  Uint8List getQRCodeImage() {
    return base64Decode(qrcode);
  }
}