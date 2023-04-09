import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/tickets_bloc.dart';

class AddLinkBottomSheet extends StatefulWidget {
  const AddLinkBottomSheet({super.key, required this.ticketBloc});

  final TicketBloc ticketBloc;
  @override
  State<AddLinkBottomSheet> createState() => _AddLinkBottomSheetState();
}

class _AddLinkBottomSheetState extends State<AddLinkBottomSheet> {
  final TextEditingController _urlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _url = '';

  @override
  void initState() {
    super.initState();
    Clipboard.getData('text/plain').then((value) {
      if (value != null &&
          value.text != null &&
          value.text!.startsWith('https://') &&
          value.text!.endsWith('.pdf')) {
        setState(() {
          _urlController.text = value.text!;
        });
      }
    });
  }

  Future<void> _submitInput() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    widget.ticketBloc.add(TicketAdded(_url));
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Файл успешно добавлен'),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 30,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'Введите URL',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (value) {
                if (value!.isEmpty ||
                    !value.endsWith('.pdf') ||
                    !value.startsWith('https://')) {
                  return 'Введите корректный url';
                }
                return null;
              },
              onSaved: (newValue) {
                _url = newValue!;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitInput,
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
