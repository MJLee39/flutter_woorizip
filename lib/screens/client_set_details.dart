import 'package:flutter/material.dart';
import 'package:testapp/widgets/client/number_input_widget.dart';
import 'package:testapp/widgets/client/calendar_widget.dart';
import 'package:testapp/widgets/client/button_widget.dart';

class client_set_details_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Set Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const NumberInputWidget(),
            const SizedBox(height: 20),
            const CalendarWidget(),
            const SizedBox(height: 20),
            _buildButtonRows(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle confirmation button press
              },
              child: const Text('확인'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRows() {
    final List<Widget> buttonRows = [];
    for (int i = 0; i < 10; i++) {
      buttonRows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWidget(buttonNumber: i * 2 + 1),
          ButtonWidget(buttonNumber: i * 2 + 2),
        ],
      ));
    }
    return Column(children: buttonRows);
  }
}
