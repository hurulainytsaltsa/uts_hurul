import 'package:shared_preferences/shared_preferences.dart';

class SessionLatihanManager{
  int? value;
  String? idUser, userName, nama, email, nobp, nohp, alamat;

  // Simpan session
  Future<void> saveSession(int val, String id, String username, String nama, String email, String nobp, String nohp, String alamat) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("value", val);
    sharedPreferences.setString("id", id);
    sharedPreferences.setString("username", username);
    sharedPreferences.setString("nama", nama);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("nobp", nobp);
    sharedPreferences.setString("nohp", nohp);
    sharedPreferences.setString("alamat", alamat);
  }

  //Get session
  Future getSession() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    value = sharedPreferences.getInt("value");
    idUser = sharedPreferences.getString("id");
    userName = sharedPreferences.getString("username");
    nama = sharedPreferences.getString("nama");
    email = sharedPreferences.getString("email");
    nobp = sharedPreferences.getString("nobp");
    nohp = sharedPreferences.getString("nohp");
    alamat = sharedPreferences.getString("alamat");
    return value;
  }

  //Clear session --> untuk logout
  Future clearSession() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
SessionLatihanManager session = SessionLatihanManager();

