//
//  ViewModel.swift
//  ToDoHomework
//
//  Created by AlDanah Aldohayan on 06/11/2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI


class ViewModel: ObservableObject {

    @Published var arrayList = [ToDo]()

    func getData() { /*reading data*/

        // Get a reference to the database
        let db = Firestore.firestore()

        // Read the documents at a specific path
        db.collection("ToDo").getDocuments { snapshot, error in

            // Check for errors
            if error == nil {
                // No errors

                if let snapshot = snapshot {

                    // Update the list property in the main thread
                    DispatchQueue.main.async {

                        // Get all the documents and create Todos
                        self.arrayList = snapshot.documents.map { d in

                            // Create a Todo item for each document returned
                            return ToDo(id: d.documentID,
                                        title: d["title"] as? String ?? "",
                                        notes: d["notes"] as? String ?? "",
                                        isFav: d["isFav"] as? Bool ?? false
                                        //                                        iconChoose: d["iconChoose"] as? String ?? ""
                            )
                        }
                    }


                }
            }
            else {
                // Handle the error
                //                Text("oopsie.. an error happend")
            }
        }
    }

    func addData(title: String, notes: String, isFav: Bool) {

        // Get a reference to the database
        let db = Firestore.firestore()

        // Add a document to a collection
        db.collection("ToDo").addDocument(data: ["title":title, "notes":notes, "isFav":isFav]) { error in

            // Check for errors
            if error == nil {
                // No errors

                // Call get data to retrieve latest data
                self.getData()
            }
            else {
                // Handle the error
            }
        }
    }
    
    func deleteData(todoDelete: ToDo) {

        // Get a reference to the database
        let db = Firestore.firestore()

        // Specify the document to delete
        db.collection("ToDo").document(todoDelete.id).delete { error in

            // Check for errors
            if error == nil {
                // No errors

                // Update the UI from the main thread
                DispatchQueue.main.async {

                    // Remove the todo that was just deleted
                    self.arrayList.removeAll { todo in

                        // Check for the todo to remove
                        return todo.id == todoDelete.id
                    }
                }


            }
        }

    }
    
    func updateData(todoUpdate: ToDo) {
        // Get a reference to the database
        let db = Firestore.firestore()
        // Set the data to update
        db.collection("ToDo").document(todoUpdate.id).setData(["title": "Updated \(todoUpdate.title)", "notes": "Updated \(todoUpdate.notes)", "isFav":"Updated \(todoUpdate.isFav)"], merge: true){ error in
            // Check for errors
            if error == nil {
                // Get the new data(
                self.getData()
            }
        }
    }
}


// .setData(["title":todoUpdate.title, "notes":todoUpdate.notes, "isFav":todoUpdate.isFav], merge: false)
//.updateData(["title":todoUpdate.title, "notes":todoUpdate.notes, "isFav":todoUpdate.isFav])
