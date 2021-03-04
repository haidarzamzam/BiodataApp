import 'dart:convert';

import 'package:biodata_app/utils/decoration_utils.dart';
import 'package:biodata_app/utils/validate_helper.dart';
import 'package:biodata_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';

Widget buildCircleAvatar(String image) {
  return CircleAvatar(
    radius: 50.0,
    child: ClipOval(
      clipBehavior: Clip.hardEdge,
      child: !ValidateHelper.isEmpty(image)
          ? Image.memory(base64Decode(image), fit: BoxFit.cover)
          : Image.asset('assets/images/add_image.png'),
    ),
    backgroundColor: Colors.white,
  );
}

Widget buildTextField(
    TextEditingController controller, String hint, TextInputType inputType) {
  return TextFormField(
    style: TextStyle(color: Colors.white),
    controller: controller,
    enableSuggestions: false,
    autocorrect: false,
    autofocus: false,
    keyboardType: inputType,
    decoration: DecorationUtil().roundedFormField(
      borderSideColor: Colors.transparent,
      fillColor: WidgetUtil().parseHexColor("#323232"),
      hintText: hint,
    ),
  );
}

Widget buildDropdown(BuildContext context, List<String> itemData,
    Function function(String value)) {
  return DropdownButtonHideUnderline(
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: WidgetUtil().parseHexColor("#323232"),
          border: Border.all()),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: WidgetUtil().parseHexColor("#323232"),
        ),
        child: DropdownButton(
            items: itemData
                .map(
                  (value) => DropdownMenuItem(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    value: value,
                  ),
                )
                .toList(),
            onChanged: (value) => function(value),
            isExpanded: false,
            isDense: false,
            value: itemData.first),
      ),
    ),
  );
}
