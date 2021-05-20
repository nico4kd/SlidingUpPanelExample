import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:slidingup_panel_example/models/calle.dart';
import 'package:slidingup_panel_example/models/pto_ref_data.dart';
import 'package:slidingup_panel_example/theme/theme.dart';
import 'package:slidingup_panel_example/widget/maker_button.dart';

import 'package:slidingup_panel_example/widget/panels.dart';

class PanelInicio extends StatefulWidget {
  const PanelInicio({
    Key? key,
    required this.onChangePanelType,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final void Function(Panels value) onChangePanelType;

  @override
  _PanelInicioState createState() => _PanelInicioState();
}

class _PanelInicioState extends State<PanelInicio> {
  final panelController = PanelController();
  var isPanelOpen = false;

  late Timer timer1;

  Timer _timer1() => Timer(const Duration(seconds: 2), () => panelController.open());

  @override
  void initState() {
    super.initState();
    timer1 = _timer1();
  }

  @override
  void dispose() {
    timer1.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: panelController,
      minHeight: 85.0,
      maxHeight: 274.0,
      onPanelClosed: () => setState(() => isPanelOpen = false),
      onPanelOpened: () => setState(() => isPanelOpen = true),
      panelBuilder: (scrollController) => _SlidingPanel(
        scrollController: scrollController,
        panelController: panelController,
        onChangePanelType: widget.onChangePanelType,
        isPanelOpen: isPanelOpen,
      ),
      body: widget.child,
    );
  }
}

class _SlidingPanel extends StatefulWidget {
  const _SlidingPanel({
    Key? key,
    required this.panelController,
    required this.scrollController,
    required this.onChangePanelType,
    required this.isPanelOpen,
  }) : super(key: key);

  final PanelController panelController;
  final ScrollController scrollController;
  final void Function(Panels value) onChangePanelType;
  final bool isPanelOpen;

  @override
  __SlidingPanelState createState() => __SlidingPanelState();
}

class __SlidingPanelState extends State<_SlidingPanel> {
  var isFavoritesOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Palette.gradient.copyWith(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      height: !widget.isPanelOpen ? 85 : 274,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 85.0,
          maxHeight: !widget.isPanelOpen ? 85 : 274,
          // : !isFavoritesOpen
          //     ? 274.0
          //     : 1200.0,
        ),
        // maxheight: !widget.isPanelOpen ? 85 : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '¿Dónde te vamos a buscar?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18.0,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Panel Cerrado
              Visibility(
                visible: !widget.isPanelOpen,
                child: const Spacer(),
              ),
              Visibility(
                visible: !widget.isPanelOpen,
                child: const Divider(
                  height: 1,
                  color: Palette.grisClaro,
                ),
              ),

