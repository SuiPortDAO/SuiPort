class SuiObjectInfoReponse {
  String? _jsonrpc;
  List<SuiObjectInfo>? _result;
  String? _id;

  SuiObjectInfoReponse(
      {String? jsonrpc, List<SuiObjectInfo>? result, String? id}) {
    if (jsonrpc != null) {
      this._jsonrpc = jsonrpc;
    }
    if (result != null) {
      this._result = result;
    }
    if (id != null) {
      this._id = id;
    }
  }

  String? get jsonrpc => _jsonrpc;
  set jsonrpc(String? jsonrpc) => _jsonrpc = jsonrpc;
  List<SuiObjectInfo>? get result => _result;
  set result(List<SuiObjectInfo>? result) => _result = result;
  String? get id => _id;
  set id(String? id) => _id = id;

  SuiObjectInfoReponse.fromJson(Map<String, dynamic> json) {
    _jsonrpc = json['jsonrpc'];
    if (json['result'] != null) {
      _result = <SuiObjectInfo>[];
      json['result'].forEach((v) {
        _result!.add(new SuiObjectInfo.fromJson(v));
      });
    }
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this._jsonrpc;
    if (this._result != null) {
      data['result'] = this._result!.map((v) => v.toJson()).toList();
    }
    data['id'] = this._id;
    return data;
  }
}

class SuiObjectInfo {
  String? _objectId;
  int? _version;
  String? _digest;
  String? _type;
  Owner? _owner;
  String? _previousTransaction;

  SuiObjectInfo(
      {String? objectId,
      int? version,
      String? digest,
      String? type,
      Owner? owner,
      String? previousTransaction}) {
    if (objectId != null) {
      this._objectId = objectId;
    }
    if (version != null) {
      this._version = version;
    }
    if (digest != null) {
      this._digest = digest;
    }
    if (type != null) {
      this._type = type;
    }
    if (owner != null) {
      this._owner = owner;
    }
    if (previousTransaction != null) {
      this._previousTransaction = previousTransaction;
    }
  }

  String? get objectId => _objectId;
  set objectId(String? objectId) => _objectId = objectId;
  int? get version => _version;
  set version(int? version) => _version = version;
  String? get digest => _digest;
  set digest(String? digest) => _digest = digest;
  String? get type => _type;
  set type(String? type) => _type = type;
  Owner? get owner => _owner;
  set owner(Owner? owner) => _owner = owner;
  String? get previousTransaction => _previousTransaction;
  set previousTransaction(String? previousTransaction) =>
      _previousTransaction = previousTransaction;

  SuiObjectInfo.fromJson(Map<String, dynamic> json) {
    _objectId = json['objectId'];
    _version = json['version'];
    _digest = json['digest'];
    _type = json['type'];
    _owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    _previousTransaction = json['previousTransaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this._objectId;
    data['version'] = this._version;
    data['digest'] = this._digest;
    data['type'] = this._type;
    if (this._owner != null) {
      data['owner'] = this._owner!.toJson();
    }
    data['previousTransaction'] = this._previousTransaction;
    return data;
  }
}

class Owner {
  String? _addressOwner;

  Owner({String? addressOwner}) {
    if (addressOwner != null) {
      this._addressOwner = addressOwner;
    }
  }

  String? get addressOwner => _addressOwner;
  set addressOwner(String? addressOwner) => _addressOwner = addressOwner;

  Owner.fromJson(Map<String, dynamic> json) {
    _addressOwner = json['AddressOwner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AddressOwner'] = this._addressOwner;
    return data;
  }
}
