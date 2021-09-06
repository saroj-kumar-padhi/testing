importScripts('script src="https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-auth.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-firestore.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-analytics.js');


 firebase.initializeApp = {
    apiKey: "AIzaSyBZ13A_jaEZIItP8ezgFVwrFDmkBJohBbk",
    authDomain: "swastik13-8242d.firebaseapp.com",
    databaseURL: "https://swastik13-8242d.firebaseio.com",
    projectId: "swastik13-8242d",
    storageBucket: "swastik13-8242d.appspot.com",
    messagingSenderId: "536545876267",
    appId: "1:536545876267:web:47bc0d6cf84e6592abcd6e",
    measurementId: "G-V0WV8E6JVW"
  };

  const messaging = firebase.messaging();