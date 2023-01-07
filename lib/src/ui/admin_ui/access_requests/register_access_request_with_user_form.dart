import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matara_division_system/src/models/change_notifiers/access_requests_page_view_notifier.dart';

import '../../../config/app_colors.dart';
import '../../../config/language_settings.dart';
import '../../../models/authentication/request_access_model.dart';
import '../../../services/auth_service.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/message_utils.dart';

class RegisterAccessRequestWithUserForm extends StatelessWidget {
  RegisterAccessRequestWithUserForm({Key? key, required this.selectedRequestAccess,}) : super(key: key);
  // final String suggestedPassword;
  // final AccessRequestsPageViewNotifier _accessRequestsPageViewNotifier = GetIt.I<AccessRequestsPageViewNotifier>();
  final RequestAccessModel selectedRequestAccess;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController(text: CommonUtils.generatePasswordForAuth());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Card(
        elevation: 5.0,
        color: AppColors.lightGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildPasswordField(),
                _buildAcceptRequestButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "uqrmohla ,ndfokak", //මුරපදයක් ලබාදෙන්න
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 170.0,
                height: 80.0,
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ms<s;=r wksjd¾hhs';//පිළිතුර අනිවාර්යයි!
                    }
                    if (value.length < 6) {
                      return 'uqrmoh fláhs';//මුරපදය කෙටියි
                    }
                    return null;
                  },
                  // onEditingComplete: () {
                  //   _personalEmailFieldFocusNode.requestFocus();
                  // },
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontFamily: SettingsSinhala.engFontFamily,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.text,
                  // textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(width: 1, color: AppColors.lightGray)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: AppColors.darkPurple),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: AppColors.darkPurple),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                width: 35.0,
                height: 35.0,
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(15.0),
                  shape: BoxShape.circle,
                  color: AppColors.black,
                ),
                child: IconButton(
                  splashRadius: 5,
                  color: AppColors.darkPurple,
                  icon: const Icon(Icons.refresh, size: 18.0, color: AppColors.white,),
                  onPressed: () {
                    String x = CommonUtils.generatePasswordForAuth();
                    print(x);
                    _passwordController.text = x;
                  },
                )
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAcceptRequestButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
          backgroundColor: MaterialStateProperty.all(
              AppColors.appBarColor
          ),
          textStyle: MaterialStateProperty.all(const TextStyle(
            fontFamily: 'DL-Paras',
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          )),
        ),
        onPressed: () => _acceptAccessRequestByAdminAction(context),
        child: const Text(
          "n|jd.ekSu iïmQ¾K lrkak",//බඳවාගැනීම සම්පූර්ණ කරන්න
          // style: const TextStyle(color: AppColors.nppPurple, fontSize: 14.0),
        ),
      ),
    );
  }

  void _acceptAccessRequestByAdminAction(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Validated");
      try {
        await GetIt.I<AuthService>()
            .acceptAccessRequestByAdmin(selectedRequestAccess, _passwordController.text)
            .then((value) {
          MessageUtils.showSuccessInFlushBar(
            context,
            "n|j.ekSu id¾:lhs' wod, Bfï,a ,smskhg ikd: lsÍfï mksúvh hjk ,È'",
            appearFromTop: false,
            duration: 4,
          ); //බඳවගැනීම සාර්ථකයි. අදාල ඊමේල් ලිපිනයට සනාථ කිරීමේ පනිවිඩය යවන ලදි.
        });
      } on FirebaseAuthException catch (error) {
        print("Fire error: ${error.code} || ${error.message} ");
        if (error.code == "email-already-in-use") {
          MessageUtils.showErrorInFlushBar(context, "fuu m%fõY b,a,Sfï Bfï,a ,smskhg .sKqula we;' .sKqï ysñhd wu;kak'",
              appearFromTop: false, duration: 4);
          //මෙම ප්‍රවේශ ඉල්ලීමේ ඊමේල් ලිපිනයට ගිණුමක් ඇත. ගිණුම් හිමියා අමතන්න.
        } else {
          MessageUtils.showErrorInFlushBar(context, "m%fõY b,a,Su hdj;ald,Sk l< fkdyel'",
              appearFromTop: false, duration: 4);
          //ප්‍රවේශ ඉල්ලීම යාවත්කාලීන කළ නොහැක.
        }
      } catch (error) {
        print("Exception in create user: ${error}");
        MessageUtils.showErrorInFlushBar(context, "m%fõY b,a,Su hdj;ald,Sk l< fkdyel'",
            appearFromTop: false, duration: 4);
        //ප්‍රවේශ ඉල්ලීම යාවත්කාලීන කළ නොහැක.
      }
    }
  }
}
