import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:main/data/firestore_api_service.dart';
import 'package:main/data/overpass_api_service.dart';
import 'package:main/domain/models/folder.dart';
import 'package:main/domain/models/trail.dart';
import 'package:main/l10n/app_localizations.dart';
import 'package:main/presentation/routes/app_paths.dart';
import 'package:main/presentation/utils/format_data_utils.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key, required this.folder});
  final Folder folder;

  @override
  State<FolderScreen> createState() => _FolderScreen();
}

class _FolderScreen extends State<FolderScreen> {
  List<Trail>? _trails;

  @override
  void initState() {
    super.initState();
    _loadTrails();
  }

  void _loadTrails() async {
    final trails = await OverpassApiService().getTrailsInFolder(
      widget.folder.trailsId,
    );
    if (mounted) {
      setState(() {
        _trails = trails;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.folderTitle,
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
            context.go(AppPaths.profile);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child:
                        widget.folder.imageUrl.startsWith('assets')
                            ? Image.asset(
                              widget.folder.imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                            : Image.network(
                              widget.folder.imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                  ),
                ),
                Text(
                  widget.folder.name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    thickness: 2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 30,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {
                        context.push(AppPaths.editFolder, extra: widget.folder);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outlined,
                        size: 30,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                AppLocalizations.of(context)!.folderDelete,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                AppLocalizations.of(context)!.folderDeleteText,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.folderDeleteCancel,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirestoreApiService()
                                        .deleteFolder(
                                          userId: uid,
                                          folderId: widget.folder.folderId,
                                        )
                                        .then((_) {
                                          context.pop();
                                          context.pop();
                                        });
                                  },
                                  child: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.folderDeleteConfirm,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.folderYourTrails,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child:
                        _trails == null
                            ? Center(child: CircularProgressIndicator())
                            : _trails!.isEmpty
                            ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 10),
                                Icon(
                                  Icons.folder_special_rounded,
                                  size: 100,
                                  color: Colors.white70,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  AppLocalizations.of(context)!.folderEmpty,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                            : ListView.builder(
                              itemCount: _trails!.length,
                              itemBuilder: (context, index) {
                                final trail = _trails![index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                        title: Text(
                                          trail.name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          FormatDataUtils.getDifficultyLabel(
                                            context,
                                            trail.grade,
                                          ),
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 18,
                                          ),
                                        ),
                                        trailing: Text(
                                          '${trail.length.toString()} m',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              context.push(
                                                '/trail/${trail.id}',
                                                extra: trail,
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              side: BorderSide(
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.secondary,
                                                width: 2,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.info,
                                                  size: 25,
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.secondary,
                                                ),
                                                SizedBox(width: 2),
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.folderDitails,
                                                  style: TextStyle(
                                                    color:
                                                        Theme.of(
                                                          context,
                                                        ).colorScheme.secondary,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 6),
                                          ElevatedButton(
                                            onPressed: () {
                                              FirestoreApiService()
                                                  .addCompletedTrail(
                                                    userId: uid,
                                                    trailName: trail.name,
                                                    m: trail.length,
                                                  )
                                                  .then((_) {
                                                    FirestoreApiService()
                                                        .deleteTrailFromFolder(
                                                          userId: uid,
                                                          folderId:
                                                              widget
                                                                  .folder
                                                                  .folderId,
                                                          trailId: trail.id,
                                                        );
                                                    if (mounted) {
                                                      setState(() {
                                                        _trails!.removeAt(
                                                          index,
                                                        );
                                                      });
                                                    }
                                                  });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              side: BorderSide(
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.secondary,
                                                width: 2,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .check_circle_outline_rounded,
                                                  size: 25,
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.secondary,
                                                ),
                                                SizedBox(width: 2),
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.folderComplete,
                                                  style: TextStyle(
                                                    color:
                                                        Theme.of(
                                                          context,
                                                        ).colorScheme.secondary,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 3),
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.folderDelete,
                                                      style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    content: Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.folderDeleteTrail,
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          context.pop();
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.folderDeleteCancel,
                                                          style: TextStyle(
                                                            color:
                                                                Colors
                                                                    .grey[700],
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          FirestoreApiService()
                                                              .deleteTrailFromFolder(
                                                                userId: uid,
                                                                folderId:
                                                                    widget
                                                                        .folder
                                                                        .folderId,
                                                                trailId:
                                                                    trail.id,
                                                              );
                                                          context.pop();
                                                          if (mounted) {
                                                            setState(() {
                                                              _trails!.removeAt(
                                                                index,
                                                              );
                                                            });
                                                          }
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.folderDeleteConfirm,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              side: BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                            ),
                                            icon: Icon(
                                              Icons.delete_forever_rounded,
                                              size: 25,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                );
                              },
                            ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
