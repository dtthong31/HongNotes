Hong Notes

**Overview**
This application allows users to interact with a note-taking feature. It integrates with Firebase to handle data storage and retrieval. The key functionalities include setting a username, saving notes, viewing personal notes, and browsing notes from other users.

**Features**
  1. Set Username
    Description: Users can set their unique username which is used to identify their notes in the Firebase database.
    Implementation: This feature is implemented using a simple form where the user inputs their desired username. The username is then stored locally and used for subsequent operations with the Firebase database.
  2. Save a Note
    Description: Users can write and save short notes.
    Implementation: A text input field is provided for users to write their notes. On submission, the note, along with the user's username, is saved to the Firebase database.
  3. View Personal Notes
    Description: Users can view a list of all the notes they have saved.
    Implementation: The application fetches and displays a list of notes associated with the user's username from the Firebase database. This list is updated in real-time to reflect any new additions.
  4. View All Users' Notes
    Description: Users can view notes saved by all users of the application.
    Implementation: A separate view is provided where notes from all users are fetched from the Firebase database and displayed.

**Technical Details**
  Platform: iOS 
  Language: Swift (for iOS)
  Database: Firebase Realtime Database
  Dependencies: List any dependencies or libraries used
  Building and Running the Application
  Prerequisites: XCode, CocoaPods, Firebase account
  
**Setup:**
Clone the repository: git clone 
Install dependencies: pod install (for iOS).
Running the App: Open the project in XCode and run it on a simulator or physical device (you need apple developer account).
