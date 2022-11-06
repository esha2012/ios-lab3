//
//  FontSizesViewController.swift
//  IOS_lab3
//
//  Created by Esha  on 2022-11-03.
//

import UIKit

class FontSizesViewController: UITableViewController {

    var font: UIFont!
        private static let pointSizes: [CGFloat] = [
            9, 10, 11, 12, 13, 14, 18, 24, 36, 48, 64, 72, 96, 144
        ]
        private static let cellIdentifier = "FontNameAndSize"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = FontSizesViewController.pointSizes[0]

    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
            let pointSize = FontSizesViewController.pointSizes[indexPath.row]
            return font.withSize(pointSize)
        }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return FontSizesViewController.pointSizes.count
       }

       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(
               withIdentifier: FontSizesViewController.cellIdentifier,
               for: indexPath)
           
           cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
           cell.textLabel?.text = font.fontName
           cell.detailTextLabel?.text =
               "\(FontSizesViewController.pointSizes[indexPath.row]) point"
           
           return cell
       }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Getting  the new view controller
           
            let tableViewCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: tableViewCell)!
            let font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
            
            if segue.identifier == "ShowFontSizes" {
                let sizesVC =  segue.destination as! FontSizesViewController
                sizesVC.title = font.fontName
                sizesVC.font = font
            } else {
                let infoVC = segue.destination as! FontInfoViewController
                infoVC.title = font.fontName
                infoVC.font = font
                infoVC.favorite =
                    FavoritesList.sharedFavoritesList.favorites.contains(font.fontName)
            }
        }
    
}
