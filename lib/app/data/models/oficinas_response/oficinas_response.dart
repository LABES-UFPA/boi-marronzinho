
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

class Oficina {
  final String id;
  final String nomeOficina;
  final String descricao;
  final Float precoBoicoin;
  final Float precoReal;
  final DateTime dataOficina;
  final Int limiteParticipantes;
  final String local;

  Oficina({
    required this.id,
    required this.nomeOficina,
    required this.descricao,
    required this.precoBoicoin,
    required this.precoReal,
    required this.dataOficina, 
    required this.limiteParticipantes,
    required this.local,
    
  });

  factory Oficina.fromMap(Map<String, dynamic> map) {
    return Oficina(
      id: map['id'],
      nomeOficina: map['nome'],
      descricao: map['descricao'],
      precoBoicoin: map['precoBoicoins'],
      precoReal: map['precoReal'],
      dataOficina: DateTime.parse(map['dataEvento']),
      limiteParticipantes: map['limiteParticipantes'],
      local: map['local'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeOficina': nomeOficina,
      'descricao': descricao,
      'precoBoicoin': precoBoicoin,
      'precoReal': precoReal,
      'dataOficina': dataOficina.toIso8601String(),  // Convertendo DateTime para string
      'limiteParticipantes': limiteParticipantes,
      'local': local,
    };
  }

  
}