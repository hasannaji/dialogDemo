import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class LoginX extends GetxController {
  RxBool result = false.obs;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LoginX lx = Get.put(LoginX());
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                 onPressed: () async {
                  // ** assign return value to an observable **
                  return lx.result.value = await Get.dialog(
                      
                           Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                                  RaisedButton(
                                    child: Text('Good Login'),
                                    onPressed: () => Get.back(result: true),
                                    // ** result: returns this value up the call stack **
                                  ),
                                  SizedBox(width: 5,),
                                  RaisedButton(
                                    child: Text('Bad Login'),
                                    onPressed: () => Get.back(result: false),
                                  ),
                             ],
                           )
                  );},
               
                child: const Text('Login'),
            ),
            Obx(() =>Text(lx.result.value.toString(),),),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}




class GetDialogReturnPage extends StatelessWidget {
  final LoginX lx = Get.put(LoginX());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetDialog Return Example'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Obx(() => Text('Value shows here: ${lx.result.value}')),
            ),
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                child: Text('Login'),
                onPressed: () async {
                  // ** assign return value to an observable **
                  return lx.result.value = await Get.dialog(
                      AlertDialog(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                child: Text('Good Login'),
                                onPressed: () => Get.back(result: true),
                                // ** result: returns this value up the call stack **
                              ),
                              SizedBox(width: 5,),
                              RaisedButton(
                                child: Text('Bad Login'),
                                onPressed: () => Get.back(result: false),
                              ),
                            ],
                          )
                      )
                  );},
              ),
            )

          ],
        ),
      ),
    );
  }
}