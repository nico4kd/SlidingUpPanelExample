import 'package:flutter/material.dart';

import 'package:slidingup_panel_example/main.dart';
import 'package:slidingup_panel_example/widget/main_image_widget.dart';
import 'package:slidingup_panel_example/widget/panel_direccion.dart';
import 'package:slidingup_panel_example/widget/panel_inicio.dart';
import 'package:slidingup_panel_example/widget/panels.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Panels panelType;

  @override
  void initState() {
    super.initState();
    panelType = Panels.inicio;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
          elevation: 2,
        ),
        body: panelType == Panels.inicio
            ? PanelInicio(
                onChangePanelType: _changePanelType,
                child: MainImageWidget(),
              )
            : panelType == Panels.direccion
                ? PanelDireccion(
                    onChangePanelType: _changePanelType,
                    child: MainImageWidget(),
                  )
                : SizedBox(),
      );

  void _changePanelType(Panels value) => setState(() {
        panelType = value;
      });
}
