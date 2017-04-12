//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by David Boles on 4/8/17.
//  Copyright © 2017 David Boles. All rights reserved.
//

import UIKit
import CoreData


class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var stores = [Shop]()
    
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        
        
//        let store = Shop(context: context)
//        store.name = "Best Buy"
//        let store2 = Shop(context: context)
//        store2.name = "Tesla Dealership"
//        let store3 = Shop(context: context)
//        store3.name = "K Mart"
//        let store4 = Shop(context: context)
//        store4.name = "Trader Joe's"
//        let store5 = Shop(context: context)
//        store5.name = "Amazon"
//        let store6 = Shop(context: context)
//        store6.name = "E-Bay"
//        
//        ad.saveContext()
            getStores()
        
    
    
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //code  
        
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Shop> = Shop.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }  catch {
            //error message
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
