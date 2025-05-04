import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

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

  // dropdown menu
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  ColorLabel? selectedColor;
  IconLabel? selectedIcon;

  // menu anchor
  MenuEntry? _lastSelection;
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
  ShortcutRegistryEntry? _shortcutsEntry;

  // context menu
  final MenuController _menuController = MenuController();
  bool _menuWasEnabled = false;

  // slider
  double _currentSliderValue = 20;

  // SegmentBtn
  late Set<String> selection;

  Color get backgroundColor => _backgroundColor;
  Color _backgroundColor = Colors.red;
  set backgroundColor(Color value) {
    if (_backgroundColor != value) {
      setState(() {
        _backgroundColor = value;
      });
    }
  }

  bool get showingMessage => _showingMessage;
  bool _showingMessage = false;
  set showingMessage(bool value) {
    if (_showingMessage != value) {
      setState(() {
        _showingMessage = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _disableContextMenu(); // for context menu

    selection = <String>{_sizes.first, _sizes.last};
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Dispose of any previously registered shortcuts, since they are about to
    // be replaced.
    _shortcutsEntry?.dispose();
    // Collect the shortcuts from the different menu selections so that they can
    // be registered to apply to the entire app. Menus don't register their
    // shortcuts, they only display the shortcut hint text.
    final Map<ShortcutActivator, Intent> shortcuts =
        <ShortcutActivator, Intent>{
          for (final MenuEntry item in MenuEntry.values)
            if (item.shortcut != null)
              item.shortcut!: VoidCallbackIntent(() => _activate(item)),
        };
    // Register the shortcuts with the ShortcutRegistry so that they are
    // available to the entire application.
    _shortcutsEntry = ShortcutRegistry.of(context).addAll(shortcuts);
  }

  @override
  void dispose() {
    _shortcutsEntry?.dispose();
    _buttonFocusNode.dispose();

    _reenableContextMenu(); // for context menu

    super.dispose();
  }

  Future<void> _disableContextMenu() async {
    if (!kIsWeb) {
      // Does nothing on non-web platforms.
      return;
    }
    _menuWasEnabled = BrowserContextMenu.enabled;
    if (_menuWasEnabled) {
      await BrowserContextMenu.disableContextMenu();
    }
  }

  void _reenableContextMenu() {
    if (!kIsWeb) {
      // Does nothing on non-web platforms.
      return;
    }
    if (_menuWasEnabled && !BrowserContextMenu.enabled) {
      BrowserContextMenu.enableContextMenu();
    }
  }

  void _activate(MenuEntry selection) {
    setState(() {
      _lastSelection = selection;
    });

    switch (selection) {
      case MenuEntry.about:
        showAboutDialog(
          context: context,
          applicationName: 'MenuBar Sample',
          applicationVersion: '1.0.0',
        );
      case MenuEntry.hideMessage:
      case MenuEntry.showMessage:
        showingMessage = !showingMessage;
      case MenuEntry.colorMenu:
        break;
      case MenuEntry.colorRed:
        backgroundColor = Colors.red;
      case MenuEntry.colorGreen:
        backgroundColor = Colors.green;
      case MenuEntry.colorBlue:
        backgroundColor = Colors.blue;
    }
  }

  void _handleSecondaryTapDown(TapDownDetails details) {
    _menuController.open(position: details.localPosition);
  }

  void _handleTapDown(TapDownDetails details) {
    if (_menuController.isOpen) {
      _menuController.close();
      return;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        // Don't open the menu on these platforms with a Ctrl-tap (or a
        // tap).
        break;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        // Only open the menu on these platforms if the control button is down
        // when the tap occurs.
        if (HardwareKeyboard.instance.logicalKeysPressed.contains(
              LogicalKeyboardKey.controlLeft,
            ) ||
            HardwareKeyboard.instance.logicalKeysPressed.contains(
              LogicalKeyboardKey.controlRight,
            )) {
          _menuController.open(position: details.localPosition);
        }
    }
  }

  Widget _buildContextMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onSecondaryTapDown: _handleSecondaryTapDown,
        child: MenuAnchor(
          controller: _menuController,
          menuChildren: <Widget>[
            MenuItemButton(
              child: Text(MenuEntry.about.label),
              onPressed: () => _activate(MenuEntry.about),
            ),
            if (_showingMessage)
              MenuItemButton(
                onPressed: () => _activate(MenuEntry.hideMessage),
                shortcut: MenuEntry.hideMessage.shortcut,
                child: Text(MenuEntry.hideMessage.label),
              ),
            if (!_showingMessage)
              MenuItemButton(
                onPressed: () => _activate(MenuEntry.showMessage),
                shortcut: MenuEntry.showMessage.shortcut,
                child: Text(MenuEntry.showMessage.label),
              ),
            SubmenuButton(
              menuChildren: <Widget>[
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorRed),
                  shortcut: MenuEntry.colorRed.shortcut,
                  child: Text(MenuEntry.colorRed.label),
                ),
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorGreen),
                  shortcut: MenuEntry.colorGreen.shortcut,
                  child: Text(MenuEntry.colorGreen.label),
                ),
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorBlue),
                  shortcut: MenuEntry.colorBlue.shortcut,
                  child: Text(MenuEntry.colorBlue.label),
                ),
              ],
              child: const Text('Background Color'),
            ),
          ],
          child: Container(
            alignment: Alignment.center,
            color: backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Right-click anywhere on the background to show the menu.',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    showingMessage ? 'Default message' : '',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Text(
                  _lastSelection != null
                      ? 'Last Selected: ${_lastSelection!.label}'
                      : '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuAnchor(
          childFocusNode: _buttonFocusNode,
          menuChildren: <Widget>[
            MenuItemButton(
              leadingIcon: Icon(Icons.home),
              child: Text(MenuEntry.about.label),
              onPressed: () => _activate(MenuEntry.about),
            ),
            if (_showingMessage)
              MenuItemButton(
                onPressed: () => _activate(MenuEntry.hideMessage),
                shortcut: MenuEntry.hideMessage.shortcut,
                child: Text(MenuEntry.hideMessage.label),
              ),
            if (!_showingMessage)
              MenuItemButton(
                onPressed: () => _activate(MenuEntry.showMessage),
                shortcut: MenuEntry.showMessage.shortcut,
                child: Text(MenuEntry.showMessage.label),
              ),
            SubmenuButton(
              menuChildren: <Widget>[
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorRed),
                  shortcut: MenuEntry.colorRed.shortcut,
                  child: Text(MenuEntry.colorRed.label),
                ),
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorGreen),
                  shortcut: MenuEntry.colorGreen.shortcut,
                  child: Text(MenuEntry.colorGreen.label),
                ),
                MenuItemButton(
                  trailingIcon: Icon(Icons.border_color),
                  onPressed: () => _activate(MenuEntry.colorBlue),
                  shortcut: MenuEntry.colorBlue.shortcut,
                  child: Text(MenuEntry.colorBlue.label),
                ),
              ],
              child: const Text('Background Color'),
            ),
          ],
          builder: (
            BuildContext context,
            MenuController controller,
            Widget? child,
          ) {
            return TextButton(
              focusNode: _buttonFocusNode,
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              child: const Text('OPEN MENU'),
            );
          },
        ),

        Container(
          alignment: Alignment.center,
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  showingMessage ? 'default message' : '',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Text(
                _lastSelection != null
                    ? 'Last Selected: ${_lastSelection!.label}'
                    : '',
              ),
            ],
          ),
        ),
      ],
    );
  }

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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownMenu<ColorLabel>(
                    initialSelection: ColorLabel.green,
                    controller: colorController,
                    // requestFocusOnTap is enabled/disabled by platforms when it is null.
                    // On mobile platforms, this is false by default. Setting this to true will
                    // trigger focus request on the text field and virtual keyboard will appear
                    // afterward. On desktop platforms however, this defaults to true.
                    requestFocusOnTap: true,
                    label: const Text('Color'),
                    onSelected: (ColorLabel? color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    dropdownMenuEntries: ColorLabel.entries,
                  ),
                  const SizedBox(width: 24),
                  DropdownMenu<IconLabel>(
                    controller: iconController,
                    enableFilter: false,
                    enableSearch: false,
                    requestFocusOnTap: true,
                    leadingIcon: const Icon(Icons.search),
                    label: const Text('Icon'),
                    menuStyle: MenuStyle(
                      elevation: WidgetStateProperty.all(4.0), // 可选：添加菜单阴影
                    ),
                    inputDecorationTheme: const InputDecorationTheme(
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                    ),
                    onSelected: (IconLabel? icon) {
                      setState(() {
                        selectedIcon = icon;
                      });
                    },
                    dropdownMenuEntries: IconLabel.entries,
                  ),
                ],
              ),
              if (selectedColor != null && selectedIcon != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You selected a ${selectedColor?.label} ${selectedIcon?.label}',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        selectedIcon?.icon,
                        color: selectedColor?.color,
                      ),
                    ),
                  ],
                )
              else
                const Text('Please select a color and an icon.'),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMenuButton(context),
                  _buildContextMenu(context),
                ],
              ),
              Divider(),
              Container(
                alignment: Alignment.centerLeft,
                width: 500,
                child: Slider(
                  value: _currentSliderValue,
                  max: 100,
                  divisions: 5,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Badge(
                      label: Text('My label'),
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.receipt),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 100),
                  IconButton(
                    icon: Badge.count(
                      count: 9999,
                      child: const Icon(Icons.notifications),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Divider(),
              Container(
                alignment: Alignment.center,
                child: SegmentedButton<String>(
                  style: SegmentedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.red,
                    selectedForegroundColor: Colors.white,
                    selectedBackgroundColor: Colors.green,
                  ),
                  segments:
                      _sizes.map((s) {
                        return ButtonSegment<String>(
                          value: s,
                          label: Text(s),
                          icon: Icon(Icons.flag_circle),
                        );
                      }).toList(),
                  selected: selection,
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      selection = newSelection;
                    });
                  },
                  multiSelectionEnabled: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

typedef ColorEntry = DropdownMenuEntry<ColorLabel>;

// DropdownMenuEntry labels and values for the first dropdown menu.
enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;

  static final List<ColorEntry> entries = UnmodifiableListView<ColorEntry>(
    values.map<ColorEntry>(
      (ColorLabel color) => ColorEntry(
        value: color,
        label: color.label,
        enabled: color.label != 'Grey',
        style: MenuItemButton.styleFrom(foregroundColor: color.color),
      ),
    ),
  );
}

