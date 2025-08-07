import 'package:flutter/material.dart';
import 'package:flutter3/demo/widget/test-textfield.dart';
import 'package:flutter3/share/html-content.dart';
import 'package:flutter3/view/account/auth/demo/index.dart';
import 'package:flutter3/view/cashier/deposit/home/demo.dart';
import 'package:flutter3/view/cashier/home/demo.dart';

class MainDemo extends StatefulWidget {
  const MainDemo({super.key, params});

  @override
  _MainDemoState createState() => _MainDemoState();
}
// with AutomaticKeepAliveClientMixin 当你的 widget 在切换过程中（比如切换 Tab），默认会被销毁并重建，为了保留其状态（比如滚动位置、表单输入等），可以使用 AutomaticKeepAliveClientMixin。
// @override
// bool get wantKeepAlive => true;

class _MainDemoState extends State<MainDemo> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final String htmlContent = """
      <div style="padding: 16px; font-size: 18px;color:red;">
        <p>This is some HTML content.</p>
        <p>It can contain <strong>CKEditor</strong> output.</p>
        <p>More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...More lines...</p>
        <p>More lines...</p>
        <p>More lines...</p>
      </div>
      <h2>Congratulations on setting up ! 🎉</h2><p>You\'ve successfully created a  project. This powerful text editorwill enhance your application, enabling rich text editing capabilities thatare customizable and easy to use.</p><figure class="image">
        <img style="aspect-ratio:544/184;" src="https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png" width="544" height="184">
    </figure><h3>What\'s next?</h3><ol><li><strong>Integrate into your app</strong>: time to bring the editing intoyour application. Take the code you created and add to your application.</li><li><strong>Explore features:</strong> Experiment with different plugins andtoolbar options to discover what works best for your needs.</li><li><strong>Customize your editor:</strong> Tailor the editor\'sconfiguration to match your application\'s style and requirements. Oreven write your plugin!</li></ol><p>Keep experimenting, and don\'t hesitate to push the boundaries of what youcan achieve with CKEditor 5. Your feedback is invaluable to us as we striveto improve and evolve. Happy editing!</p><h3>Helpful resources</h3><ul><li>📝 <a href="https://portal.ckeditor.com/checkout?plan=free">Trial sign up</a>,</li><li>📕 <a href="https://ckeditor.com/docs/ckeditor5/latest/installation/index.html">Documentation</a>,</li><li>⭐️ <a href="https://github.com/ckeditor/ckeditor5">GitHub</a> (star us if you can!),</li><li>🏠 <a href="https://ckeditor.com">CKEditor Homepage</a>,</li><li>🧑‍💻 <a href="https://ckeditor.com/ckeditor-5/demo/">CKEditor 5 Demos</a>,</li></ul><h3>Need help?</h3><p>See this text, but the editor is not starting up? Check the browser\'sconsole for clues and guidance. It may be related to an incorrect licensekey if you use premium features or another feature-related requirement. Ifyou cannot make it work, file a GitHub issue, and we will help as soon aspossible!</p>
  """;
    return SingleChildScrollView(
      child: Column(
        children: [
          HtmlContent(html: htmlContent),
          SizedBox(height: 50),
          HtmlContent(html: htmlContent),
          SizedBox(height: 50),
          HtmlContent(html: htmlContent),
          SizedBox(height: 50),
          HtmlContent(html: htmlContent),
        ],
      ),
    );
  }
}
