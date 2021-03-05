import 'dart:convert';

import 'package:biodata_app/utils/decoration_utils.dart';
import 'package:biodata_app/utils/validate_helper.dart';
import 'package:biodata_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';

Widget buildCircleAvatar(String image) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Container(
      width: 120,
      height: 120,
      child: !ValidateHelper.isEmpty(image)
          ? Image.memory(base64Decode(image),
              width: 120, height: 120, fit: BoxFit.fill)
          : Image.asset('assets/images/add_image.png',
              width: 120, height: 120, fit: BoxFit.fill),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
    ),
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
            isExpanded: true,
            items: itemData
                .map(
                  (value) =>
                  DropdownMenuItem(
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
            isDense: false,
            value: itemData.first),
      ),
    ),
  );
}
