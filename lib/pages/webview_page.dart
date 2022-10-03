import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class WebViewXPage extends StatefulWidget {
  const WebViewXPage({
    Key? key,
  }) : super(key: key);

  @override
  WebViewXPageState createState() => WebViewXPageState();
}

class WebViewXPageState extends State<WebViewXPage> {
  late WebViewXController webviewController;
  Size get screenSize => MediaQuery.of(context).size;

  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: WebViewX(
          key: const ValueKey('webviewx'),
          initialContent: 'http://localhost:3001/',
          initialSourceType: SourceType.url,
          height: screenSize.height,
          width: screenSize.height,
          onWebViewCreated: (controller) => webviewController = controller,
          dartCallBacks: {
            DartCallback(
              name: '__SpMessageProxy',
              callBack: (msg) async {
                final decodeMsg = jsonDecode(msg);
                final messageId = decodeMsg['id'];
                const response =
                    '{"type": "has-permissions-request","result": true}';
                webviewController.callJsMethod(
                    '__SpMessageProxyCallback', [response, messageId]);
              },
            )
          },
          webSpecificParams: const WebSpecificParams(
            printDebugInfo: true,
          ),
          mobileSpecificParams: const MobileSpecificParams(
            androidEnableHybridComposition: true,
          ),
          navigationDelegate: (navigation) {
            debugPrint(navigation.content.sourceType.toString());
            return NavigationDecision.navigate;
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
