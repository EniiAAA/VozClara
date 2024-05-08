import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaDeCadastro extends StatelessWidget {
  const TelaDeCadastro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Implemente a navegação para a tela inicial
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/voz_claralogo_4.png',
                        ),
                      ),
                    ),
                    width: 194,
                    height: 194,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 289.6,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.7),
                      ),
                      labelText: 'Nome Completo',
                    ),
                    style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0x99000000),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 289.6,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.7),
                      ),
                      labelText: 'Número de matrícula',
                    ),
                    style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0x99000000),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 289.6,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.7),
                      ),
                      labelText: 'Digite seu e-mail',
                    ),
                    style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0x99000000),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 289.6,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.7),
                      ),
                      labelText: 'Digite sua senha',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.visibility),
                      ),
                    ),
                    style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0x99000000),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implemente a lógica de cadastro aqui
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      'Cadastrar',
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0098FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.7),
                    ),
                    shadowColor: Color(0x26FFFFFF),
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
