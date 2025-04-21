import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class AsyncUpdateUIPage extends StatefulWidget implements NameProvider {
  static const String _name = "AsyncUpdateUI";
  @override
  String get name => _name;

  const AsyncUpdateUIPage({super.key});

  @override
  State<AsyncUpdateUIPage> createState() => _AsyncUpdateUIPageState();
}

class _AsyncUpdateUIPageState extends State<AsyncUpdateUIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("FutureBuilder"),
          FutureBuilder<String>(
            future: _mockNetworkData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // 实际开发时注意缓存，避免每次都build=>远程请求
              // 请求已结束
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // 请求失败，显示错误
                  return Text("Error: ${snapshot.error}");
                } else {
                  // 请求成功，显示数据
                  return Text("Contents: ${snapshot.data}");
                }
              } else {
                // 请求未结束，显示loading
                return CircularProgressIndicator();
              }
            },
          ),
          Divider(),
          const Text("StreamBuilder"),
          StreamBuilder<int>(
            stream: _counter(), //
            //initialData: ,// a Stream<int> or null
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('没有Stream');
                case ConnectionState.waiting:
                  return Text('等待数据...');
                case ConnectionState.active:
                  return Text('active: ${snapshot.data}');
                case ConnectionState.done:
                  return Text('Stream 已关闭');
              }
              // unreachable
            },
          ),
        ],
      ),
    );
  }
}

Future<String> _mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
}

Stream<int> _counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}
