class GstVerifyModel {
  bool? flag;
  String? message;
  Data? data;

  GstVerifyModel({this.flag, this.message, this.data});

  GstVerifyModel.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flag'] = flag;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? ntcrbs;
  String? adhrVFlag;
  String? lgnm;
  String? stj;
  String? dty;
  String? cxdt;
  String? gstin;
  List<String>? nba;
  String? ekycVFlag;
  String? cmpRt;
  String? rgdt;
  String? ctb;
  Pradr? pradr;
  String? sts;
  String? tradeNam;
  String? isFieldVisitConducted;
  String? adhrVdt;
  String? ctj;
  String? einvoiceStatus;
  String? lstupdt;
  List<String>? adadr;
  String? ctjCd;
  String? errorMsg;
  String? stjCd;

  Data(
      {this.ntcrbs,
      this.adhrVFlag,
      this.lgnm,
      this.stj,
      this.dty,
      this.cxdt,
      this.gstin,
      this.nba,
      this.ekycVFlag,
      this.cmpRt,
      this.rgdt,
      this.ctb,
      this.pradr,
      this.sts,
      this.tradeNam,
      this.isFieldVisitConducted,
      this.adhrVdt,
      this.ctj,
      this.einvoiceStatus,
      this.lstupdt,
      this.adadr,
      this.ctjCd,
      this.errorMsg,
      this.stjCd});

  Data.fromJson(Map<String, dynamic> json) {
    ntcrbs = json['ntcrbs'];
    adhrVFlag = json['adhrVFlag'];
    lgnm = json['lgnm'];
    stj = json['stj'];
    dty = json['dty'];
    cxdt = json['cxdt'];
    gstin = json['gstin'];
    nba = json['nba'].cast<String>();
    ekycVFlag = json['ekycVFlag'];
    cmpRt = json['cmpRt'];
    rgdt = json['rgdt'];
    ctb = json['ctb'];
    pradr = json['pradr'] != null ? Pradr.fromJson(json['pradr']) : null;
    sts = json['sts'];
    tradeNam = json['tradeNam'];
    isFieldVisitConducted = json['isFieldVisitConducted'];
    adhrVdt = json['adhrVdt'];
    ctj = json['ctj'];
    einvoiceStatus = json['einvoiceStatus'];
    lstupdt = json['lstupdt'];
    adadr = json['adadr']?.cast<String>();
    ctjCd = json['ctjCd'];
    errorMsg = json['errorMsg'];
    stjCd = json['stjCd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ntcrbs'] = ntcrbs;
    data['adhrVFlag'] = adhrVFlag;
    data['lgnm'] = lgnm;
    data['stj'] = stj;
    data['dty'] = dty;
    data['cxdt'] = cxdt;
    data['gstin'] = gstin;
    data['nba'] = nba;
    data['ekycVFlag'] = ekycVFlag;
    data['cmpRt'] = cmpRt;
    data['rgdt'] = rgdt;
    data['ctb'] = ctb;
    if (pradr != null) {
      data['pradr'] = pradr!.toJson();
    }
    data['sts'] = sts;
    data['tradeNam'] = tradeNam;
    data['isFieldVisitConducted'] = isFieldVisitConducted;
    data['adhrVdt'] = adhrVdt;
    data['ctj'] = ctj;
    data['einvoiceStatus'] = einvoiceStatus;
    data['lstupdt'] = lstupdt;
    if (adadr != null) {
      data['adadr'] = adadr;
    }
    data['ctjCd'] = ctjCd;
    data['errorMsg'] = errorMsg;
    data['stjCd'] = stjCd;
    return data;
  }
}

class Pradr {
  String? adr;
  Addr? addr;

  Pradr({this.adr, this.addr});

  Pradr.fromJson(Map<String, dynamic> json) {
    adr = json['adr'];
    addr = json['addr'] != null ? Addr.fromJson(json['addr']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adr'] = adr;
    if (addr != null) {
      data['addr'] = addr!.toJson();
    }
    return data;
  }
}

class Addr {
  String? flno;
  String? lg;
  String? loc;
  String? pncd;
  String? bnm;
  String? city;
  String? lt;
  String? stcd;
  String? bno;
  String? dst;
  String? st;

  Addr(
      {this.flno,
      this.lg,
      this.loc,
      this.pncd,
      this.bnm,
      this.city,
      this.lt,
      this.stcd,
      this.bno,
      this.dst,
      this.st});

  Addr.fromJson(Map<String, dynamic> json) {
    flno = json['flno'];
    lg = json['lg'];
    loc = json['loc'];
    pncd = json['pncd'];
    bnm = json['bnm'];
    city = json['city'];
    lt = json['lt'];
    stcd = json['stcd'];
    bno = json['bno'];
    dst = json['dst'];
    st = json['st'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flno'] = flno;
    data['lg'] = lg;
    data['loc'] = loc;
    data['pncd'] = pncd;
    data['bnm'] = bnm;
    data['city'] = city;
    data['lt'] = lt;
    data['stcd'] = stcd;
    data['bno'] = bno;
    data['dst'] = dst;
    data['st'] = st;
    return data;
  }
}
