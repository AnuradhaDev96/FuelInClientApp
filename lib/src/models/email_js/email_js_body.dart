class EmailJsBody {
  String serviceId, templateId, userId;
  EmailJsContent templateParams;

  EmailJsBody({required this.serviceId, required this.templateId, required this.userId, required this.templateParams});

  Map<String, dynamic> toMap(){
    return {
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': templateParams.toMap(),
    };
  }
}

class EmailJsContent {
  String toName, toEmail, message, checkIn, checkOut, hotelName, totalCost, toBccEmail;

  EmailJsContent({
    required this.toName,
    required this.toEmail,
    required this.toBccEmail,
    required this.message,
    required this.checkIn,
    required this.checkOut,
    required this.hotelName,
    required this.totalCost,
  });

  Map<String, dynamic> toMap(){
    return {
      'toName': toName,
      'toEmail': toEmail,
      'toBccEmail': toBccEmail,
      'message': message,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'hotelName': hotelName,
      'totalCost': totalCost,
    };
  }
}