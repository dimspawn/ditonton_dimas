import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class Connection {
  Future<SecurityContext> globalContext() async {
    final sslCert = await rootBundle.load('certificates/certificate.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  Future<Response> execUrl(String url) async {
    HttpClient client = HttpClient(context: await globalContext());
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    final response = await ioClient.get(Uri.parse(url));
    return response;
  }
}
