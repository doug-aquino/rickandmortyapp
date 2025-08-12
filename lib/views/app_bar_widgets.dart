import 'package:flutter/material.dart';

class AppBarWidgets extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidgets({
    super.key,
    required this.leftIcon,
    this.onSearchChanged, // Adicione este callback
  });

  final Widget leftIcon;
  final ValueChanged<String>?
  onSearchChanged; // Callback para notificar a mudança no texto

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1C1B1F),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 13.98, top: 17.48),
                  child: leftIcon,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/logo_app.png',
                        width: 115,
                        height: 76.99,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 20, // Ajuste para centralizar
                          top: 10,
                          right: 20, // Ajuste para centralizar
                          bottom: 10,
                        ),
                        child: Text(
                          'RICK AND MORTY API',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.5,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12.23, right: 13.98),
                  child: Icon(Icons.person_2, color: Colors.white),
                ),
              ],
            ),
            // Adicionando a Barra de Pesquisa
            if (onSearchChanged != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: TextField(
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar personagens...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(onSearchChanged != null ? 200.0 : 130.92);
}
