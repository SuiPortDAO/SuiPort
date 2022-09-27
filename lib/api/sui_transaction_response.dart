class SuiTransactionResponse {
  String? jsonrpc;
  SuiTransaction? result;
  String? id;

  SuiTransactionResponse({this.jsonrpc, this.result, this.id});

  SuiTransactionResponse.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    result = json['result'] != null
        ? new SuiTransaction.fromJson(json['result'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class SuiTransaction {
  CertifiedTransaction? certificate;
  TransactionEffects? effects;
  int? timestampMs;
  Null? parsedData;

  SuiTransaction(
      {this.certificate, this.effects, this.timestampMs, this.parsedData});

  SuiTransaction.fromJson(Map<String, dynamic> json) {
    certificate = json['certificate'] != null
        ? new CertifiedTransaction.fromJson(json['certificate'])
        : null;
    effects = json['effects'] != null
        ? new TransactionEffects.fromJson(json['effects'])
        : null;
    timestampMs = json['timestamp_ms'];
    parsedData = json['parsed_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.certificate != null) {
      data['certificate'] = this.certificate!.toJson();
    }
    if (this.effects != null) {
      data['effects'] = this.effects!.toJson();
    }
    data['timestamp_ms'] = this.timestampMs;
    data['parsed_data'] = this.parsedData;
    return data;
  }
}

class CertifiedTransaction {
  String? transactionDigest;
  Data? data;
  String? txSignature;
  AuthSignInfo? authSignInfo;

  CertifiedTransaction(
      {this.transactionDigest, this.data, this.txSignature, this.authSignInfo});

  CertifiedTransaction.fromJson(Map<String, dynamic> json) {
    transactionDigest = json['transactionDigest'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    txSignature = json['txSignature'];
    authSignInfo = json['authSignInfo'] != null
        ? new AuthSignInfo.fromJson(json['authSignInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionDigest'] = this.transactionDigest;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['txSignature'] = this.txSignature;
    if (this.authSignInfo != null) {
      data['authSignInfo'] = this.authSignInfo!.toJson();
    }
    return data;
  }
}

class Data {
  List<Transactions>? transactions;
  String? sender;
  GasPayment? gasPayment;
  int? gasBudget;

  Data({this.transactions, this.sender, this.gasPayment, this.gasBudget});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    sender = json['sender'];
    gasPayment = json['gasPayment'] != null
        ? new GasPayment.fromJson(json['gasPayment'])
        : null;
    gasBudget = json['gasBudget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    data['sender'] = this.sender;
    if (this.gasPayment != null) {
      data['gasPayment'] = this.gasPayment!.toJson();
    }
    data['gasBudget'] = this.gasBudget;
    return data;
  }
}

class Transactions {
  TransferSui? transferSui;

  Transactions({this.transferSui});

  Transactions.fromJson(Map<String, dynamic> json) {
    transferSui = json['TransferSui'] != null
        ? new TransferSui.fromJson(json['TransferSui'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transferSui != null) {
      data['TransferSui'] = this.transferSui!.toJson();
    }
    return data;
  }
}

class TransferSui {
  String? recipient;
  int? amount;

  TransferSui({this.recipient, this.amount});

  TransferSui.fromJson(Map<String, dynamic> json) {
    recipient = json['recipient'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipient'] = this.recipient;
    data['amount'] = this.amount;
    return data;
  }
}

class GasPayment {
  String? objectId;
  int? version;
  String? digest;

  GasPayment({this.objectId, this.version, this.digest});

  GasPayment.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    version = json['version'];
    digest = json['digest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this.objectId;
    data['version'] = this.version;
    data['digest'] = this.digest;
    return data;
  }
}

class AuthSignInfo {
  int? epoch;
  List<String>? signature;
  List<int>? signersMap;

  AuthSignInfo({this.epoch, this.signature, this.signersMap});

  AuthSignInfo.fromJson(Map<String, dynamic> json) {
    epoch = json['epoch'];
    signature = json['signature'].cast<String>();
    signersMap = json['signers_map'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['epoch'] = this.epoch;
    data['signature'] = this.signature;
    data['signers_map'] = this.signersMap;
    return data;
  }
}

class TransactionEffects {
  Status? status;
  GasUsed? gasUsed;
  String? transactionDigest;
  List<OwnedObjectRef>? created;
  List<OwnedObjectRef>? mutated;
  OwnedObjectRef? gasObject;
  List<Events>? events;
  List<String>? dependencies;

  TransactionEffects(
      {this.status,
      this.gasUsed,
      this.transactionDigest,
      this.created,
      this.mutated,
      this.gasObject,
      this.events,
      this.dependencies});

  TransactionEffects.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    gasUsed =
        json['gasUsed'] != null ? new GasUsed.fromJson(json['gasUsed']) : null;
    transactionDigest = json['transactionDigest'];
    if (json['created'] != null) {
      created = <OwnedObjectRef>[];
      json['created'].forEach((v) {
        created!.add(new OwnedObjectRef.fromJson(v));
      });
    }
    if (json['mutated'] != null) {
      mutated = <OwnedObjectRef>[];
      json['mutated'].forEach((v) {
        mutated!.add(new OwnedObjectRef.fromJson(v));
      });
    }
    gasObject = json['gasObject'] != null
        ? new OwnedObjectRef.fromJson(json['gasObject'])
        : null;
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
    dependencies = json['dependencies'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.gasUsed != null) {
      data['gasUsed'] = this.gasUsed!.toJson();
    }
    data['transactionDigest'] = this.transactionDigest;
    if (this.created != null) {
      data['created'] = this.created!.map((v) => v.toJson()).toList();
    }
    if (this.mutated != null) {
      data['mutated'] = this.mutated!.map((v) => v.toJson()).toList();
    }
    if (this.gasObject != null) {
      data['gasObject'] = this.gasObject!.toJson();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    data['dependencies'] = this.dependencies;
    return data;
  }
}

class Status {
  String? status;

  Status({this.status});

  Status.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}

class GasUsed {
  int? computationCost;
  int? storageCost;
  int? storageRebate;

  GasUsed({this.computationCost, this.storageCost, this.storageRebate});

  GasUsed.fromJson(Map<String, dynamic> json) {
    computationCost = json['computationCost'];
    storageCost = json['storageCost'];
    storageRebate = json['storageRebate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['computationCost'] = this.computationCost;
    data['storageCost'] = this.storageCost;
    data['storageRebate'] = this.storageRebate;
    return data;
  }
}

class OwnedObjectRef {
  Owner? owner;
  GasPayment? reference;

  OwnedObjectRef({this.owner, this.reference});

  OwnedObjectRef.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    reference = json['reference'] != null
        ? new GasPayment.fromJson(json['reference'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.reference != null) {
      data['reference'] = this.reference!.toJson();
    }
    return data;
  }
}

class Owner {
  String? addressOwner;

  Owner({this.addressOwner});

  Owner.fromJson(Map<String, dynamic> json) {
    addressOwner = json['AddressOwner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AddressOwner'] = this.addressOwner;
    return data;
  }
}

class Events {
  TransferObject? transferObject;

  Events({this.transferObject});

  Events.fromJson(Map<String, dynamic> json) {
    transferObject = json['transferObject'] != null
        ? new TransferObject.fromJson(json['transferObject'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transferObject != null) {
      data['transferObject'] = this.transferObject!.toJson();
    }
    return data;
  }
}

class TransferObject {
  String? packageId;
  String? transactionModule;
  String? sender;
  Owner? recipient;
  String? objectId;
  int? version;
  String? type;
  int? amount;

  TransferObject(
      {this.packageId,
      this.transactionModule,
      this.sender,
      this.recipient,
      this.objectId,
      this.version,
      this.type,
      this.amount});

  TransferObject.fromJson(Map<String, dynamic> json) {
    packageId = json['packageId'];
    transactionModule = json['transactionModule'];
    sender = json['sender'];
    recipient = json['recipient'] != null
        ? new Owner.fromJson(json['recipient'])
        : null;
    objectId = json['objectId'];
    version = json['version'];
    type = json['type'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packageId'] = this.packageId;
    data['transactionModule'] = this.transactionModule;
    data['sender'] = this.sender;
    if (this.recipient != null) {
      data['recipient'] = this.recipient!.toJson();
    }
    data['objectId'] = this.objectId;
    data['version'] = this.version;
    data['type'] = this.type;
    data['amount'] = this.amount;
    return data;
  }
}
