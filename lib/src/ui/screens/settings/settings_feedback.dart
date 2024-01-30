import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noteme/src/utils/form_validation.dart';
class SettingsFeedback extends StatefulWidget {
  const SettingsFeedback({super.key});

  @override
  State<SettingsFeedback> createState() => _SettingsFeedbackState();
}

class _SettingsFeedbackState extends State<SettingsFeedback> {
  final _key = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();

  @override
  void initState() {
    _feedbackController.addListener(() { setState(() {

    });});
    super.initState();
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _content(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          GoRouter.of(context).pop();
        },
        icon: const Icon(Icons.chevron_left),
      ),
      title: Text(AL
          .of(context)
          .settings_feedback),
    );
  }

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 30),
      child: Column(
        children: [
          _text(),
          _form(),
          const SizedBox(height: 50,),
          _button(),
        ],
      ),
    );
  }

  _text() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Text(AL.of(context).settings_feedback_msg)
        ],
      ),
    );
  }

  _form() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Form(
        key: _key,
          child: TextFormField(
            controller: _feedbackController,
        validator: (value)=>FormValidation.textValidation(context, value),
        maxLines: 5,
        decoration: const InputDecoration(

        ),
      )),
    );
  }


  _button() {
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 2,
        child: ElevatedButton(onPressed: _sendRequest, child: Text(AL.of(context).send)));
  }

  _sendRequest(){
      if(_key.currentState!=null){
        if(!_key.currentState!.validate()){
          return;
        }
        //TODO: send feedback
        print("send feedback");
      }
  }

}
