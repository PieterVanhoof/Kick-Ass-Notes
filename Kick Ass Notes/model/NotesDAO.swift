//
//  notesDAO.swift
//  Kick Ass Notes
//
//  Created by mobapp12 on 28/01/2019.
//  Copyright © 2019 mobapp12. All rights reserved.
//

import Foundation
import CoreData

class NotesDao{
    //singleton pattern
    //een statische instance van Klasse zelf
    static let sharedInstance:NotesDao = NotesDao.init()
    //om te vermijden dat nieuwe instance wordt gemaakt, constructor private
    private init(){
        //enkel om geen nieuwe instanties te kunnen maken
        
    }
    //mark Core Data
    //opbouwen persistent container (Core Data Laag)
    //lazy; pas aanmaken vanaf dat het opgevraagd is
    lazy var persistentContainer: NSPersistentContainer = {
        //verwijzing naar datamodel, waar zijn de entiteiten
        let container = NSPersistentContainer.init(name: "Model")
        //zoekt in achterliggende store (dao etc.) naar data om alles in te vullen
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            //eventuele foutafhandeling
           
        })
        return container
        
    }()//blok ook effectief laten uitvoeren
    
    //zorgen voor opslaan van wijzigingen
    private func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges{
            //swift do catch, code uitvoeren, indien iets misloopt catch om op te vangen
            do{
                try context.save()
            }catch {
                //hier kan je fouten opvangen, omzetten naar NSerror om meer info te hebben
                let fout = error as NSError
                print("fout met opslaan \(fout)")
            }
        }
    }
    func saveNote(title: String, content: String){
        //maak een note
        //zorg dat de note in de persistent container zit
        let newNote = Note(context: persistentContainer.viewContext)
        newNote.title = title
        newNote.content = content
        
        //savecontext, er zijn wijzigingen in de container, doorgestuurd nnar db
        saveContext()
    }
    
    //Read
    func getAllNotes() -> [Note]{
        //bouwt query op achterliggend, request algemenere naam, data niet perse in db
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Note")
        
        //querry uitvoeren, opvangen fouten nodig bv. entity niet gevonden, geen toegang, ...
        do{
            let notes:[Note] = try persistentContainer.viewContext.fetch(request) as! [Note]
            return notes
        }catch{
            //iets misgelopen
        }
        //indien de request niet kon uitvoeren, lege lijst teruggeven
        return[]
        
        
    }
    
}
