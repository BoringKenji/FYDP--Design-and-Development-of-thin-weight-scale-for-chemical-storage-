import 'dart:convert';

Weight weightFromJson(String str) => Weight.fromJson(json.decode(str));

class Weight {
  int rfid;
  int timestamp;
  double weightInGram;
  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
        json['RFID_tags_id_array'], json['Timestamp'], json['Weight_in_gram']);
  }
  Weight(this.rfid, this.timestamp, this.weightInGram);
}
