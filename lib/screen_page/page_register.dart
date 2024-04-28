import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uts_hurul/screen_page/page_login.dart';

import '../model/model_register.dart';

class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNohp = TextEditingController();
  TextEditingController txtNobp = TextEditingController();
  TextEditingController txtAlamat = TextEditingController();

  //validasi form
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  //Proses untuk hit API
  bool isLoading = false;

  Future<ModelRegister?> registerAccount() async {
    //handle error
    try {
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.post(
          Uri.parse('http://10.126.53.160/uts_mobile/register.php'),
          body: {
            "username": txtUsername.text,
            "email": txtEmail.text,
            "nama": txtNama.text,
            "nobp": txtNobp.text,
            "nohp": txtNohp.text,
            "alamat": txtAlamat.text,
            "password": txtPassword.text,
          }
      );

      ModelRegister data = modelRegisterFromJson(response.body);
      //Cek kondisi
      if (data.value == 1) {
        //Kondisi ketika berhasil register
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );

          //pindah ke page login
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => PageLogin()
          ), (route) => false);
        });
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Form Register'),
      ),

      body: Form(
          key: keyForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtNama,
                    decoration: InputDecoration(
                        hintText: 'Nama',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtUsername,
                    decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.supervised_user_circle),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtEmail,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtNobp,
                    decoration: InputDecoration(
                        hintText: 'NOBP',
                        prefixIcon: Icon(Icons.numbers),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtNohp,
                    decoration: InputDecoration(
                        hintText: 'NOHP',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtPassword,
                    obscureText: true, //biar password tidak kelihatan
                    decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.key),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //validasi kosong
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    controller: txtAlamat,
                    decoration: InputDecoration(
                        hintText: 'Alamat',
                        prefixIcon: Icon(Icons.home),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //Proses cek loading
                  Center(child: isLoading ? Center(
                    child: CircularProgressIndicator(),
                  ) : MaterialButton(
                    minWidth: 150,
                    height: 45,
                    onPressed: () {
                      //Cek validasi form ada kosong atau tidak
                      if (keyForm.currentState?.validate() == true) {
                        setState(() {
                          registerAccount();
                        });
                      }
                    },
                    child: Text('Register'),
                    color: Colors.green,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                            width: 1, color: Colors.blueGrey)),
                  )),
                ],
              ),
            ),
          )
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 1, color: Colors.blueGrey)),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PageLogin()
            ));
          },
          child: Text('Anda sudah punya account? Silahkan Login'),
        ),
      ),
    );
  }
}