              // Panel Abierto
              Visibility(
                visible: !isFavoritesOpen && widget.isPanelOpen,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      // controller: _txtController,
                      // onChanged: onChanged,
                      style: TextStyle(color: Colors.white, letterSpacing: 2),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: EdgeInsets.all(5),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Palette.blanco, width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Palette.blanco, width: 1),
                        ),
                        // hintText: _showSugerenciaInicial ? dirhint : null,
                        hintStyle: TextStyle(color: Palette.grisClaro, letterSpacing: 2),
                        suffix: InkWell(
                          // onTap: () => panelNav.currentState?.pushNamed('/ref-chofer',
                          //     arguments: {'direccion': _txtController.text, 'dirOrigen': coordsDir}),
                          child: SvgPicture.asset(
                            'assets/Icon_Fav_OFF.svg',
                            width: 28,
                            height: 28,
                            color: Palette.grisClaro,
                          ),
                        ),
                      ),
                    ),
                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      color: Palette.onBoardingGradientDark,
                      borderRadius: BorderRadius.circular(5),
                      shadowColor: Colors.transparent,
                    ),
                    itemBuilder: (BuildContext context, Calles sugerencia) {
                      return _ItemSuggestion(sugerencia: sugerencia);
                    },
                    getImmediateSuggestions: true,
                    keepSuggestionsOnLoading: false,
                    hideSuggestionsOnKeyboardHide: false,
                    hideOnEmpty: true,
                    suggestionsBoxVerticalOffset: 10,
                    // suggestionsBoxController: suggController,
                    // suggestionsCallback: suggestionsCallback,
                    // onSuggestionSelected: onSuggestionSelected,
                    suggestionsCallback: (pattern) => _getSuggestions(),
                    onSuggestionSelected: (suggestion) => null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No ingresaste ninguna dirección';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              Visibility(
                visible: !isFavoritesOpen && widget.isPanelOpen,
                child: const Spacer(),
              ),
              Visibility(
                visible: !isFavoritesOpen && widget.isPanelOpen,
                child: const Divider(height: 1, color: Palette.grisClaro),
              ),
              Visibility(
                visible: widget.isPanelOpen,
                child: _Favoritos(
                  scrollController: widget.scrollController,
                  onExpansionChanged: (value) => setState(() => isFavoritesOpen = value),
                  onItemSelected: (value) {
                    setState(() => isFavoritesOpen = false);
                    print('Favorito seleccionado: ${value.direccion}');
                  },
                  isFavoritesOpen: isFavoritesOpen,
                  favoritos: _getFavorites(),
                ),
              ),
              Visibility(
                visible: !isFavoritesOpen && widget.isPanelOpen,
                child: const Divider(height: 1, color: Palette.grisClaro),
              ),

              Visibility(
                visible: !isFavoritesOpen && widget.isPanelOpen,
                child: _BottomButtons(
                  onPressedAgregarDatos: () {},
                  onPressedPedirViaje: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Calles> _getSuggestions() {
    final json =
        '[{"LOCALIDAD": "MAR DEL PLATA","CALLE": "ALMONACID","FROMLEFT": 1,"TORIGHT": 9999,"LATITUD": -37.941260,"LONGITUD": -57.586330},{"LOCALIDAD": "MAR DEL PLATA","CALLE": "EL PAMPERO","FROMLEFT": 1,"TORIGHT": 2999,"LATITUD": -37.940500,"LONGITUD": -57.589790},{"LOCALIDAD": "MAR DEL PLATA","CALLE": "GARAGIOLA","FROMLEFT": 1,"TORIGHT": 9999,"LATITUD": -37.942740,"LONGITUD": -57.587960},{"LOCALIDAD": "MAR DEL PLATA","CALLE": "JULIO VERNE","FROMLEFT": 9200,"TORIGHT": 9299,"LATITUD": -37.944110,"LONGITUD": -57.597260},{"LOCALIDAD": "MAR DEL PLATA","CALLE": "VALENCIA","FROMLEFT": 9200,"TORIGHT": 9299,"LATITUD": -37.944520,"LONGITUD": -57.597590},{"LOCALIDAD": "MAR DEL PLATA","CALLE": "JULIO VERNE","FROMLEFT": 9100,"TORIGHT": 9199,"LATITUD": -37.944490,"LONGITUD": -57.596510},{"LOCALIDAD": "MAR DEL PLATA","CALLE": "VALENCIA","FROMLEFT": 9100,"TORIGHT": 9199,"LATITUD": -37.944900,"LONGITUD": -57.596840}]';
    return Calles.parseJson(json);
  }

  List<PtoRefData> _getFavorites() {
    final json =
        '[{"NOMBRE": "Casa de pin","CALLE": "Peña 3064","LATITUD": -37.941260,"LONGITUD": -57.586330},{"NOMBRE": "Casa de urciuoli","CALLE": "Sarmiento 3064","LATITUD": -37.941260,"LONGITUD": -57.586330},{"NOMBRE": "Gomería de don josé","CALLE": "Ayolas 3064","LATITUD": -37.941260,"LONGITUD": -57.586330},{"NOMBRE": "Maker","CALLE": "chile 3064","LATITUD": -37.941260,"LONGITUD": -57.586330},{"NOMBRE": "Tía lola","CALLE": "España 3064","LATITUD": -37.941260,"LONGITUD": -57.586330}]';
    return PtoRefData.parseJson(json);
  }
}

class _ItemSuggestion extends StatelessWidget {
  const _ItemSuggestion({Key? key, required this.sugerencia}) : super(key: key);

  final Calles sugerencia;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.location_on_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          (sugerencia).calle!,
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                        Text(
                          sugerencia.desde.toString() + '-' + sugerencia.hasta.toString(),
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        sugerencia.localidad!,
                        style: TextStyle(fontSize: 10.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          // Divider(color: Colors.white)
        ],
      ),
    );
  }
}

