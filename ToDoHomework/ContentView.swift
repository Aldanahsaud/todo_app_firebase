//
//  ContentView.swift
//  ToDoHomework
//
//  Created by AlDanah Aldohayan on 05/11/2021.
//




import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject var model = ViewModel()
    @State var title: String = ""
    @State var notes: String = ""
    @State var isFav: Bool = false
    @State var showSheet = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        TabView{
            ZStack(alignment: .top){
                VStack(spacing: 20){
                    Text("Add a new task ↯")
                    Divider()
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Note", text: $notes)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Toggle(isOn: $isFav, label: {Text("")})
                    Button("Add"){
                        model.addData(title: title, notes: notes, isFav: isFav)
                        title = ""
                        notes = ""
                        isFav = false
                    }
                }.padding(.horizontal)
            }
            
            .tabItem{
                Label("Add", systemImage: "plus.square")
            }
            
            
            ZStack(alignment: .top){
                VStack{
                    NavigationView{
                        List {
                            ForEach(model.arrayList){ item in
                                HStack{
                                    NavigationLink{
                                        ZStack{
                                            VStack(spacing: 20){
                                                Text(item.title)
                                                Divider()
                                                Text(item.notes)
                                                Button{
                                                    model.updateData(todoUpdate: item)
                                                } label: {
                                                    Image(systemName: "pencil.circle.fill")
                                                }
//                                                .sheet(isPresented: $showSheet) {
//                                                    Text("HI TEST")
//                                                    VStack{
//                                                        TextField("Update Title", text: self.$title)
//                                                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                                                        TextField("Update Note", text: self.$notes)
//                                                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                                                        Toggle(isOn: self.$isFav, label: {Text("")})
//                                                        Button("Update"){
//                                                            model.updateData(todoUpdate: item)
//                                                            self.showSheet = false
//                                                        }
//                                                    }
//                                                }
                                            }.padding(.horizontal)
                                        }
                                    } label: {
                                        Text(item.title)
                                        Text(":")
                                        Text(item.notes)
                                        Spacer()
                                        Button{
                                        } label: {
                                            Image(systemName: item.isFav ? "heart.fill" : "heart")
                                        }.buttonStyle(.borderless)
                                    }
                                    
                                    
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button{
                                        model.deleteData(todoDelete: item)
                                    } label: {
                                        Image(systemName: "trash")
                                    }.tint(.red)
                                        .buttonStyle(BorderlessButtonStyle())
                                }
                            }
                        }
                    }
                    
                }
            }
            .tabItem{
                Label("Tasks", systemImage: "list.bullet")
            }
            
        }
        .preferredColorScheme(.dark)
    }
    init() {
        model.getData()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
