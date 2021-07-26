


import '../entity/k_entity.dart';

class KLineEntity extends KEntity {
  double open;
  double high;
  double low;
  double close;
  double vol;
  double amount;
  int count;
  String id;
  String detail_time;

  KLineEntity.fromJson(Map<String, dynamic> json) {
    open = (json['open'] as num)?.toDouble();
    high = (json['high'] as num)?.toDouble();
    low = (json['low'] as num)?.toDouble();
    close = (json['nowPrice'] as num)?.toDouble();
    vol = (json['volume'] as num)?.toDouble();
    amount = (json['amount'] as num)?.toDouble();
    count = (json['count'] as num)?.toInt();
    id = json['time'];
    detail_time = json["detail_time"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['open'] = this.open;
    data['close'] = this.close;
    data['high'] = this.high;
    data['low'] = this.low;
    data['vol'] = this.vol;
    data['amount'] = this.amount;
    data['count'] = this.count;
    data["detail_time"] = this.detail_time;
    return data;
  }

  @override
  String toString() {
    return 'MarketModel{open: $open, high: $high, low: $low, close: $close, vol: $vol, id: $id}';
  }
}
