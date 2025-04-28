import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:provider/provider.dart';

class ProviderPage extends StatefulWidget implements NameProvider {
  static const String _name = "Provider";
  @override
  String get name => _name;

  const ProviderPage({super.key});

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _ChangeNotifierModel()),
        ChangeNotifierProvider(create: (_) => _SelectorModel()),
        StreamProvider<String>(
          create: (_) => _StreamModel().getTimeStream(),
          initialData: '等待数据...',
        ),
        // 使用 ProxyProvider3 组合了三个不同来源的数据
        ProxyProvider3<
          _ChangeNotifierModel,
          _SelectorModel,
          String,
          _CombinedModel
        >(
          update:
              (_, counter, selector, time, __) =>
                  _CombinedModel(counter.count, selector.message, time),
        ),
        FutureProvider<_FutureAsyncData>(
          create: (_) => _FutureModel().fetchData(),
          initialData: _FutureAsyncData('加载中...'),
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            Consumer<_ChangeNotifierModel>(
              builder: (context, model, child) {
                //print("build. model每次变化，每次都出现");
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Count: ${model.count}", // 直接使用 model
                      style: const TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        model.increment(); // 直接使用 model
                      },
                      child: const Text("Consumer<ChangeNotifierModel>"),
                    ),
                    child!,
                  ],
                );
              },
              child: Builder(
                builder: (_) {
                  // print("build. 只应该出现一次。 model每次变化，也不会build");
                  return Text("一个不变的文本");
                },
              ),
            ),
            // 直接使用 ChangeNotifierProvider 和 Consumer
            // ChangeNotifierProvider(
            //   create: (context) => _ChangeNotifierModel(),
            //   child: Consumer<_ChangeNotifierModel>(
            //     builder: (context, model, child) {
            //       return Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             "Count: ${model.count}", // 直接使用 model
            //             style: const TextStyle(fontSize: 20),
            //           ),
            //           SizedBox(width: 10),
            //           ElevatedButton(
            //             onPressed: () {
            //               model.increment(); // 直接使用 model
            //             },
            //             child: const Text("Consumer<ChangeNotifierModel>"),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            Divider(),
            Selector<_SelectorModel, String>(
              selector: (context, model) => model.message, // 只关注 message 的变化
              builder: (context, message, child) {
                //print('Selector builder 被调用'); // 用于观察重建
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Message: $message",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<_SelectorModel>().updateMessage();
                      },
                      child: const Text("_SelectorModel:更新消息(只关注message)"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // 更新计数但不会触发重建
                        context.read<_SelectorModel>().updateCount();
                      },
                      child: const Text("_SelectorModel:更新计数"),
                    ),
                  ],
                );
              },
            ),
            // 直接使用 ChangeNotifierProvider 和 Consumer
            // ChangeNotifierProvider(
            //   create: (context) => _SelectorModel(),
            //   child: Selector<_SelectorModel, String>(...),
            // ),
            Divider(),
            Consumer<String>(
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "StreamProvider:Stream数据: $value",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                );
              },
            ),
            // StreamProvider<String>(
            //   create: (context) => _StreamModel().getTimeStream(),
            //   initialData: '等待数据...',
            //   child: Consumer<String>(...),
            // ),
            Divider(),
            Consumer<_CombinedModel>(
              builder: (context, combined, _) {
                return Column(
                  children: [
                    Text(
                      "ProxyProvider组合数据:",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "计数: ${combined.count}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "消息: ${combined.message}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "时间: ${combined.time}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                );
              },
            ),
            Divider(),
            // 精确匹配类型来区分Provider
            Consumer<_FutureAsyncData>(
              builder: (context, futureData, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "FutureProvider:异步数据: ${futureData.value}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////// Models ///////////////////////////////////////////////////
class _ChangeNotifierModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;

    notifyListeners();
  }
}

class _SelectorModel extends ChangeNotifier {
  String _message = '初始消息';
  int _count = 0;

  String get message => _message;
  int get count => _count;

  void updateMessage() {
    _message = '更新的消息 ${DateTime.now().millisecond}';
    notifyListeners();
  }

  void updateCount() {
    _count++;
    notifyListeners();
  }
}

class _StreamModel {
  Stream<String> getTimeStream() {
    return Stream.periodic(
      const Duration(seconds: 1),
      (count) => '当前时间: ${DateTime.now().toString().split('.').first}',
    );
  }
}

class _CombinedModel {
  final int count;
  final String message;
  final String time;

  _CombinedModel(this.count, this.message, this.time);

  @override
  String toString() => 'Count: $count, Message: $message, Time: $time';
}

class _FutureModel {
  Future<_FutureAsyncData> fetchData() async {
    await Future.delayed(const Duration(seconds: 2)); // 模拟网络请求延迟
    return _FutureAsyncData('异步加载完成的数据');
  }
}

class _FutureAsyncData {
  final String value;
  _FutureAsyncData(this.value);
}
