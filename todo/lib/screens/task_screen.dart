import 'package:flutter/material.dart';

class Task {
  String title;
  String description;
  String dayGroup;
  String priority;
  bool completed;

  Task({
    required this.title,
    required this.description,
    required this.dayGroup,
    required this.priority,
    this.completed = false,
  });
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Map<String, List<Task>> groupedTasks = {
    "Today": [
      Task(
        title: "Schedule dentist appointment",
        description: "Visit Dr. John soon",
        dayGroup: "Today",
        priority: "High",
      ),
      Task(
        title: "Prepare Team Meeting",
        description: "Discuss new project scope",
        dayGroup: "Today",
        priority: "Low",
      ),
    ],
    "Tomorrow": [
      Task(
        title: "Call Charlotte",
        description: "Confirm dinner plans",
        dayGroup: "Tomorrow",
        priority: "Medium",
      ),
      Task(
        title: "Write Exercise 3.1",
        description: "Finish code exercises",
        dayGroup: "Tomorrow",
        priority: "High",
      ),
    ],
    "This Week": [
      Task(
        title: "Submit exercise 3.2",
        description: "Project tasks in detail",
        dayGroup: "This Week",
        priority: "Medium",
      ),
      Task(
        title: "Water plants",
        description: "Every two days",
        dayGroup: "This Week",
        priority: "Low",
      ),
    ],
  };

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    String selectedDay = "Today";
    String selectedPriority = "Low";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text("Add Task"),
            content: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration:
                          const InputDecoration(labelText: "Task Title"),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(labelText: "Description"),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedDay,
                      onChanged: (value) {
                        setDialogState(() {
                          selectedDay = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(value: "Today", child: Text("Today")),
                        DropdownMenuItem(
                            value: "Tomorrow", child: Text("Tomorrow")),
                        DropdownMenuItem(
                            value: "This Week", child: Text("This Week")),
                      ],
                      decoration: const InputDecoration(labelText: "Day"),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedPriority,
                      onChanged: (value) {
                        setDialogState(() {
                          selectedPriority = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(value: "Low", child: Text("Low")),
                        DropdownMenuItem(
                            value: "Medium", child: Text("Medium")),
                        DropdownMenuItem(value: "High", child: Text("High")),
                      ],
                      decoration: const InputDecoration(labelText: "Priority"),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text("Add"),
                onPressed: () {
                  // Build the new task
                  final newTask = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    dayGroup: selectedDay,
                    priority: selectedPriority,
                  );

                  // Add it to the correct day group
                  setState(() {
                    groupedTasks[selectedDay]!.add(newTask);
                  });

                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
      },
    );
  }

  void _showEditTaskDialog(Task task) {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);

    String selectedDay = task.dayGroup;
    String selectedPriority = task.priority;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text("Edit Task"),
            content: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration:
                          const InputDecoration(labelText: "Task Title"),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(labelText: "Description"),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedDay,
                      onChanged: (value) {
                        setDialogState(() {
                          selectedDay = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(value: "Today", child: Text("Today")),
                        DropdownMenuItem(
                            value: "Tomorrow", child: Text("Tomorrow")),
                        DropdownMenuItem(
                            value: "This Week", child: Text("This Week")),
                      ],
                      decoration: const InputDecoration(labelText: "Day"),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedPriority,
                      onChanged: (value) {
                        setDialogState(() {
                          selectedPriority = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(value: "Low", child: Text("Low")),
                        DropdownMenuItem(
                            value: "Medium", child: Text("Medium")),
                        DropdownMenuItem(value: "High", child: Text("High")),
                      ],
                      decoration: const InputDecoration(labelText: "Priority"),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text("Save"),
                onPressed: () {
                  setState(() {
                    if (task.dayGroup != selectedDay) {
                      groupedTasks[task.dayGroup]!.remove(task);
                      task.dayGroup = selectedDay;
                      groupedTasks[selectedDay]!.add(task);
                    }

                    task.title = titleController.text;
                    task.description = descriptionController.text;
                    task.priority = selectedPriority;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
      },
    );
  }

  void _deleteTask(Task task) {
    setState(() {
      groupedTasks[task.dayGroup]!.remove(task);
    });
  }

  void _toggleCompletion(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  String _getDateForGroup(String dayGroup) {
    switch (dayGroup) {
      case "Today":
        return "1 May";
      case "Tomorrow":
        return "2 May";
      case "This Week":
        return "This Week";
      default:
        return "";
    }
  }

  Widget _buildTaskRow(Task task) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) => _deleteTask(task),
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // 1. Checkbox (circle style)
            InkWell(
              onTap: () => _toggleCompletion(task),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: task.completed ? Colors.deepPurple : Colors.grey,
                    width: 2,
                  ),
                ),
                child: task.completed
                    ? const Icon(Icons.check,
                        color: Colors.deepPurple, size: 18)
                    : const SizedBox(),
              ),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      decoration:
                          task.completed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    task.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      decoration:
                          task.completed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _getDateForGroup(task.dayGroup),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      decoration:
                          task.completed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),

            _buildPriorityChip(task.priority),
            const SizedBox(width: 8),

            InkWell(
              onTap: () => _showEditTaskDialog(task),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.blue, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityChip(String priority) {
    Color chipColor;
    switch (priority) {
      case "High":
        chipColor = Colors.red;
        break;
      case "Medium":
        chipColor = Colors.orange;
        break;
      case "Low":
      default:
        chipColor = Colors.green;
        break;
    }
    return Chip(
      label: Text(priority, style: const TextStyle(color: Colors.white)),
      backgroundColor: chipColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
        onPressed: _showAddTaskDialog, // Show "Add Task" dialog
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.list),
                color: Colors.deepPurple,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.calendar_month),
                color: Colors.grey,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF8A56AC),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.grid_view, color: Colors.white, size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: const [
                            SizedBox(width: 10),
                            Icon(Icons.search, color: Colors.white70),
                            SizedBox(width: 10),
                            Text(
                              "Search tasks...",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.more_vert, color: Colors.white, size: 28),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  "Today, 1 May",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "My tasks",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: groupedTasks.entries.map((entry) {
                  final dayLabel = entry.key;
                  final tasksList = entry.value;
                  return _buildTaskSection(dayLabel, tasksList);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskSection(String dayLabel, List<Task> tasksList) {
    if (tasksList.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dayLabel,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: tasksList.map((task) {
              return _buildTaskRow(task);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
