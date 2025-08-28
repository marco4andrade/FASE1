import 'package:flutter/material.dart';
import '../../domain/entities/item.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FormScreen extends StatefulWidget {
  final Item? item;
  const FormScreen({super.key, this.item});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item?.title ?? '');
    _descController = TextEditingController(text: widget.item?.description ?? '');
    if (widget.item?.imagePath != null) {
      _imageFile = File(widget.item!.imagePath!);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      final isEditing = widget.item != null;
      final item = Item(
        id: isEditing ? widget.item!.id : const Uuid().v4(),
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        imagePath: _imageFile?.path ?? widget.item?.imagePath,
      );
      Navigator.pop(context, item);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar' : 'Agregar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: _imageFile != null
                    ? Image.file(_imageFile!, height: 200)
                    : widget.item?.imagePath != null
                        ? Image.file(File(widget.item!.imagePath!), height: 200)
                        : const Icon(Icons.image, size: 100, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.photo),
                label: const Text("Seleccionar Imagen"),
                onPressed: _pickImage,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (v) => v == null || v.isEmpty ? 'Ingrese un título' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (v) => v == null || v.isEmpty ? 'Ingrese una descripción' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: Icon(isEditing ? Icons.save : Icons.add),
                label: Text(isEditing ? 'Guardar' : 'Agregar'),
                onPressed: _save,
              )
            ],
          ),
        ),
      ),
    );
  }
}