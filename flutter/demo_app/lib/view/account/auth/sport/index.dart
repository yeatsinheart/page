import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/share/img.dart';

class AccountAuthSport extends StatelessWidget {
  final params;

  const AccountAuthSport({super.key, this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景图
          Positioned.fill(child: Img("assets/images/bg.jpg")),
          // 半透明遮罩
          Positioned.fill(child: Container(color: Colors.black.withValues(alpha: 0.2))),
          // 内容
    Positioned.fill(child:SingleChildScrollView(
            child: Column(
              children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                TextButton(onPressed: () { AppRoute.back(); },
                child: Padding(padding: EdgeInsetsGeometry.all(20),child: Icon(Icons.close,color: Colors.white,size: 27,),),),
              ]),
                const SizedBox(height: 80),
                // 顶部Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/jinritoutiao.png', height: 60),
                    const SizedBox(height: 8),
                    Column(children: [
                      const Text(
                        "天游国际",
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const Text("SKY GAMES", style: TextStyle(color: Colors.white, fontSize: 14, letterSpacing: 1)),
                    ],)
                  ],
                ),
                const SizedBox(height: 30),
                // 表单卡片
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 标题行
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                            ),
                            child: const Text("注册", style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text("登录", style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // 输入框
                      _buildTextField(hint: "请设置6-16位字母或数字账号", icon: Icons.person),
                      _buildTextField(hint: "请设置6-16位密码", icon: Icons.lock, obscure: true),
                      _buildTextField(hint: "请再次确认密码", icon: Icons.lock_outline, obscure: true),
                      _buildSelectorField(flag: "assets/vn_flag.png", text: "越南盾"),
                      _buildTextField(hint: "请填写手机号(选填)", prefix: "+84 "),
                      _buildTextField(hint: "请填写邀请码(选填)", icon: Icons.mail),
                      _buildCaptchaField(),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          child: const Text("注册", style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTextField({String? hint, IconData? icon, String? prefix, bool obscure = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 18, color: Colors.grey),
          if (prefix != null) Padding(padding: const EdgeInsets.only(right: 4), child: Text(prefix)),
          Expanded(
            child: TextField(
              obscureText: obscure,
              decoration: InputDecoration(
                border: InputBorder.none, hintText: hint,
    enabledBorder: InputBorder.none, // 普通状态
    focusedBorder: InputBorder.none, // 聚焦状态
    disabledBorder: InputBorder.none, // 禁用状态
     ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectorField({required String flag, required String text}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Img(flag, width: 20),
          const SizedBox(width: 8),
          Text(text),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildCaptchaField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(border: InputBorder.none, hintText: "请输入验证码",
                enabledBorder: InputBorder.none, // 普通状态
                focusedBorder: InputBorder.none, // 聚焦状态
                disabledBorder: InputBorder.none, // 禁用状态
              ),
            ),
          ),
          Img('assets/captcha.png', height: 30),
        ],
      ),
    );
  }
}
