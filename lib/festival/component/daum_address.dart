import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DaumAddressScreen extends StatelessWidget {
  const DaumAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: Text('Find Korean Postal Address'),
          onPressed: () async {
            KopoModel model = await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => RemediKopo(),
              ),
            );

            print(model.zonecode);
            print(model.address);
            print(model.addressType);
            print(model.userSelectedType);
            print(model.roadAddress);
            print(model.jibunAddress);

          },
        ),
      ],
    );
  }
}

