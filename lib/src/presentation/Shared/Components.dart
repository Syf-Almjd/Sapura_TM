import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sapura_tm/src/config/utils/styles/app_colors.dart';
import 'package:toastification/toastification.dart';

import '../Cubits/appNavi_cubit/navi_cubit.dart';

TextStyle fontAlmarai(
    {double? size, Color? textColor, FontWeight? fontWeight}) {
  return GoogleFonts.almarai(
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: size ?? 16,
      color: textColor ?? Colors.black54);
}

TextStyle fontLobster(
    {double? size, Color? textColor, FontWeight? fontWeight}) {
  return GoogleFonts.lobster(
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: size ?? 16,
      color: textColor ?? Colors.black54);
}

TextStyle fontElMessiri(
    {double? size, Color? textColor, FontWeight? fontWeight}) {
  return GoogleFonts.elMessiri(
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: size ?? 16,
      color: textColor ?? Colors.black54);
}

TextStyle fontPoppins(
    {double? size, Color? textColor, FontWeight? fontWeight}) {
  return GoogleFonts.poppins(
      fontWeight: fontWeight ?? FontWeight.bold,
      fontSize: size ?? 16,
      color: textColor ?? Colors.black54);
}

double getHeight(int percent, context) {
  return (MediaQuery.of(context).size.height * (percent / 100)).toDouble();
}

SizedBox getCube(int percent, context) {
  return SizedBox(
    width: (MediaQuery.of(context).size.width * (percent / 100)).toDouble(),
    height: (MediaQuery.of(context).size.height * (percent / 100)).toDouble(),
  );
}

double getWidth(int percent, context) {
  return (MediaQuery.of(context).size.width * (percent / 100)).toDouble();
}

Widget loadingAnimation({Widget? loadingType}) {
  if (loadingType != null) {
    return loadingType;
  } else {
    return Center(
        child: LoadingAnimationWidget.waveDots(color: Colors.blue, size: 30));
  }
}

Widget padBox({size}) {
  return Padding(padding: EdgeInsets.all(size ?? 10));
}

///Custom TextField
Widget textFieldA({
  // here if you put in before the { it is required by default but if you put after it you need to say required
  Key?
      key, //the difference is that inside {} it can be optional if you want to enforce input when call use "required"
  required TextEditingController controller,
  required String hintText,
  bool? obscureText = false, //optional
  TextAlign textAlign = TextAlign.start, //optional
  Icon? prefixIcon,
  double? internalPadding,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
}) {
  return TextField(
    key: key,
    controller: controller,
    obscureText: obscureText ?? false,
    cursorColor: HexColor("#4f4f4f"),
    textAlign: textAlign,
    decoration: InputDecoration(
      hintText: hintText,
      fillColor: HexColor("#f2f3ff"),
      contentPadding: EdgeInsets.all(internalPadding ?? 20),
      hintStyle: GoogleFonts.almarai(
        fontSize: 15,
        color: Colors.black87,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      prefixIcon: prefixIcon,
      prefixIconColor: HexColor("#4f4f4f"),
      filled: true,
    ),
    onChanged: onChanged,
    onSubmitted: onSubmitted,
  );
}

///Custom Button
Widget buttonA({
  final Function()? onPressed,
  required final String buttonText,
  int? height,
  int? width,
  Color? color,
  int? borderSize,
  Color? textColor,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: (height ?? 55).toDouble(),
      width: (height ?? 275).toDouble(),
      decoration: BoxDecoration(
        color: (color ?? HexColor('#ebcd34')),
        borderRadius: BorderRadius.circular(
          (borderSize ?? 17).toDouble(),
        ),
      ),
      child: Center(
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: fontAlmarai(size: 22),
        ),
      ),
    ),
  );
}

///shows logo
Padding logoContainer(context) {
  return Padding(
    padding: const EdgeInsets.all(50.0),
    child: Container(
      width: getWidth(50, context),
      height: getHeight(20, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 2),
      ),
      child: Icon(
        Icons.lock_open_sharp,
        size: getWidth(20, context),
        color: AppColors.white,
      ),
    ),

    // child: const Image(
    //   image: AssetImage(Assets.assetsLogoTransparent),
    //   fit: BoxFit.contain,
    // ),
    // ),
  );
}

///For photo selection

///For photo selection
Widget chooseFile(context) {
  return Container(
    decoration: const BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: const Icon(Icons.person)),
        // child: const Image(
        //   image: AssetImage(Assets.assetsProfilePicture),
        //   fit: BoxFit.fill,
        // )),
        Positioned(
          bottom: 25,
          right: 25,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.black12),
            child: const Icon(
              Icons.mode_edit_outline_outlined,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
      ],
    ),
  );
}

///For photo preview
Widget fileChosen(fileUser, context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.memory(fileUser),
    ],
  );
}

//Show a toast
void showToast(String text, context) => toastification.show(
      context: context,
      title: text,
      alignment: Alignment.bottomCenter,
      primaryColor: Colors.green,
      autoCloseDuration: const Duration(seconds: 3),
    );

//Validate Text field
validateForm(
  GlobalKey<FormState> validateKey,
) {
  if (validateKey.currentState!.validate()) {
    validateKey.currentState!.save();
    return true;
  } else {
    return false;
  }
}

Future showChoiceDialog(
    {required BuildContext context,
    String? title,
    String? content,
    required Function onYes,
    Function? onNo}) {
  return (showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? ""),
          titleTextStyle: const TextStyle(fontSize: 20),
          content: Text(content ?? "Are you sure?"),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                if (onNo != null) {
                  onNo();
                }
                NaviCubit.get(context).pop(context);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                onYes();
                NaviCubit.get(context).pop(context);
              },
            ),
          ],
        );
      }));
}