typedef IconEntry = DropdownMenuEntry<IconLabel>;

// DropdownMenuEntry labels and values for the second dropdown menu.
enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud('Cloud', Icons.cloud_outlined),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;

  static final List<IconEntry> entries = UnmodifiableListView<IconEntry>(
    values.map<IconEntry>(
      (IconLabel icon) => IconEntry(
        value: icon,
        label: icon.label,
        leadingIcon: Icon(icon.icon),
      ),
    ),
  );
}

/// An enhanced enum to define the available menus and their shortcuts.
///
/// Using an enum for menu definition is not required, but this illustrates how
/// they could be used for simple menu systems.
enum MenuEntry {
  about('About'),
  showMessage(
    'Show Message',
    SingleActivator(LogicalKeyboardKey.keyS, control: true),
  ),
  hideMessage(
    'Hide Message',
    SingleActivator(LogicalKeyboardKey.keyS, control: true),
  ),
  colorMenu('Color Menu'),
  colorRed(
    'Red Background',
    SingleActivator(LogicalKeyboardKey.keyR, control: true),
  ),
  colorGreen(
    'Green Background',
    SingleActivator(LogicalKeyboardKey.keyG, control: true),
  ),
  colorBlue(
    'Blue Background',
    SingleActivator(LogicalKeyboardKey.keyB, control: true),
  );

  const MenuEntry(this.label, [this.shortcut]);
  final String label;
  final MenuSerializableShortcut? shortcut;
}
