// Import the functions you need from the SDKs you need
import { initializeApp } from "https://www.gstatic.com/firebasejs/9.6.2/firebase-app.js";
import { getDatabase, ref, onValue } from "https://www.gstatic.com/firebasejs/9.6.2/firebase-database.js"
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "",
  authDomain: "",
  databaseURL: "",
  projectId: "",
  storageBucket: "",
  messagingSenderId: "",
  appId: ""
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getDatabase();

const userRef = ref(db, 'users/12345');
onValue(userRef, (snapshot) =>{
    const data = snapshot.val();
    var map = L.map('map').setView([data.location.lat, data.location.lng], 13);
    console.log(data);
})