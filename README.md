# Note App 📓

A simple, intuitive Note App built with Flutter and SQLite for managing personal notes locally on your device.

## Demo Video 🎥

- Watch the video about the note app.
  
https://github.com/user-attachments/assets/01ad3bbc-9a84-48fb-a5fd-a958104f1894


## Features ✨

- **Create, Read, Update, and Delete (CRUD)** notes
- **Local Storage** with SQLite for offline access
- **Simple UI** for easy note-taking and management

## Installation 🛠️

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/note-app.git
   cd note-app

2. **Install dependencies**:
   ```bash
   flutter pub get
3. **Run the app**:
   ```bash
   flutter run
   
## Dependencies 🧩

This project relies on the following packages:
- sqflite: For SQLite database management.
- path_provider: For accessing the app's file storage.

## Folder Structure 📂

The key folders and files in this project include:
- lib/: Contains the main code for the app.
    - main.dart: Entry point of the application.
    - models/: Contains the data model for notes.
    - db_helper/: Contains the SQLite database helper functions.

## Usage 📋
- Add a Note: Press the "+" button on the home screen, enter your note, and save.
- Edit a Note: Tap on any note to edit the content.
- Delete a Note: Delete a note to delete it from your list.
