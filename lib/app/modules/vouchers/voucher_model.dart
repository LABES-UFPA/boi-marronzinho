
import 'dart:convert';
import 'dart:typed_data';

class Voucher {
  final String id;
  final String usuarioId;
  final String nomeOficina;
  final String descricao;
  final String qrcode;

  Voucher({
    required this.id,
    required this.usuarioId,
    required this.nomeOficina,
    required this.descricao,
    required this.qrcode,
  });

  factory Voucher.fromMap(Map<String, dynamic> map) {
    return Voucher(
      id: map['id'],
      usuarioId: map['usuarioId'],
      nomeOficina: map['nomeOficina'],
      descricao: map['descricao'],
      qrcode: map['qrcode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuarioId': usuarioId,
      'nomeOficina': nomeOficina,
      'descricao': descricao,
      'qrcode': qrcode,
    };
  }

  Uint8List getQRCodeImage() {
    return base64Decode(qrcode);
  }
}