import 'package:flutter/material.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Progress",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child:
            //listview untuk membuat tampilan seperti list yang dapat di scroll secara vertikal tanpa menggunakan column dan singlechildscrollview
            ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        showCursor: true,
                        autofocus: true,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            size: 20,
                            color: Colors.white,
                          ),
                          hintText: "Please input your name",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          labelText: "Name",
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        showCursor: true,
                        autofocus: true,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.numbers_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                          hintText: "Please input your age",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          labelText: "Age",
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        showCursor: true,
                        autofocus: true,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.scale,
                            size: 20,
                            color: Colors.white,
                          ),
                          hintText: "Please input your weight",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          labelText: "Weight",
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        showCursor: true,
                        autofocus: true,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 5,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.height_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                          hintText: "Please input your height",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          labelText: "Height",
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(10),
                  child:
                      //ListTile untuk membuat tampilan seperti list dengan leading, title, subtitle, dan trailing tanpa harus membuatnya secara manual
                      ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Fayreen Zenisha",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          "Bulan Januari, Fayreen Zenisha telah melakukan olahraga sebanyak 5 kali dan berhasil menurunkan berat badan sebanyak 1,3 kg",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                          //maxLines untuk mengatur jumlah baris maksimal pada subtitle jika lebih akan dihilangkan dan diganti dengan titik tiga
                          maxLines: 2,
                          //overflow untuk mengatur bagaimana teks yang melebihi batas ditampilkan
                          //TextOverflow.ellipsis untuk mengganti teks yang melebihi batas dengan titik tiga
                          //TextOverflow.fade untuk memudar teks yang melebihi batas
                          //TextOverflow.clip untuk memotong teks yang melebihi batas tanpa mengganti dengan titik tiga atau memudar
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          "More",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.person, size: 40, color: Colors.white),
                    title: Text(
                      "Fayreen Zenisha",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      "Bulan Febuari, Fayreen Zenisha telah melakukan olahraga sebanyak 5 kali dan berhasil menurunkan berat badan sebanyak 1,3 kg",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      "More",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.person, size: 40, color: Colors.white),
                    title: Text(
                      "Fayreen Zenisha",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      "Bulan Maret, Fayreen Zenisha telah melakukan olahraga sebanyak 5 kali dan berhasil menurunkan berat badan sebanyak 1,3 kg",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      "More",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Icon(Icons.person, size: 40, color: Colors.white),
                    title: Text(
                      "Fayreen Zenisha",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      "Bulan April, Fayreen Zenisha telah melakukan olahraga sebanyak 5 kali dan berhasil menurunkan berat badan sebanyak 1,3 kg",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      "More",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
