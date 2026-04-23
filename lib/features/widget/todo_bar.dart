import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/model/task.dart';

class TodoBar extends StatefulWidget {
  const TodoBar({super.key});

  @override
  State<TodoBar> createState() => _TodoBarState();
}

List<Task> tasks = [
  Task(
    id: "1",
    description: "Schedule equipment maintenance",
    dueDate: "Today",
    isCompleted: false,
  ),
  Task.create(
    id: "2",
    description: "Review crop rotation plan",
    dueDate: "Tomorrow",
    isCompleted: false,
  ),
  Task(
    id: "3",
    description: "Prepare monthly yield report",
    dueDate: "3 Days",
    isCompleted: false,
  ),
  Task(
    id: "4",
    description: "Order new seeds for next season",
    dueDate: "1 Weeks",
    isCompleted: false,
  ),
];

class _TodoBarState extends State<TodoBar> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.mainWhite,
        border: Border.all(
          color: AppColor.mainGray.withValues(alpha: 0.5),
          width: 2,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          const Text(
            'قائمة المهام',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: "Cairo",
            ),
          ),

          SizedBox(
            width: double.infinity,
            height: 300,
            child: tasks.isNotEmpty
                ?
                  //task list is not empty
                  ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      //container of each task
                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        onDismissed: (_) {
                          ///remove the current task
                        },
                        //give a unique key to each task
                        key: UniqueKey(),
                        background: const Icon(
                          Icons.delete,
                          color: AppColor.mainGold,
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const BoxDecoration(
                            color: AppColor.mainWhite,
                          ),

                          //listTile used for constant layout of each item
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),

                            //check Icon
                            leading: GestureDetector(
                              onTap: () {
                                //check and uncheck the task
                                setState(() {
                                  tasks[index].isCompleted =
                                      !tasks[index].isCompleted;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(microseconds: 600),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: tasks[index].isCompleted
                                    ? const Icon(
                                        Icons.check,
                                        color: AppColor.primeryColor,
                                      )
                                    : const Icon(
                                        Icons.check_box_outline_blank,
                                        color: Colors.white,
                                      ),
                              ),
                            ),

                            //task content
                            title: Row(
                              children: [
                                //Task Descrption
                                SizedBox(
                                  width: 185,
                                  child: Text(
                                    tasks[index].description,
                                    style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      // decoration: TextDecoration.lineThrough
                                    ),
                                  ),
                                ),
                                const Spacer(),

                                //Due Date
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    tasks[index].dueDate,
                                    style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      // decoration: TextDecoration.lineThrough
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                :
                  //all tasks are done
                  const SizedBox(
                    child: Center(
                      child: Text(
                        "You have done all tasks",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
