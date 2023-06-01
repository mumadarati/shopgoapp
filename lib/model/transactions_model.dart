class TransactionsModel {
  bool? status;
  List<Transactions>? transactions;

  TransactionsModel({this.status, this.transactions});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? transactionId;
  String? blogId;
  String? type;
  String? amount;
  String? balance;
  String? currency;
  String? details;
  CreatedBy? createdBy;
  String? deleted;
  String? date;
  CreatedBy? user;

  Transactions(
      {this.transactionId,
        this.blogId,
        this.type,
        this.amount,
        this.balance,
        this.currency,
        this.details,
        this.createdBy,
        this.deleted,
        this.date,
        this.user});

  Transactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    blogId = json['blog_id'];
    type = json['type'];
    amount = json['amount'];
    balance = json['balance'];
    currency = json['currency'];
    details = json['details'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    deleted = json['deleted'];
    date = json['date'];
    user = json['user'] != null ? CreatedBy.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    data['blog_id'] = blogId;
    data['type'] = type;
    data['amount'] = amount;
    data['balance'] = balance;
    data['currency'] = currency;
    data['details'] = details;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['deleted'] = deleted;
    data['date'] = date;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class CreatedBy {
  int? id;
  String? username;
  String? nicename;
  String? email;
  String? displayname;
  String? firstname;
  String? lastname;
  String? nickname;
  String? description;

  CreatedBy(
      {this.id,
        this.username,
        this.nicename,
        this.email,
        this.displayname,
        this.firstname,
        this.lastname,
        this.nickname,
        this.description});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nicename = json['nicename'];
    email = json['email'];
    displayname = json['displayname'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    nickname = json['nickname'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['nicename'] = nicename;
    data['email'] = email;
    data['displayname'] = displayname;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['nickname'] = nickname;
    data['description'] = description;
    return data;
  }
}
