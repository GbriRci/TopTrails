import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:main/data/firestore_api_service.dart';
import 'package:main/data/supabase_api.dart';
import 'package:main/domain/models/folder.dart';
import 'package:main/l10n/app_localizations.dart';
import 'package:main/presentation/routes/app_paths.dart';
import 'package:main/presentation/screens/image_picker/image_picker_page.dart';

class EditFolderScreen extends StatefulWidget {
  const EditFolderScreen({super.key, required this.folder});
  final Folder folder;

  @override
  State<EditFolderScreen> createState() => _EditFolderScreenState();
}

class _EditFolderScreenState extends State<EditFolderScreen> {
  late TextEditingController _nameController;
  String? _imagePath;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.folder.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.editFolderTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: 30,
          onPressed: () {
            context.go(AppPaths.folder, extra: widget.folder);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(
                        context,
                      )!.editFolderName(widget.folder.name),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    SizedBox(height: 24),
                    GestureDetector(
                      onTap: () async {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          builder:
                              (context) => Padding(
                                padding: const EdgeInsets.all(20),
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.photo_library),
                                      title: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.editFolderGallery,
                                      ),
                                      onTap: () async {
                                        final picker = ImagePicker();
                                        final pickedFile = await picker
                                            .pickImage(
                                              source: ImageSource.gallery,
                                            );
                                        if (pickedFile != null) {
                                          context.pop();
                                          if (mounted) {
                                            setState(() {
                                              _imagePath = pickedFile.path;
                                            });
                                          }
                                        }
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.editFolderCamera,
                                      ),
                                      onTap: () async {
                                        final imagePath =
                                            await Navigator.push<String>(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (_) => ImagePickerPage(),
                                              ),
                                            );
                                        if (imagePath != null) {
                                          context.pop();
                                          setState(() {
                                            _imagePath = imagePath;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                        );
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 60,
                            backgroundImage:
                                _imagePath != null
                                    ? FileImage(File(_imagePath!))
                                    : widget.folder.imageUrl.startsWith(
                                      'assets',
                                    )
                                    ? AssetImage(widget.folder.imageUrl)
                                        as ImageProvider
                                    : NetworkImage(widget.folder.imageUrl),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.editFolderNameFolder,
                        hintText:
                            AppLocalizations.of(context)!.editFolderInsertName,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.folder),
                      ),
                    ),
                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: Icon(Icons.save, color: Colors.white),
                        label: Text(
                          AppLocalizations.of(context)!.editFolderSave,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () async {
                          if (_nameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.editFolderEmptyName,
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          String? imageUrl = widget.folder.imageUrl;
                          if (_imagePath != null) {
                            final file = File(_imagePath!);
                            final fileName =
                                '${uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
                            final uploadedUrl = await SupabaseApi().uploadImage(
                              file,
                              fileName,
                            );
                            if (uploadedUrl != null) {
                              imageUrl = uploadedUrl;
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Errore durante il caricamento dell'immagine.",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                          }
                          await FirestoreApiService().updateFolder(
                            userId: uid,
                            folderId: widget.folder.folderId,
                            newName: _nameController.text,
                            newImageUrl: imageUrl,
                          );
                          final updatedFolder = widget.folder.copyWith(
                            name: _nameController.text,
                            imageUrl: imageUrl,
                          );
                          context.go(AppPaths.folder, extra: updatedFolder);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
