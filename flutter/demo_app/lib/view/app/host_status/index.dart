import 'package:flutter/material.dart';
import 'package:flutter3/store/host_status_store.dart';
import 'package:get/get.dart';

class AppHostStatusIndex extends StatelessWidget {
  final dynamic params;

  const AppHostStatusIndex({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    final hostStatusStore = Get.put(HostStatusStore());

    return Scaffold(
      body: Obx(() {
        return ListView.separated(
          padding: EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final line = hostStatusStore.lines[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                // leading: _buildStatusIcon(line.status.value),
                leading: line.status.value == 'off' ? const Icon(Icons.help_outline, color: Colors.orange) : SignalBar(speed: line.speed.value, isOffline: line.status.value == 'off'),
                title: Text(line.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(_getStatusText(line)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    line.status.value == 'testing' ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : IconButton(icon: const Icon(Icons.refresh), onPressed: () => hostStatusStore.testLine(line)),
                    line.chosen.value? const Icon(Icons.check_circle, color: Colors.green):const Icon(Icons.circle_outlined, color: Colors.grey),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemCount: hostStatusStore.lines.length,
        );
      }),
    );
  }
}

Widget _buildStatusIcon(String status) {
  switch (status) {
    case 'online':
      return const Icon(Icons.check_circle, color: Colors.green);
    case 'off':
      return const Icon(Icons.cancel, color: Colors.red);
    case 'testing':
      return const Icon(Icons.sync, color: Colors.orange);
    default:
      return const Icon(Icons.help_outline, color: Colors.orange);
  }
}

String _getStatusText(LineStatus line) {
  switch (line.status.value) {
    case 'online':
      return '延迟: {value} ms'.trParams({"value": line.speed.value.toString()});
    case 'off':
      return '无法连接'.tr;
    case 'testing':
      return '测试中...'.tr;
    default:
      return '状态未知'.tr;
  }
}

class SignalBar extends StatelessWidget {
  final int speed; // ms 值
  final bool isOffline;
  final double width;
  final double heightStep;
  final int totalBars;

  const SignalBar({Key? key, required this.speed, this.isOffline = false, this.width = 4, this.heightStep = 4, this.totalBars = 5}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int activeBars = 0;
    Color activeColor = Colors.green;

    if (isOffline || speed >= 10000) {
      activeBars = 0;
      activeColor = Colors.red;
    } else if (speed < 80) {
      activeBars = 5;
      activeColor = Colors.green;
    } else if (speed < 150) {
      activeBars = 4;
      activeColor = Colors.lightGreen;
    } else if (speed < 300) {
      activeBars = 3;
      activeColor = Colors.orange;
    } else if (speed < 500) {
      activeBars = 2;
      activeColor = Colors.deepOrange;
    } else {
      activeBars = 1;
      activeColor = Colors.red;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(totalBars, (index) {
        bool isActive = index < activeBars;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 1),
          width: width,
          height: (index + 1) * heightStep,
          decoration: BoxDecoration(color: isActive ? activeColor : Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
        );
      }),
    );
  }
}
