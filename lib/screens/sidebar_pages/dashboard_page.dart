import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


//In this file advance file_picker package is used , it helps to pick files from mobile
//File picker is better than image picker
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Store PlatformFiles to be cross-platform compatible
  List<PlatformFile> _selectedPlatformFiles = [];

  Future<void> _pickFiles() async {
    /// This block of code is handling the file picking process in the `_pickFiles` method. Here's a
    /// breakdown of what it does:
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        allowMultiple: true,
        type: FileType.image,
        withData: kIsWeb,
      );

      if (result != null) {
        setState(() {
          _selectedPlatformFiles = result.files;
        });
      }
    } catch (e) {
      debugPrint("Error picking files: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking files: $e")),
      );
    }
  }

  /// The `_removeFile` function removes a file from a list of selected platform files in Dart.
  /// 
  /// Args:
  ///   index (int): The `index` parameter in the `_removeFile` function represents the position of the
  /// file that needs to be removed from the `_selectedPlatformFiles` list. It is an integer value
  /// indicating the index of the file to be removed.
  void _removeFile(int index) {
    setState(() {
      _selectedPlatformFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildStatCard('Total Sales', r'$12,450', Colors.green),
                  _buildStatCard('New Users', '1,280', Colors.blue),
                  _buildStatCard('Active Sessions', '450', Colors.orange),
                  _buildStatCard('Pending Orders', '12', Colors.red),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Upload Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Upload Assets",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pickFiles,
                    icon: const Icon(Icons.upload_file_rounded),
                    label: const Text("Select Files"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 15),
              
              // Nice File Display
              if (_selectedPlatformFiles.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.cloud_upload_outlined, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text("No files selected", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _selectedPlatformFiles.length,
                  itemBuilder: (context, index) {
                    final file = _selectedPlatformFiles[index];
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: _buildFilePreview(file),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: GestureDetector(
                            onTap: () => _removeFile(index),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                
              const SizedBox(height: 30),
              
              if (_selectedPlatformFiles.isNotEmpty)
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Uploading files to server...")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text("Confirm Upload"),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilePreview(PlatformFile file) {
    if (kIsWeb) {
      return Image.memory(file.bytes!, fit: BoxFit.cover, width: double.infinity, height: double.infinity);
    } else {
      return Image.file(File(file.path!), fit: BoxFit.cover, width: double.infinity, height: double.infinity);
    }
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
