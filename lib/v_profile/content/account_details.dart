import 'package:appclientes/service/services.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/keys/global_keys.dart';
import 'package:appclientes/v_profile/controller/profile_controller.dart';
import 'package:appclientes/v_profile/data/profile_data.dart';
import 'package:flutter/material.dart';

enum ACCOUNT_STATE {
  VIEW,
  EDIT,
  ADD,
}

class AccountDetails extends StatefulWidget {
  const AccountDetails({
    Key key,
  }) : super(key: key);

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  ACCOUNT_STATE _state;
  UserModel _user;
  final name = 'Nombres:';
  final lastname = 'Apellidos:';
  final email = 'Correo:';
  final phone = 'Teléfono:';

  @override
  Widget build(BuildContext context) {
    return AppCard(
      title: "datos de la cuenta",
      child: Form(
        key: AppKeys.editFormKey,
        child: Column(
          children: [
            for (Map input in profileInputsData) buildUserField(_user, input),
            _switchButton
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _user = ProfileController.loadProfile;
    ProfileController.loadToEditProfile;
    _state = ACCOUNT_STATE.VIEW;
    super.initState();
  }

  void onEdit() async {
    if (await AppConnectivity.check()) {
      if (await ProfileController.hasToken)
        setState(() => _state = ACCOUNT_STATE.EDIT);
    }
  }

  void onSave() async {
    if (await AppConnectivity.check()) {
      await ProfileController.saveProfile.then((value) =>
          value ? setState(() => _state = ACCOUNT_STATE.VIEW) : null);
      _user = ProfileController.loadProfile;
    }
  }

  Widget get _switchButton {
    switch (_state) {
      case ACCOUNT_STATE.VIEW:
        return SaveTag(
          "editar mi cuenta",
          icon: AppIcon.edit,
          onPress: onEdit,
        );
        break;
      case ACCOUNT_STATE.EDIT:
        return SaveTag(
          "guardar",
          icon: AppIcon.save,
          onPress: onSave,
        );
        break;
      default:
        return Container();
    }
  }

  CardField buildUserField(UserModel user, Map input) {
    String text = ProfileController.getInputValues(user, input);
    String lead = input['type'];

    return CardField(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: null, child: Texts.black(lead ?? "text")),
          _buildInput(text, input, user),
        ],
      ),
    );
  }

  Widget _buildInput(String text, Map input, user) {
    switch (_state) {
      case ACCOUNT_STATE.VIEW:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Texts.black(text ?? "text")],
        );
        break;
      case ACCOUNT_STATE.EDIT:
        if (input['key'] == PROFILE_INPUT.EMAIL)
          return Texts.black(text ?? "text");
        return Container(
          child: Row(
            children: [
              Container(
                width: 200,
                child: FormInput(
                  hintText: input["hintText"],
                  border: OutlineInputBorder(gapPadding: 0),
                  initialText: ProfileController.getInputValues(user, input),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  textInputType: input["textInputType"],
                  validator: input["validator"],
                  controller: input["controller"],
                  inputFormatters: input["inputFormatters"],
                  textCapitalization : input["textCapitalization"],
                ),
              ),
            ],
          ),
        );
        break;
      default:
        return Container();
    }
  }
}
