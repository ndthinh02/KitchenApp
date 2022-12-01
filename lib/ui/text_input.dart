// import 'package:flutter/material.dart';

// class TextInputCustom extends StatelessWidget {
//   String hintText;
//   TextEditingController textEditingController;
//   TextInputType textInputType;

//   TextInputCustom(
//       {super.key,
//       required this.hintText,
//       required this.textEditingController,
//       required this.textInputType});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Form(
//           key: formKey,
//           child: TextFormField(
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Hãy nhập đầy đủ';
//               }
//               return null;
//             },
//             keyboardType: textInputType,
//             controller: textEditingController,
//             decoration: InputDecoration(
//               hintText: hintText,
//             ),
//           )),
//     );
//   }
// }


