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
    
    fileprivate let model = CategoryViewModel()
    var selectedCategory : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.delegate = self
        categoriesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        model.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoriesTableView.estimatedRowHeight = 400.0
        categoriesTableView.rowHeight = UITableView.automaticDimension
        model.fetchCategories()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell") as? CategoriesTableViewCell{
            cell.configureCell(urlString: self.model.categories[indexPath.row].strCategoryThumb)
            cell.categoriesTitle.text = self.model.categories[indexPath.row].strCategory
            cell.categoriesDescription.text = self.model.categories[indexPath.row].strCategoryDescription
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedCategory = self.model.categories[indexPath.row].strCategory
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

extension CategoriesTableViewController : CategoryViewModelProtocol{
    func didUpdateCategories() {
        self.categoriesTableView.reloadData()
    }
}

class CategoriesTableViewCell : UITableViewCell{
    @IBOutlet weak var categoriesImage : UIImageView!
    @IBOutlet weak var categoriesTitle : UILabel!
    @IBOutlet weak var categoriesDescription : UITextView!
    @IBOutlet weak var categoryView : UIView!
    
    func configureCell(urlString : String){
        categoriesImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        categoryView.layer.cornerRadius = 10.0
        categoryView.layer.borderColor = UIColor(displayP3Red: 81/255, green: 103/255, blue: 108/255, alpha: 1.0).cgColor
        categoryView.layer.borderWidth = 1.0
    }
}
