 import 'package:flutter/material.dart';
 import 'package:myapp/models/todo.dart';

 class Todolist extends StatefulWidget {
   const Todolist({super.key});

   @override
   State<Todolist> createState() => _TodolistState();
 }

 final GlobalKey<FormState> formKey = GlobalKey<FormState>();
 late String title;
 List<Todo> todoList = [];

 AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

 final myController = TextEditingController();

 final TextFormField1 = TextEditingController();
 final TextFormField2 = TextEditingController();
 final TextFormField3 = TextEditingController();
 final TextFormField4 = TextEditingController();
 final TextFormField5 = TextEditingController();
 final TextFormField6 = TextEditingController();


 @override
 void dispose() {
   myController.dispose();
 }

 class _TodolistState extends State<Todolist> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       floatingActionButton: FloatingActionButton(
           onPressed: addTodo, child: const Icon(Icons.add)),
       drawer: const Drawer(),
       appBar: AppBar(
         title: const Text('Todo List'),
         actions: const [
           Icon(Icons.settings),
           SizedBox(
             width: 5,
           )
         ],
       ),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Expanded(
             flex: 1,
             child: Container(
               padding: const EdgeInsets.all(10),
               alignment: Alignment.center,
               color: Colors.grey,
               child: Form(
                 key: formKey,
                 child: TextFormField(
                   controller: myController,
                   autovalidateMode: autovalidateMode,
                   onSaved: (newValue) {
                     title = newValue!;
                   },
                   validator: (value) {
                     if (value!.isEmpty) {
                       return "Boş geçilemez!!";
                     } else {
                       return null;
                     }
                   },
                   decoration: const InputDecoration(
                       labelText: "Başlık", hintText: "Başlık giriniz"),
                 ),
               ),
             ),
           ),
           Expanded(
               flex: 3,
               child: Container(
                 padding: const EdgeInsets.all(10),
                 alignment: Alignment.topCenter,
                 child: ListView.separated(
                     separatorBuilder: (context, index) => const Divider(
                           height: 5,
                           color: Colors.transparent,
                         ),
                     padding: const EdgeInsets.all(5),
                     itemCount: todoList.length,
                     itemBuilder: (context, index) {
                       Todo item = todoList[index];
                       return ListTile(
                           tileColor: item.isComplated
                               ? Colors.green[100]
                               : Colors.red[100],
                           subtitle: const Text("Tıkla Ve Tamamla"),
                           leading: Checkbox(
                             activeColor: Colors.green[100],
                             checkColor: Colors.black,
                             onChanged: (value) {
                               setState(() {
                                 item.isComplated = value!;
                               });
                             },
                             value: item.isComplated,
                           ),
                           trailing: IconButton(
                             onPressed: () {
                               setState(() {
                                 todoList.remove(item);
                               });
                             },
                             icon: const Icon(Icons.delete),
                           ),
                           title: Text(
                             "${item.id} - ${item.Title}",
                             style: item.isComplated
                                 ? const TextStyle(
                                     decoration: TextDecoration.lineThrough)
                                 : const TextStyle(),
                           ));
                     }),
               ))
         ],
       ),
     );
   }

   void addTodo() {
     if (formKey.currentState!.validate()) {
       formKey.currentState!.save();
       setState(() {
         todoList.add(Todo(
             id: todoList.isNotEmpty ? todoList.last.id + 1 : 1,
             Title: title,
             isComplated: false));
       });

       debugPrint(const Todolist().toString());
       alertSuccess();
       formKey.currentState!.reset();
     } else {
       setState(() {
         autovalidateMode = AutovalidateMode.always;
       });
     }
   }

   void alertSuccess() {
     showDialog(
         context: context,
         builder: (context) => AlertDialog(
               actionsAlignment: MainAxisAlignment.center,
               actions: [
                 TextButton(
                     onPressed: () {
                       Navigator.pop(context);
                     },
                     child: const Text("Kapat"))
               ],
               content: SizedBox(
                 height: 100,
                 child: Column(
                   children: [
                     const Icon(
                       Icons.check_circle,
                       color: Colors.green,
                       size: 72,
                     ),
                     Container(
                         margin: const EdgeInsets.only(top: 5),
                         child: const Text("Kayıt Eklendi!")),
                   ],
                 ),
               ),
             ));
   }
 }
