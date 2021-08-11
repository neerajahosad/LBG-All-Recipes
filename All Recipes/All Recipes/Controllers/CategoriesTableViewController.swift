//
//  CategoriesTableViewController.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 08/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//
import Foundation
import UIKit
import SDWebImage

class CategoriesTableViewController: UITableViewController {
    @IBOutlet weak var categoriesTableView : UITableView!
    
    var categoriesVM : CategoryListViewModel!
    var selectedCategory : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.delegate = self
        categoriesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        fetchCategories()
    }
    
    func fetchCategories(){
        DataService().loadCategoriesAPIRequest(with: URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!){ categories in
            self.categoriesVM = CategoryListViewModel(categories:categories)
            DispatchQueue.main.async {
                self.categoriesTableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoriesTableView.estimatedRowHeight = 400.0
        categoriesTableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoriesVM == nil ? 0 : self.categoriesVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell") as? CategoriesTableViewCell{
            let categoryVM = self.categoriesVM.categoryAtIndex(indexPath.row)
            cell.configureCell(urlString: categoryVM.image)
            cell.categoriesTitle.text = categoryVM.title
            cell.categoriesDescription.text = categoryVM.description
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedCategory = categoriesVM.categories[indexPath.row].strCategory
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? CategoryTableViewController else {
            return
        }
        destinationVC.isRecipe = 1
        destinationVC.categoryData = selectedCategory
    }
}

class CategoriesTableViewCell : UITableViewCell{
    @IBOutlet weak var categoriesImage : UIImageView!
    @IBOutlet weak var categoriesTitle : UILabel!
    @IBOutlet weak var categoriesDescription : UITextView!
    @IBOutlet weak var categoryView : UIView!
    
    func configureCell(urlString : String){
        //categoriesImage.load(urlString: urlString)
        categoriesImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        categoryView.layer.cornerRadius = 10.0
        categoryView.layer.borderColor = UIColor(displayP3Red: 81/255, green: 103/255, blue: 108/255, alpha: 1.0).cgColor
        categoryView.layer.borderWidth = 1.0
    }
}
