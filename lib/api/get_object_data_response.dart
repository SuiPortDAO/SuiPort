class GetObjectDataResponse {
  String? _jsonrpc;
  Result? _result;
  String? _id;

  GetObjectDataResponse({String? jsonrpc, Result? result, String? id}) {
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
  Result? get result => _result;
  set result(Result? result) => _result = result;
  String? get id => _id;
  set id(String? id) => _id = id;

  GetObjectDataResponse.fromJson(Map<String, dynamic> json) {
    _jsonrpc = json['jsonrpc'];
    _result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this._jsonrpc;
    if (this._result != null) {
      data['result'] = this._result!.toJson();
    }
    data['id'] = this._id;
    return data;
  }
}

class Result {
  String? _status;
  SuiObject? _details;

  Result({String? status, SuiObject? details}) {
    if (status != null) {
      this._status = status;
    }
    if (details != null) {
      this._details = details;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  SuiObject? get details => _details;
  set details(SuiObject? details) => _details = details;

  Result.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _details = json['details'] != null
        ? new SuiObject.fromJson(json['details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    if (this._details != null) {
      data['details'] = this._details!.toJson();
    }
    return data;
  }
}

class SuiObject {
  SuiData? _data;
  ObjectOwner? _owner;
  String? _previousTransaction;
  int? _storageRebate;
  Reference? _reference;

  SuiObject(
      {SuiData? data,
      ObjectOwner? owner,
      String? previousTransaction,
      int? storageRebate,
      Reference? reference}) {
    if (data != null) {
      this._data = data;
    }
    if (owner != null) {
      this._owner = owner;
    }
    if (previousTransaction != null) {
      this._previousTransaction = previousTransaction;
    }
    if (storageRebate != null) {
      this._storageRebate = storageRebate;
    }
    if (reference != null) {
      this._reference = reference;
    }
  }

  SuiData? get data => _data;
  set data(SuiData? data) => _data = data;
  ObjectOwner? get owner => _owner;
  set owner(ObjectOwner? owner) => _owner = owner;
  String? get previousTransaction => _previousTransaction;
  set previousTransaction(String? previousTransaction) =>
      _previousTransaction = previousTransaction;
  int? get storageRebate => _storageRebate;
  set storageRebate(int? storageRebate) => _storageRebate = storageRebate;
  Reference? get reference => _reference;
  set reference(Reference? reference) => _reference = reference;

  SuiObject.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new SuiData.fromJson(json['data']) : null;
    _owner =
        json['owner'] != null ? new ObjectOwner.fromJson(json['owner']) : null;
    _previousTransaction = json['previousTransaction'];
    _storageRebate = json['storageRebate'];
    _reference = json['reference'] != null
        ? new Reference.fromJson(json['reference'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    if (this._owner != null) {
      data['owner'] = this._owner!.toJson();
    }
    data['previousTransaction'] = this._previousTransaction;
    data['storageRebate'] = this._storageRebate;
    if (this._reference != null) {
      data['reference'] = this._reference!.toJson();
    }
    return data;
  }
}

class SuiData {
  String? _dataType;
  String? _type;
  bool? _hasPublicTransfer;
  ObjectContentFields? _fields;

  SuiData(
      {String? dataType,
      String? type,
      bool? hasPublicTransfer,
      ObjectContentFields? fields}) {
    if (dataType != null) {
      this._dataType = dataType;
    }
    if (type != null) {
      this._type = type;
    }
    if (hasPublicTransfer != null) {
      this._hasPublicTransfer = hasPublicTransfer;
    }
    if (fields != null) {
      this._fields = fields;
    }
  }

  String? get dataType => _dataType;
  set dataType(String? dataType) => _dataType = dataType;
  String? get type => _type;
  set type(String? type) => _type = type;
  bool? get hasPublicTransfer => _hasPublicTransfer;
  set hasPublicTransfer(bool? hasPublicTransfer) =>
      _hasPublicTransfer = hasPublicTransfer;
  ObjectContentFields? get fields => _fields;
  set fields(ObjectContentFields? fields) => _fields = fields;

  SuiData.fromJson(Map<String, dynamic> json) {
    _dataType = json['dataType'];
    _type = json['type'];
    _hasPublicTransfer = json['has_public_transfer'];
    _fields = json['fields'] != null
        ? new ObjectContentFields.fromJson(json['fields'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataType'] = this._dataType;
    data['type'] = this._type;
    data['has_public_transfer'] = this._hasPublicTransfer;
    if (this._fields != null) {
      data['fields'] = this._fields!.toJson();
    }
    return data;
  }
}

class ObjectContentFields {
  num? _balance;
  Id? _id;

  ObjectContentFields({int? balance, Id? id}) {
    if (balance != null) {
      this._balance = balance;
    }
    if (id != null) {
      this._id = id;
    }
  }

  num? get balance => _balance;
  set balance(num? balance) => _balance = balance;
  Id? get id => _id;
  set id(Id? id) => _id = id;

  ObjectContentFields.fromJson(Map<String, dynamic> json) {
    _balance = json['balance'];
    _id = json['id'] != null ? new Id.fromJson(json['id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this._balance;
    if (this._id != null) {
      data['id'] = this._id!.toJson();
    }
    return data;
  }
}

class Id {
  String? _id;

  Id({String? id}) {
    if (id != null) {
      this._id = id;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;

  Id.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    return data;
  }
}

class ObjectOwner {
  String? _addressOwner;

  ObjectOwner({String? addressOwner}) {
    if (addressOwner != null) {
      this._addressOwner = addressOwner;
    }
  }

  String? get addressOwner => _addressOwner;
  set addressOwner(String? addressOwner) => _addressOwner = addressOwner;

  ObjectOwner.fromJson(Map<String, dynamic> json) {
    _addressOwner = json['AddressOwner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AddressOwner'] = this._addressOwner;
    return data;
  }
}

class Reference {
  String? _objectId;
  int? _version;
  String? _digest;

  Reference({String? objectId, int? version, String? digest}) {
    if (objectId != null) {
      this._objectId = objectId;
    }
    if (version != null) {
      this._version = version;
    }
    if (digest != null) {
      this._digest = digest;
    }
  }

  String? get objectId => _objectId;
  set objectId(String? objectId) => _objectId = objectId;
  int? get version => _version;
  set version(int? version) => _version = version;
  String? get digest => _digest;
  set digest(String? digest) => _digest = digest;

  Reference.fromJson(Map<String, dynamic> json) {
    _objectId = json['objectId'];
    _version = json['version'];
    _digest = json['digest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this._objectId;
    data['version'] = this._version;
    data['digest'] = this._digest;
    return data;
  }
}
