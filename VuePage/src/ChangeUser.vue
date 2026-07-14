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
    import { ref } from 'vue'

    const props = defineProps({
        users: Array
    })

    /*remember that it matches based on the name of the .js variable, so the parameter in ref just determines it's default
    value*/
    const name = ref("");
    const email = ref("");

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

        /*needed to update users state. If you didn't modify the props directly, the data wouldn't be displayed correctly
        on the list page*/
        props.users.push(result);   
        alert("Successfully created user");
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


        const USER = props.users.find(user => user.email === email.value);
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
        if (response.ok){
            const index = props.users.findIndex(user => user.id === ID);
            props.users.splice(index, 1); //removes user
        }

        
        alert("Successfully deleted user");
    }
</script>