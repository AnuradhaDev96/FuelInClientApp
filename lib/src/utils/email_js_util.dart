import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../config/email_settings.dart';
import '../models/email_js/email_js_body.dart';
import '../models/reservation/reservation.dart';

class EmailJsUtil {
  static final _url = Uri.parse(EmailSettings.sendEmailJsUrl);

  static Future<int> sendPaymentConfirmedForGeneralReservation(Reservation reservation) async {
    EmailJsContent emailJsContent = EmailJsContent(toName: reservation.customerName!,
      toEmail: reservation.customerEmail!,
      toBccEmail: EmailSettings.bccEmail1,
      message: "We have successfully processed your payment for reservation in ",
      checkIn: DateFormat('yyyy-MM-dd').format(reservation.checkIn!),
      checkOut: DateFormat('yyyy-MM-dd').format(reservation.checkOut!),
      hotelName: reservation.hotelName,
      totalCost: reservation.totalCostOfReservation.toString(),
    );

    EmailJsBody emailJsBody = EmailJsBody(
        serviceId: EmailSettings.emailJsGmailSettingsId,
        userId: EmailSettings.emailJsPublicKey,
        templateId: EmailSettings.emailJsPaymentConfirmationTemplateId,
        templateParams: emailJsContent,
    );

    final response = await http.post(_url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(emailJsBody.toMap()));
    return response.statusCode;
  }
}