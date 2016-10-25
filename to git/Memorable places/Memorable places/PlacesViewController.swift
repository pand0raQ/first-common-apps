//
//  PlacesViewController.swift
//  Memorable places
//
//  Created by Halik Magomedov on 10/17/16.
//  Copyright © 2016 Haliks. All rights reserved.
//

import UIKit
var places = [Dictionary<String, String>()]
 var activePlace = -1


class PlacesViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()        
        
}
    override func viewDidAppear(_ animated: Bool) {
        
        if let tempPlaces =   UserDefaults.standard.object(forKey: "places") as? [Dictionary<String, String>] {
            places = tempPlaces
            
        }
        
        if places.count == 1 && places[0].count == 0{
            places.remove(at: 0)
            places.append(["name":"Tour Eiffel", "lat":"48.858093","lon":"2.294694"])
            
            UserDefaults.standard . set(places,forKey: "places")
            
            
        }
        activePlace = -1
        table.reloadData()
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            places.remove(at: indexPath.row)
            UserDefaults.standard . set(places,forKey: "places")
            table.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        if places[indexPath.row]["name"] != nil{
        cell.textLabel?.text = places [indexPath.row]["name"]
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activePlace = indexPath.row
        performSegue(withIdentifier: "toMap" , sender: nil)
        
        
        
    }
    
    
    

}