class _Favoritos extends StatelessWidget {
  const _Favoritos({
    Key? key,
    required this.scrollController,
    required this.favoritos,
    required this.onExpansionChanged,
    required this.onItemSelected,
    required bool isFavoritesOpen,
  })   : _isFavoritesOpen = isFavoritesOpen,
        super(key: key);

  final List<PtoRefData> favoritos;
  final void Function(bool)? onExpansionChanged;
  final bool _isFavoritesOpen;
  final ScrollController scrollController;
  final void Function(PtoRefData) onItemSelected;

  @override
  Widget build(BuildContext context) {
    return _isFavoritesOpen
        ? Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SingleChildScrollView(
                child: ExpansionTile(
                  initiallyExpanded: true,
                  tilePadding: EdgeInsets.zero,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star_border_outlined,
                        color: Palette.blanco,
                      ),
                      const SizedBox(width: 8.0),
                      FittedBox(
                        child: Text(
                          'Ver mis favoritos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Palette.blanco,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: _isFavoritesOpen
                      ? Icon(
                          Icons.arrow_drop_up_sharp,
                          color: Palette.blanco,
                          size: 48,
                        )
                      : Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Palette.blanco,
                          size: 48,
                        ),
                  onExpansionChanged: onExpansionChanged,
                  children: favoritos
                      .map((value) => _ItemFavorites(
                            ptoRefData: value,
                            onTap: () => onItemSelected(value),
                          ))
                      .toList(),
                ),
              ),
            ),
          )
        : ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.star_border_outlined,
                  color: Palette.blanco,
                ),
                const SizedBox(width: 8.0),
                FittedBox(
                  child: Text(
                    'Ver mis favoritos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Palette.blanco,
                    ),
                  ),
                ),
              ],
            ),
            trailing: _isFavoritesOpen
                ? Icon(
                    Icons.arrow_drop_up_sharp,
                    color: Palette.blanco,
                    size: 48,
                  )
                : Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Palette.blanco,
                    size: 48,
                  ),
            onExpansionChanged: onExpansionChanged,
            // children: favoritos
            //     .map((value) => _ItemFavorites(
            //           ptoRefData: value,
            //           onTap: () => onItemSelected(value),
            //         ))
            //     .toList(),
          );
  }
}

class _ItemFavorites extends StatelessWidget {
  const _ItemFavorites({
    Key? key,
    required this.ptoRefData,
    required this.onTap,
  }) : super(key: key);

  final PtoRefData ptoRefData;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: FittedBox(
          child: Text(
            ptoRefData.direccion!,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _BottomButtons extends StatelessWidget {
  const _BottomButtons({
    Key? key,
    required this.onPressedAgregarDatos,
    required this.onPressedPedirViaje,
  }) : super(key: key);

  final void Function() onPressedAgregarDatos;
  final void Function() onPressedPedirViaje;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: MakerButton(
              label: 'Agregar datos',
              isPrimary: false,
              isPrincipal: false,
              padding: EdgeInsets.zero,
              internalPadding: const EdgeInsets.symmetric(vertical: 9.0),
              onPressed: onPressedAgregarDatos,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: MakerButton(
              label: 'Pedir viaje',
              isPrincipal: false,
              padding: EdgeInsets.zero,
              internalPadding: const EdgeInsets.symmetric(vertical: 9.0),
              onPressed: onPressedPedirViaje,
            ),
          ),
        ],
      ),
    );
  }
}
