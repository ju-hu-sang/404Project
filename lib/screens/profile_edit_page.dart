import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  File? _image;
  final picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String _gender = '남';

  @override
  void initState() {
    super.initState();

    _birthController.addListener(() {
      final raw = _birthController.text.replaceAll('/', '');
      String formatted = '';
      if (raw.length >= 4) {
        formatted = raw.substring(0, 4);
        if (raw.length >= 6) {
          formatted += '/' + raw.substring(4, 6);
          if (raw.length >= 8) {
            formatted += '/' + raw.substring(6, 8);
          } else if (raw.length > 6) {
            formatted += '/' + raw.substring(6);
          }
        } else if (raw.length > 4) {
          formatted += '/' + raw.substring(4);
        }
      } else {
        formatted = raw;
      }

      _birthController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 흰색
      appBar: AppBar(
        title: const Text(
          '프로필 수정',
          style: TextStyle(
            fontFamily: 'LGSmartUI',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60, // 원의 크기 유지
              backgroundColor: Colors.grey[200], // 연회색 배경
              child: _image != null
                  ? ClipOval(
                child: Image.file(
                  _image!,
                  width: 60, // 발자국 크기 (이미지 크기만 줄이기)
                  height: 60,
                  fit: BoxFit.cover,
                ),
              )
                  : Image.asset(
                'assets/default_profile.png', // 발자국 기본 이미지
                width: 70, // 발자국 크기만 줄이기
                height: 70,
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _pickImage,
              child: const Text(
                '사진 업로드',
                style: TextStyle(
                  fontFamily: 'LGSmartUI',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField('이름을 입력하세요', _nameController),
            _buildTextField('종을 입력하세요', _breedController),
            _buildTextField(
              'YYYY/MM/DD',
              _birthController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            _buildTextField(
              '나이를 입력하세요',
              _ageController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              suffixText: '세',
            ),
            _buildTextField(
              '몸무게를 입력하세요',
              _weightController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              suffixText: 'kg',
            ),
            const SizedBox(height: 16),
            _buildGenderSelection(),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // 저장 기능
                },
                child: const Text(
                  '수정 완료',
                  style: TextStyle(
                    fontFamily: 'LGSmartUI',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String hint,
      TextEditingController controller, {
        List<TextInputFormatter>? inputFormatters,
        String? suffixText,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: (controller == _ageController || controller == _weightController)
            ? TextInputType.number
            : TextInputType.text,
        textInputAction: TextInputAction.next,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'LGSmartUI',
            fontWeight: FontWeight.w400,
          ),
          suffixText: suffixText,
          border: const OutlineInputBorder(),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
        style: const TextStyle(
          fontFamily: 'LGSmartUI',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      children: [
        const Text(
          '성별',
          style: TextStyle(
            fontFamily: 'LGSmartUI',
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Row(
            children: [
              Radio<String>(
                value: '남',
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
              ),
              const Text(
                '남',
                style: TextStyle(
                  fontFamily: 'LGSmartUI',
                  fontWeight: FontWeight.w300,
                ),
              ),
              Radio<String>(
                value: '여',
                groupValue: _gender,
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
              ),
              const Text(
                '여',
                style: TextStyle(
                  fontFamily: 'LGSmartUI',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
