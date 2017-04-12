//
//  MainVC.swift
//  DreamLister
//
//  Created by David Boles on 2/16/17.
//  Copyright © 2017 David Boles. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Thing>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        generateTestData()
        attemptFetch()
        
    
    
    
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThingCell", for: indexPath) as! ThingCell
            configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ThingCell, indexPath: NSIndexPath) {
        
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {

        if let sections = controller.sections {
            return sections.count
            
        }
        return 0
    
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func attemptFetch() {
        
        let fetchRequest:  NSFetchRequest<Thing> = Thing.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        self.controller = controller    
        
        
        do {
            
            try controller.performFetch()
            
        } catch {
            let error = error as NSError
            print ("\(error)")
            
        }
        
        
        
    }
   
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ThingCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
            
        }
    }
    
    
    func generateTestData() {
        
        let item = Thing(context: context)
        item.name = "SmackBook Pro"
        item.cost = 1000000
        item.details = "A sweet computer"
        
        let item2 = Thing(context: context)
        item2.name = "Bunny Rabbit"
        item2.cost = 300
        item2.details = "They are so cute and cuddly!"
        
        let item3 = Thing(context: context)
        item3.name = "Tesla Model X"
        item3.cost = 80000
        item3.details = "It's a beautiful car!!"
        
        ad.saveContext()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

