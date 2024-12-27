import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_methods/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('Testing App Performance', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    // This test scrolls through the list of items really fast and then scrolls all the way up.
    testWidgets('Scrolling test', (tester) async {
      await tester.pumpWidget(const TestingApp());

      final listFinder = find.byType(ListView);

      // The traceAction() function records the actions and generates a timeline summary.
      await binding.traceAction(
        () async {
          await tester.fling(listFinder, const Offset(0, -500), 10000);
          await tester.pumpAndSettle();

          await tester.fling(listFinder, const Offset(0, 500), 10000);
          await tester.pumpAndSettle();
        },
        reportKey: 'scrolling_summary',
      );
    });
  });
}

// After adding the test_driver directory and the perf_driver.dart inside it,
// Start the emulator then, run the following command:
// flutter drive --driver=test_driver/perf_driver.dart --target=integration_test/perf_test.dart --profile --no-dds

/*
  After the test completes successfully, the build directory at the root of the project contains two files:
  1- scrolling_summary.timeline_summary.json contains the summary. Open the file with any text editor to review the information contained within.
  2- scrolling_summary.timeline.json contains the complete timeline data.
*/
