

void main() {
  performTasks();
}

void performTasks() async{
  task1();
  String task2result = await task2();
  task3(task2result);
}

void task1() {
  print("Task1 is done");
}

Future task2() async{
  Duration threeSeconds = Duration(seconds: 3);

  String result = "";

  await Future.delayed(threeSeconds, () {
    result = "Task2 data";
    print("Task2 is done");
  });
  return result;
}

void task3(String task2data) {
  print("Task3 is done with $task2data");
}
