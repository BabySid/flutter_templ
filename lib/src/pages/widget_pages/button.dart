import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:flutter_teml/src/widgets/gradient_button.dart';

class WidgetButtonPage extends StatefulWidget implements NameProvider {
  static const String _name = "Button";
  @override
  String get name => _name;

  const WidgetButtonPage({super.key});

  @override
  State<WidgetButtonPage> createState() => _WidgetButtonPageState();
}

class _WidgetButtonPageState extends State<WidgetButtonPage> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  bool _isChipSelected = false; // chip
  int? _selectedSize;
  final List<String> _sizes = ["S", "M", "L", "XL"];

  // InputChip 数据
  final List<String> _features = ["防水", "透气", "轻量化", "耐穿", "轻便", "舒服"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("普通按钮")),
              TextButton(onPressed: () {}, child: const Text("文本按钮")),
              OutlinedButton(onPressed: () {}, child: const Text("边框按钮")),
              IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.send),
                label: const Text("发送"),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.info),
                label: const Text("消息"),
              ),
              OutlinedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.add),
                label: const Text("增加"),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red), //背景颜色
                  foregroundColor: WidgetStateProperty.all(
                    Colors.white,
                  ), //文字图标颜色
                ),
                onPressed: () {},
                child: const Text("背景和前景的普通按钮"),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 60,
                width: 140,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("修改宽高的普通按钮"),
                ),
              ),
              SizedBox(
                height: 60,
                width: 140,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  label: const Text("修改宽高的图标按钮"),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color.fromARGB(220, 245, 71, 71),
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    child: const Text("自适应按钮"),
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  elevation: WidgetStateProperty.all(20),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text("圆角按钮"),
              ),
              SizedBox(
                height: 80,
                width: 80,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(20),
                    shape: WidgetStateProperty.all(
                      const CircleBorder(
                        side: BorderSide(width: 2, color: Colors.red),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("圆形按钮"),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                style: ButtonStyle(
                  side: WidgetStateProperty.all(
                    //修改边框颜色
                    const BorderSide(width: 1, color: Colors.red),
                  ),
                ),
                onPressed: () {},
                child: const Text("带边框的按钮"),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch(
                value: _switchSelected,
                onChanged: (value) {
                  setState(() {
                    _switchSelected = value;
                  });
                },
              ),
              const Text("单选框"),
              const SizedBox(width: 10),
              Checkbox(
                value: _checkboxSelected,
                onChanged: (value) {
                  setState(() {
                    _checkboxSelected = value ?? false;
                  });
                },
                semanticLabel: "复选框semanticLabel",
              ),
              const Text("复选框"),
            ],
          ),
          Divider(),
          Center(
            child: Material(
              type: MaterialType.transparency, //设置背景透明
              // 如独立使用，外层需要Material包装
              color: Colors.white,
              shape: RoundedRectangleBorder(
                // 关键2：同步圆角形状
                borderRadius: BorderRadius.circular(50),
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(50),
                splashColor: Colors.blue,
                child: Container(
                  constraints: BoxConstraints(minWidth: 0), // 允许收缩到最小宽度
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        "InkWell点赞",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Chip(
                label: Text("基本Chip"),
                avatar: Icon(Icons.person), // 左侧图标
                onDeleted: () {},
                deleteIcon: Icon(Icons.cancel), // 自定义删除图标
              ),
              FilterChip(
                label: Text("可交互的Chip"),
                selected: _isChipSelected,
                onSelected: (bool selected) {
                  setState(() {
                    _isChipSelected = selected;
                  });
                },
                selectedColor: Colors.red,
                checkmarkColor: Colors.blue, // 选中状态的勾选图标颜色
              ),
              Chip(
                label: Text("自定义样式Chip"),
                backgroundColor: Colors.orange[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.orange),
                ),
              ),
              ActionChip(
                label: Text("Chip点击动作"),
                onPressed: () {},
                pressElevation: 5, // 点击时的阴影效果
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:
                _sizes.map((size) {
                  return ChoiceChip(
                    label: Text(size),
                    selected: _selectedSize == _sizes.indexOf(size),
                    onSelected: (selected) {
                      setState(() {
                        _selectedSize = selected ? _sizes.indexOf(size) : null;
                      });
                    },
                    selectedColor: Colors.green[100], // 选中背景色
                    checkmarkColor: Colors.green, // 勾选图标颜色
                    shape: StadiumBorder(side: BorderSide(color: Colors.green)),
                  );
                }).toList(),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children:
                _features.map((feature) {
                  return InputChip(
                    label: Text(feature),
                    avatar: Icon(Icons.abc),
                    onDeleted: () {
                      setState(() {
                        _features.remove(feature);
                      });
                    },
                  );
                }).toList(),
          ),

          Divider(),
        ],
      ),
    );
  }
}
