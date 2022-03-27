  // Your web app's Firebase configuration
  var firebaseConfig = {
      apiKey: "AIzaSyAXfFdtqZRV1RPcjlYlVBUll_FIchRgKLM",
      authDomain: "js-todo-database.firebaseapp.com",
      databaseURL: "https://js-todo-database.firebaseio.com",
      projectId: "js-todo-database",
      storageBucket: "js-todo-database.appspot.com",
      messagingSenderId: "779954646821",
      appId: "1:779954646821:web:69d3815a90bf6c94c534cc",
      measurementId: "G-F1YP355C5B"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  //   firebase.analytics();

  //   Firebase DB work 

  //   function addTodo() {

  //   }

  //   function task_edit_func() {
  //       task_edit_button
  //   }

  //   function task_delete_func() {
  //       task_delete_button
  //   }

  var list = document.getElementById("list");

  function addTodo() {
      var todo_item = document.getElementById("todo-input");
      //   id of add item button task_add_item

      if (todo_item.value.length != 0) {
          // Our input have data init and now we take this data into DB
          var key = firebase.database().ref().child("unfinished_task").push().key;
          //   Creating a OBJECT 
          var task = {
              title: todo_item.value,
              key: key
          };

          var updates = {};
          updates["/unfinished_task/" + key] = task;
          firebase.database().ref().update(updates);
      }


      function create_unfinished_task() {
          unfinished_task_container = document.getElementsByClassName("container")[0];
          unfinished_task_container.innerHTML = "";


          task_array = [];
          firebase.database().ref("unfinished_task").once('value', function(snapshot) {
              snapshot.forEach(function(childSnapshot) {
                  var childKey = childSnapshot.key;
                  var childData = childSnapshot.val();
                  task_array.push(Object.values(childData));
              });
              for (var i, i = 0; i < task_array.length; i++) {
                  task_key = task_array[i][0];
                  task_title = task_array[i][1];
              }
          });
      }



      // Creating li element with textNode 
      var li = document.createElement("li");
      var liText = document.createTextNode(todo_item.value);
      li.appendChild(liText);

      // Creating a delete button from js 

      var delBtn = document.createElement("button");
      var delText = document.createTextNode("DELETE");
      delBtn.setAttribute("class", "delBtn");
      delBtn.setAttribute("onclick", "deleteItem(this)");
      delBtn.setAttribute("id", "task_delete_button");
      delBtn.setAttribute("onclick", "task_delete_func()");
      delBtn.appendChild(delText);

      // Creating a edit button from js

      var editBtn = document.createElement("button");
      var editText = document.createTextNode("EDIT");
      editBtn.setAttribute("class", "Editbtn");
      editBtn.setAttribute("onclick", "editItem(this)");
      editBtn.setAttribute("id", "task_edit_button");
      editBtn.setAttribute("onclick", "task_edit_func()");
      editBtn.appendChild(editText);
      li.appendChild(editBtn);
      list.appendChild(li);

      li.appendChild(delBtn);
      list.appendChild(li);
      todo_item.value = "";
      // console.log(li);
  }

  function deleteItem(e) {
      e.parentNode.remove();
  }

  function editItem(e) {
      var val = e.parentNode.firstChild.nodeValue;
      var editValue = prompt("Enter the updated Value", val);
      e.parentNode.firstChild.nodeValue = editValue;
  }

  function deleteAll() {
      list.innerHTML = "";
  }