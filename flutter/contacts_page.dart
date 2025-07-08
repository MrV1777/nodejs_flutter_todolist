import 'package:flutter/material.dart';

// สร้าง Model สำหรับเก็บข้อมูล Contact
class Contact {
  final String name;
  final String email;

  Contact({required this.name, required this.email});
}

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  // สร้างข้อมูลตัวอย่าง
  final List<Contact> contacts = [
  ];

  String? _selectedGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // สีพื้นหลังเทาอ่อน
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
              maxWidth: 500), // จำกัดความกว้างสำหรับหน้าจอใหญ่
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // ทำให้ Card พอดีกับเนื้อหา
              children: [
                // หัวข้อ Contacts Management
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Contacts Management',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Dropdown สำหรับ Group
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Group',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                    value: _selectedGroup,
                    items: ['Family', 'Friends', 'Work']
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGroup = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // ปุ่ม Add Contact
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // ใส่ฟังก์ชันสำหรับเพิ่ม Contact ที่นี่
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Add Contact',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(
                          double.infinity, 48), // ทำให้ปุ่มเต็มความกว้าง
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ส่วนของ List รายชื่อ
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(contact.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text(contact.email,
                            style: TextStyle(color: Colors.grey[600])),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
