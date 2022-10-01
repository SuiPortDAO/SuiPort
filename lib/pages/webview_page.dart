import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wallet/js/sdk/inject-wallet.dart';
import 'package:webviewx/webviewx.dart';

class WebViewXPage extends StatefulWidget {
  const WebViewXPage({
    Key? key,
  }) : super(key: key);

  @override
  _WebViewXPageState createState() => _WebViewXPageState();
}

class _WebViewXPageState extends State<WebViewXPage> {
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
          initialContent: r'''
            <button>测试权限</button>
            <script>
              
document.querySelector('button').addEventListener('click', () => {
    suiWallet.hasPermissions().then(console.log)
})
            </script>
          ''',
          initialSourceType: SourceType.html,
          height: screenSize.height,
          width: screenSize.height,
          onWebViewCreated: (controller) => webviewController = controller,
          jsContent: const {
            EmbeddedJsContent(
              js: injectWallet,
            ),
          },
          dartCallBacks: {
            DartCallback(
              name: '__SpMessageProxy',
              callBack: (msg) async {
                final decodeMsg = jsonDecode(msg);
                final messageId = decodeMsg['id'];
                final response = r'''{
                    "type": "has-permissions-request",
                    "result": true
                }''';
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
        ),
      ),
    );
  }
}
