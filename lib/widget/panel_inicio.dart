import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:slidingup_panel_example/widget/panels.dart';

import 'main_image_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: panelController,
      maxHeight: MediaQuery.of(context).size.height * 0.5,
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
          height: 900,
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => onChangePanelType(Panels.direccion),
                  child: Text(
                    'To Dirección',
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
