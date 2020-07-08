import 'package:redeap/features/manage_news/domain/entities/news.dart';
import 'package:meta/meta.dart';

class NewsModel extends News {

  NewsModel({
    @required String newsCode,
    @required String reportCode,
    @required String radioCode,
    @required int hourDate,
    @required String unitCode,
    String message,
    @required int updateDate,
    @required String unitCreate
  }) : super( newsCode: newsCode, reportCode: reportCode, radioCode: radioCode, hourDate: hourDate, unitCode: unitCode, message: message, updateDate: updateDate, unitCreate: unitCreate );

  factory NewsModel.fromJson( Map<String, dynamic> json ) {
    return NewsModel(
        newsCode: json['newsCode'],
        reportCode: json['reportCode'],
        radioCode: json['radioCode'],
        hourDate: ( json['hourDate'] as num ).toInt(),
        unitCode: json['unitCode'],
        message: json['message'],
        updateDate: ( json['updateDate'] as num ).toInt(),
        unitCreate: json['unitCreate']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "newsCode" : newsCode,
      "reportCode" : reportCode,
      "radioCode" : radioCode,
      "hourDate" : hourDate,
      "unitCode" : unitCode,
      "message" : message,
      "updateDate" : updateDate,
      "unitCreate" : unitCreate
    };
  }
}