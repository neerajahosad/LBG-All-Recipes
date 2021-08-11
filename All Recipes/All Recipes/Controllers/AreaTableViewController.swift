//
//  AreaTableViewController.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 10/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//

import UIKit

class AreaTableViewController: UITableViewController {
    @IBOutlet weak var areaTableView : UITableView!
    var areasVM : AreaListViewModel!
    var selectedArea : String = ""
    var areaData : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAreas(string: areaData)
        areaTableView.rowHeight = 50.0
        areaTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func fetchAreas(string : String){
        DataService().loadAreasAPIRequest(with: URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?a=list")!){areas in
            self.areasVM = AreaListViewModel(areas:areas)
            DispatchQueue.main.async {
                self.areaTableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.areasVM == nil ? 0 : self.areasVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areasVM.numberOfRowsInSection(section)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "areaCell") as? AreaTableViewCell{
            let areaVM = self.areasVM.areaAtIndex(indexPath.row)
            cell.areaTitle.text = areaVM.title
            cell.configureCell()
            return cell
        }
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let areaVM = self.areasVM.areaAtIndex(indexPath.row)
        selectedArea = areaVM.title
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? CategoryTableViewController else {
            return
        }
        destinationVC.isRecipe = 2
        destinationVC.categoryData = selectedArea
    }
}

class AreaTableViewCell : UITableViewCell{
    @IBOutlet weak var areaTitle : UILabel!
    @IBOutlet weak var areaView : UIView!
    
    func configureCell(){
        areaView.layer.borderColor = UIColor(displayP3Red: 81/255, green: 103/255, blue: 108/255, alpha: 1.0).cgColor
        areaView.layer.borderWidth = 2.0
    }
}

