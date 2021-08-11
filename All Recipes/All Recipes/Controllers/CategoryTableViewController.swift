//
//  CategoryTableViewController.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 08/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryTableViewController: UITableViewController {
    @IBOutlet weak var categoryTableView : UITableView!
    var filterByCategoryVM : FilterCategoryListViewModel!
    var categoryData: String = ""
    var selectedMealTitle : String = ""
    var selectedMealID : String = ""
    var isRecipe : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.delegate = self
        categoryTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        categoryTableView.rowHeight = 140.0
        var recipeString = "https://www.themealdb.com/api/json/v1/1/filter.php"
        if isRecipe == 1{
            recipeString += "?c=\(categoryData)"
        }
        else if isRecipe == 2{
            recipeString += "?a=\(categoryData)"
        }
        let recipeURL = URL(string:recipeString)!
        filterByCategory(url : recipeURL)
        title = categoryData
    }
    
    func filterByCategory(url : URL){
        DataService().loadFilterByCategoryAPIRequest(with: url){ filterByCategories in
            self.filterByCategoryVM = FilterCategoryListViewModel(categoriesFilter:filterByCategories)
            DispatchQueue.main.async {
                self.categoryTableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.filterByCategoryVM == nil ? 0 : self.filterByCategoryVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterByCategoryVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "filterByCategoryCell") as? FindByCategoryTableViewCell{
            let categoryVM = self.filterByCategoryVM.categoryAtIndex(indexPath.row)
            cell.configureCell(urlString:categoryVM.image)
            cell.filterByCategoryTitle.text = categoryVM.title
            return cell
        }
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let categoryVM = self.filterByCategoryVM.categoryAtIndex(indexPath.row)
        selectedMealID = categoryVM.id
        selectedMealTitle = categoryVM.title
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? RecipeDetailsViewController else {
            return
        }
        destinationVC.recipeTitle = selectedMealTitle
        destinationVC.recipeData = selectedMealID
    }
}

class FindByCategoryTableViewCell : UITableViewCell{
    @IBOutlet weak var filterByCategoryImage : UIImageView!
    @IBOutlet weak var filterByCategoryTitle : UILabel!
    @IBOutlet weak var filterByCategoryView : UIView!
    
    func configureCell(urlString : String){
        filterByCategoryImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
    }
}
