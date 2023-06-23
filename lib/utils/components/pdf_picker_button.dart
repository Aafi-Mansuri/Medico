import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'my_button.dart';

class PDFPicker extends StatefulWidget {
  final String buttonText;
  final ValueChanged<String?> onChanged;

  const PDFPicker({
    Key? key,
    required this.buttonText,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<PDFPicker> createState() => _PDFPickerState();
}

class _PDFPickerState extends State<PDFPicker> {
  String? selectedFileName;
  String? errorText;

  Future<void> pickPDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;

      Directory? appDirectory = await getApplicationDocumentsDirectory();
      String filePath = '${appDirectory.path}/${file.name}';

      File savedFile =
          File(file.path!); // Use the path property of PlatformFile

      try {
        await savedFile.copy(filePath);
        print(selectedFileName);
        print('File saved at: $filePath');
      } catch (e) {
        print('Error saving file: $e');
      }
    }
  }

  void removeSelectedFile() {
    setState(() {
      selectedFileName = null;
      errorText = null;
    });
    widget.onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onTap: pickPDFFile,
          buttonText: selectedFileName ?? widget.buttonText,
          prefixIcon: Icons.picture_as_pdf_outlined,
        ),
        if (selectedFileName != null)
          MyButton(
            onTap: removeSelectedFile,
            buttonText: 'Remove',
            prefixIcon: Icons.picture_as_pdf_outlined,
          ),
      ],
    );
  }
}
