// import 'dart:ffi';

// class Penjualan {
//   int _id;
//   String _name;
//   String _keterangan;
//   Float _jumlah;
//   String _tanggal;

//   Penjualan(this._name, this._keterangan, this._jumlah, this._tanggal);
//   Penjualan.fromMap(Map<String, dynamic> map) {
//     this._id = map['id'];
//     this._name = map['name'];
//     this._keterangan = map['keterangan'];
//     this._jumlah = map['jumlah'];
//     this._tanggal = map['tanggal'];
//   }

//   int get id => _id;
//   String get name => _name;
//   String get keterangan => _keterangan;
//   Float get jumlah => _jumlah;
//   String get tanggal => _tanggal;

//   set name(String value) {
//     _name = value;
//   }

//   set keterangan(String value) {
//     _keterangan = value;
//   }

//   set jumlah(Float value) {
//     _jumlah = value;
//   }

//   set tanggal(String value) {
//     _tanggal = value;
//   }

//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> map = Map<String, dynamic>();
//     map['id'] = this._id;
//     map['name'] = name;
//     map['keterangan'] = keterangan;
//     map['jumlah'] = jumlah;
//     map['tanggal'] = tanggal;
//   }
// }
