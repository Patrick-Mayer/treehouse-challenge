<template>
  <h1>Change User Page</h1>
  <p>Enter Name:</p>
  <input v-model="name">
  <p>Enter Email:</p>
  <input v-model="email">
  <br><br><br>
  <div class="DataButtons">
    <button @click="CreateUser()">Create User</button>
    <button @click="DeleteUser()">Delete User</button>
  </div>
</template>

<script setup>
    import { ref, onMounted } from 'vue'
    const name = ref("name");
    const email = ref("email");
    const users = ref([]);

    onMounted(async () => {
        const response = await fetch(
            "https://treehousechallenge.contractornation.com/newsletter",
            {
            method: "GET",
            headers: {
                Authorization: "3b7d7b60-7ed1-11f1-8328-0963ebbe9e26",
                "Content-Type": "application/json",
            },
            }
        );

        users.value = await response.json();

        console.log(users.value);
    });

    async function CreateUser(){
        if ((name.value == "") || (name == undefined)){
            alert("Invalid name");
            return;
        }
        if ((email.value == "") || (email == undefined)){
            alert("Invalid email");
            return;
        }


        const response = await fetch(
            "https://treehousechallenge.contractornation.com/newsletter",
            {
                method: "POST",
                headers: {
                    Authorization: "3b7d7b60-7ed1-11f1-8328-0963ebbe9e26",
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    name: name.value,
                    email: email.value,
                }),
            }
        );

        const result = await response.json();
        console.log(result);
        console.log("Create pressed");

        users.value.push(result);   //needed to update users state
    }

    async function DeleteUser(){
        if ((name.value == "") || (name == undefined)){
            alert("Invalid name");
            return;
        }
        if ((email.value == "") || (email == undefined)){
            alert("Invalid email");
            return;
        }


        const USER = users.value.find(user => user.email === email.value);
        if (USER == undefined){
            alert("User is undefined");
            return;
        }
        const ID = USER.id;

        const response = await fetch(
            `https://treehousechallenge.contractornation.com/newsletter/${ID}`,
            {
                method: "DELETE",
                headers: {
                    Authorization: "3b7d7b60-7ed1-11f1-8328-0963ebbe9e26",
                },
                //treating email as the ID since two users with the same email would be a mistake
                body: JSON.stringify({
                    action: "delete",
                    name: name.value,
                    email: email.value,
                }),
            }
        );

        const result = await response.json();
        console.log(result);
        if (result.ok){
            users.value = users.value.filter(user => user.id !== ID); //removes user
        }

        console.log("Create pressed");
    }
</script>