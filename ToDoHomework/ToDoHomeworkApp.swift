//
//  ToDoHomeworkApp.swift
//  ToDoHomework
//
//  Created by AlDanah Aldohayan on 05/11/2021.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    print("Colors application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
    FirebaseApp.configure()
    return true
  }
}

@main
struct ToDoHomeworkApp: App {
    
//    here i commented class AppDelegate + line 28 then added line25,26, and 27 but both not working
//    init(){
//        FirebaseApp.configure()
//    }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
