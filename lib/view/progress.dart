import 'package:fitguide/extension/navigator.dart';
import 'package:fitguide/utils/decoration.dart';
import 'package:fitguide/controller/progress_controller.dart';
import 'package:flutter/material.dart';
import '../model/progress_model.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  Future<void> saveData() async {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        weightController.text.isEmpty ||
        heightController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua field wajib diisi")));
      return;
    }

    final data = ProgressModel(
      name: nameController.text,
      age: ageController.text,
      weight: weightController.text,
      height: heightController.text,
    );

    await UserController.insertUser(data);

    nameController.clear();
    ageController.clear();
    weightController.clear();
    heightController.clear();

    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Progress",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    autofocus: false,
                    decoration: decorationConstant(
                      hintText: "Please input your name",
                      labelText: "Name",
                      prefixIcon: Icons.person,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    autofocus: false,
                    decoration: decorationConstant(
                      hintText: "Please input your age",
                      labelText: "Age",
                      prefixIcon: Icons.numbers_rounded,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    autofocus: false,
                    decoration: decorationConstant(
                      hintText: "Please input your weight",
                      labelText: "Weight",
                      prefixIcon: Icons.scale,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    autofocus: false,
                    decoration: decorationConstant(
                      hintText: "Please input your height",
                      labelText: "Height",
                      prefixIcon: Icons.height_rounded,
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: saveData,
                      child: const Text(
                        "Simpan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _listData(),
          ],
        ),
      ),
    );
  }

  Widget _listData() {
    return FutureBuilder<List<ProgressModel>>(
      future: UserController.getAllUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada data",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        final data = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // padding: const EdgeInsets.all(10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                    title: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      "Age ${item.age} | Weight ${item.weight} | Height ${item.height} ",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await showEditDialog(context, item);
                            setState(() {});
                          },
                          icon: Icon(Icons.edit, color: Colors.green),
                        ),
                        IconButton(
                          onPressed: () async {
                            await showDeleteDialog(context, item.id!);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showEditDialog(BuildContext context, ProgressModel items) async {
    final nameController = TextEditingController(text: items.name);
    final ageController = TextEditingController(text: items.age);
    final weightController = TextEditingController(text: items.weight);
    final heightController = TextEditingController(text: items.height);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Edit User",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: decorationConstant(hintText: "Name"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: ageController,
                decoration: decorationConstant(hintText: "Age"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: weightController,
                decoration: decorationConstant(hintText: "Weight"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: heightController,
                decoration: decorationConstant(hintText: "Height"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                "Batal",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () async {
                if (items.id == null) {
                  return;
                }
                await UserController.updateUser(
                  ProgressModel(
                    id: items.id,
                    name: nameController.text,
                    age: ageController.text,
                    weight: weightController.text,
                    height: heightController.text,
                  ),
                );
                context.pop();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("User di update")));
              },
              child: Text(
                "Simpan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showDeleteDialog(BuildContext context, int id) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Konfirmasi",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Apakah anda yakin ingin menghapus data ini?",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop(false);
              },
              child: Text(
                "Batal",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () async {
                context.pop(true);
              },
              child: Text(
                "Hapus",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await UserController.deleteUser(id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Data berhasil dihapus")));
      setState(() {});
    }
  }
}
