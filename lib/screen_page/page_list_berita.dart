import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uts_hurul/screen_page/page_detail_berita.dart';
import 'package:uts_hurul/screen_page/page_login.dart';
import 'package:uts_hurul/screen_page/page_profile_user.dart';

import '../model/model_berita.dart';
import '../utils/session_manager.dart';

class PageListBerita extends StatefulWidget {
  const PageListBerita({super.key});

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {
  String? userName;
  TextEditingController searchController = TextEditingController();
  List<Datum>? beritaList;
  List<Datum>? filteredBeritaList;

  //untuk mendapatkan sesi
  Future getDataSession() async{
    await Future.delayed(const Duration(seconds: 5),(){
      session.getSession().then((value){
        print('Data sesi ..'+ value.toString());
        userName = session.userName;
      });
    });
  }
  //method untuk get berita
  Future<List<Datum>?> getBerita() async {
    try {
      //berhasil
      http.Response response = await http
          .get(Uri.parse('http://10.126.53.160/uts_mobile/berita.php'));

      return modelBeritaFromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    session.getSession();
    getDataSession();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Aplikasi Berita')),
        backgroundColor: Colors.cyan,
        actions: [
          TextButton(onPressed: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PageProfileUser()
            ));
          }, child: Text('Hi .. ${session.userName}')),
          //logout
          IconButton(onPressed: (){
            setState(() {
              session.clearSession();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PageLogin()), (route) => false);
            });
          },
            icon: Icon(Icons.exit_to_app), tooltip: 'Logout',)
        ],
      ),

      body:
      Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filteredBeritaList = beritaList
                      ?.where((element) =>
                  element.judul!
                      .toLowerCase()
                      .contains(value.toLowerCase()) ||
                      element.konten!
                          .toLowerCase()
                          .contains(value.toLowerCase()) ||
                      element.author!
                          .toLowerCase()
                          .contains(value.toLowerCase()) ||
                      element.created.toIso8601String()!
                          .toLowerCase()
                          .contains(value.toLowerCase())
                  )
                      .toList();
                });
              },
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),),
          Expanded(child:FutureBuilder(
              future: getBerita(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.hasData) {
                  beritaList = snapshot.data;
                  if (filteredBeritaList == null) {
                    filteredBeritaList = beritaList;
                  }
                  return ListView.builder(
                      itemCount: filteredBeritaList!.length,
                      itemBuilder: (context, index) {
                        Datum data = filteredBeritaList![index];
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              //Ini untuk ke detail
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PageDetailBerita(data)));
                            },
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'http://10.126.53.160/uts_mobile/image/${data?.gambar}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      '${data?.judul}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                          fontSize: 18),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${data?.author}",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          "${data?.konten}",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.black),
                                        ),
                                        Text(
                                          "${data?.created}",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.black),
                                        ),
                                      ],
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
                }
              }),)
        ],
      ),
    );
  }
}
