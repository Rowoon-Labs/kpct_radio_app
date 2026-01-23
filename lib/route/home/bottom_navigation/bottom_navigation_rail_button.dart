import 'package:kpct_aspect_ratio/kpct_aspect_ratio.dart';
import 'package:kpct_cupertino_button/kpct_cupertino_button.dart';
import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpct_radio_app/app/asset/assets.gen.dart';
import 'package:kpct_radio_app/route/home/home_bloc.dart';
import 'package:kpct_radio_app/route/home/modal/full/chat/chat_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomNavigationRailButton extends StatelessWidget {
  final bool on;
  final HomePage page;

  const BottomNavigationRailButton({
    required this.page,
    required this.on,
    super.key,
  });

  @override
  Widget build(BuildContext context) => KpctAspectRatio(
    designWidth: 56,
    designHeight: 79,
    builder:
        (converter) => KpctCupertinoButton(
          pressedOpacity: 1,
          onPressed: () async {
            if (page != HomePage.chat) {
              context.read<HomeBloc>().add(
                HomeEvent.switchPage(context: context, page: page),
              );
            } else {
              await showMaterialModalBottomSheet(
                context: context,
                enableDrag: false,
                isDismissible: false,
                backgroundColor: Colors.transparent,
                builder: (context) => const ChatModal(),
              );
            }
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AssetGenImage(
                Assets.component.bottomNavigationRailIdleOn.path.replaceFirst(
                  "idle_on",
                  "${page.name.toSnakeCase()}_${on ? "on" : "off"}",
                ),
              ).image(
                width: converter.realSize.width,
                height: on ? converter.h(74.26) : converter.realSize.height,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
  );

  // Future<void> _uploadCsv() async {
  //   final String rawData = await rootBundle.loadString(Assets.csv.draw);
  //
  //   List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(rawData);
  //
  //   List<String>? header;
  //   for (List<dynamic> row in rowsAsListOfValues) {
  //     if (header == null) {
  //       header = List.of(row.map((element) => element.toString()));
  //     } else {
  //       final Map<String, dynamic> data = Map.fromIterables(header, row.map((element) {
  //         if (element is String && element.isEmpty) {
  //           return null;
  //         } else {
  //           return element;
  //         }
  //       }));
  //
  //       await FirebaseFirestore.instance.collection("reserved").doc("draw").collection("elements").add(data).catchError((error) {
  //         App.instance.log.d("ERROR");
  //       }).whenComplete(() {
  //         App.instance.log.d("DONE");
  //       });
  //     }
  //   }
  // }
}
