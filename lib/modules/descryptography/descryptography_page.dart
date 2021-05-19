import 'package:cryptography_rsa/core/core.dart';
import 'package:cryptography_rsa/shared/widgets/tabs/tab_archive.dart';
import 'package:cryptography_rsa/shared/widgets/tabs/tab_text.dart';
import 'package:cryptography_rsa/shared/widgets/text_box.dart';
import 'package:cryptography_rsa/shared/widgets/button_widget.dart';
import 'package:cryptography_rsa/shared/widgets/field_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'descryptography_controller.dart';

class DescryptographyPage extends StatefulWidget {
  @override
  _DesryptographyPageState createState() => _DesryptographyPageState();
}

class _DesryptographyPageState extends State<DescryptographyPage>
    with SingleTickerProviderStateMixin {
  late DescryptographyController _controller;
  late TabController _tabController;
  late var _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _controller = DescryptographyController();
    _tabController = TabController(vsync: this, length: 2);
  }

  bool _validations() {
    if ((_formKey.currentState!.validate()) &&
        (_controller.textControllerMessage.text.isNotEmpty ||
            _controller.file != null) &&
        (_controller.validationPQ(p: _controller.keyP, q: _controller.keyQ))) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Form(
            key: _formKey,
            child: Container(
                margin: const EdgeInsets.only(top: 140),
                padding: const EdgeInsets.only(right: 80),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FieldKey(
                            label: 'P',
                            onChanged: (value) =>
                                _controller.textControllerP.text = value),
                        FieldKey(
                            label: 'Q',
                            onChanged: (value) =>
                                _controller.textControllerQ.text = value),
                        FieldKey(
                            label: 'E',
                            onChanged: (value) =>
                                _controller.textControllerE.text = value),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(controller: _tabController, tabs: [
                            Tab(
                                child: Text('TEXTO',
                                    style: AppTextStyles.roboto25Black)),
                            Tab(
                                child: Text('ARQUIVO',
                                    style: AppTextStyles.roboto25Black)),
                          ]),
                          Container(
                            height: 160,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                TabText(
                                  onChanged: (value) => _controller
                                      .textControllerMessage.text = value,
                                ),
                                TabArchive(
                                  path: _controller.path,
                                  onTap: () async {
                                    _controller.selectFile();
                                  },
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_validations())
                                _controller.decrypt();
                              else
                                _controller.buildMessageErro(context: context);
                            },
                            child: Container(
                                width: 240,
                                padding: const EdgeInsets.only(top: 8),
                                child: ButtonWidget.encryptDecrypt(
                                    label: 'DESCRIPTOGRAFAR')),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'DADOS DESCRIPTOGRAFADOS',
                                style: AppTextStyles.roboto25Black,
                              ),
                              InkWell(
                                onTap: () {
                                  if (_controller.dataDecrypted.isNotEmpty) {
                                    Clipboard.setData(ClipboardData(
                                        text: _controller.dataDecrypted));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('Dados copiados')));
                                  }
                                },
                                child: Text('Copiar',
                                    style: AppTextStyles.roboto20Black),
                              ),
                            ],
                          ),
                          TextBox(text: _controller.dataDecrypted)
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    InkWell(
                      onTap: _controller.saveFile,
                      child: Container(
                          width: 350,
                          child: Center(child: ButtonWidget.shared())),
                    ),
                  ],
                )),
          );
        });
  }
}
