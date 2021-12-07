import 'package:final_project_devfest/components/appbarcomponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({Key? key}) : super(key: key);

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  TextEditingController amountOfMoneyTextField = TextEditingController();
  String _type = "revenue";
  TextEditingController descriptionTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Amount of money"),
                  controller: amountOfMoneyTextField,
                )),
            Row(
              children: [
                Expanded(
                    child: RadioListTile(
                        value: "revenue",
                        title: const Text("Revenue"),
                        groupValue: _type,
                        onChanged: (String? newValue) {
                          setState(() {
                            _type = newValue!;
                          });
                        })),
                Expanded(
                    child: RadioListTile(
                        value: "expenditure",
                        title: const Text("Expenditure"),
                        groupValue: _type,
                        onChanged: (String? newValue) {
                          setState(() {
                            _type = newValue!;
                          });
                        }))
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Description",
              ),
              controller: descriptionTextField,
              maxLines: 4,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Save"),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBarComponent(title: "Action Page"),
      ),
    );
  }
}
