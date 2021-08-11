//
//  ViewController.swift
//  All Recipes
//
//  Created by Neeraja Hosad on 07/08/21.
//  Copyright © 2021 Neeraja Hosad. All rights reserved.
//
import UIKit
import SDWebImage

class RecipeDetailsViewController: UIViewController {
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var recipeTableView : UITableView!
    var recipesVM : RecipeListViewModel!
    var ingredients : [String] = []
    var recipeData: String = ""
    var recipeTitle: String = ""
    var isFavourite = false
    var favouriteRecipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.delegate = self
        fetchRecipes(string: recipeData)
        title = recipeTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "bookmark"),
            style: .plain,
            target: self,
            action: #selector(buttonTappedAction)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipeTableView.estimatedRowHeight = 50.0
        recipeTableView.rowHeight = UITableView.automaticDimension
    }
    
    
    func fetchRecipes(string : String){
        let a = Int(string)
        DataService().loadRecipesAPIRequest(with: URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(a!)")!){recipes in
            self.recipesVM = RecipeListViewModel(recipes:recipes)
            let urlString = self.recipesVM.recipeAtIndex(0).image
            DispatchQueue.main.async {
                self.recipeTableView.reloadData()
                self.imageView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
            }
        }
    }
    
    @objc private func buttonTappedAction() {
        self.isFavourite = !self.isFavourite;
        if self.isFavourite {
            navigationItem.rightBarButtonItem?.image = UIImage(named: "bookmark-selected")
            triggerAlertController(with:"Yay! This recipe has been added to your favourites.")
        }else{
            navigationItem.rightBarButtonItem?.image = UIImage(named: "bookmark")
            triggerAlertController(with:"This recipe has been removed to your favourites.")
        }
    }
    
    func triggerAlertController(with message: String){
        let alert = UIAlertController(title: "Favourites", message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            //Cancel Action
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension RecipeDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.recipesVM == nil ? 0 : self.recipesVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section{
        case 0: return "INGREDIENTS"
        case 1: return "INSTRUCTIONS"
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if let ingredientsCell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell") as? IngredientsTableViewCell{
                ingredientsCell.recipeIngredients.text = recipesVM.recipes[0].ingredientsList[indexPath.row]
                ingredientsCell.recipeMeasure.text = recipesVM.recipes[0].ingredientsMeasureList[indexPath.row]
                return ingredientsCell
            }
        }else {
            if let instructionsCell = tableView.dequeueReusableCell(withIdentifier: "instructionsCell") as? InstructionsTableViewCell{
                instructionsCell.instructionsLabel?.text = "Step \(indexPath.row+1) : " + recipesVM.recipes[0].instructionsList[indexPath.row]
                return instructionsCell
            }
        }
        return UITableViewCell()
    }
}

class IngredientsTableViewCell : UITableViewCell{
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var recipeMeasure : UILabel!
}

class InstructionsTableViewCell : UITableViewCell{
    @IBOutlet weak var instructionsLabel: UILabel!
}

