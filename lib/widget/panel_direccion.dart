import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:slidingup_panel_example/widget/panels.dart';

import 'main_image_widget.dart';

class PanelDireccion extends StatefulWidget {
  const PanelDireccion({
    Key? key,
    required this.onChangePanelType,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final void Function(Panels value) onChangePanelType;

  @override
  _PanelDireccionState createState() => _PanelDireccionState();
}

class _PanelDireccionState extends State<PanelDireccion> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: panelController,
      maxHeight: MediaQuery.of(context).size.height * 0.3,
      panelBuilder: (scrollController) => _SlidingPanel(
        scrollController: scrollController,
        panelController: panelController,
        onChangePanelType: widget.onChangePanelType,
      ),
      body: widget.child,
    );
  }
}

class _SlidingPanel extends StatelessWidget {
  const _SlidingPanel({
    Key? key,
    required this.panelController,
    required this.scrollController,
    required this.onChangePanelType,
  }) : super(key: key);

  final PanelController panelController;
  final ScrollController scrollController;
  final void Function(Panels value) onChangePanelType;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          height: 600,
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => onChangePanelType(Panels.inicio),
                  child: Text(
                    'To Inicio',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 60.0),
                MainImageWidget()
              ],
            ),
          ),
        );
      },
    );
  }
}
