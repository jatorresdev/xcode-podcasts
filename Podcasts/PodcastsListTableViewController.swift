//
//  PodcastsListTableViewController.swift
//  Podcasts
//
//  Created by Angel Torres on 20/09/16.
//  Copyright © 2016 Angel Torres. All rights reserved.
//

import UIKit
import Moya

class PodcastsListTableViewController: UITableViewController {
    var podcasts = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadPodcasts()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "podcastDetail" {
            
            let podcastDetailViewController = segue.destination as! PodcastDetailViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            
            podcastDetailViewController.podcast = podcasts[row] as? NSDictionary
            
        } else if segue.identifier == "anadirNota" {
            // Parametros si es necesario
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PodcastsTableCell", for: indexPath) as! PodcastTableViewCell
        
        let podcast = podcasts[(indexPath as NSIndexPath).row] as? NSDictionary
        cell.titlePodcast.text = podcast?["serie"] as? String
        
        // Carga Imagen
        let image = podcast?["imagen"] as? NSDictionary
        let url = NSURL(string: image?["src"] as! String)
        let data = NSData(contentsOf: url as! URL)
        cell.imagePodcast.image = UIImage(data: data as! Data)
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    func downloadPodcasts() {
        _ = PodcastsRadionicaProvider.request(.podcasts) { result in
            switch result {
            case let .success(response):
                do {
                    if let json = try response.mapJSON() as? NSDictionary {
                        self.podcasts = (json.value(forKey: "podcasts") as? NSArray)!
                    } else {
                        self.showAlert("Obtener podcasts", message: "No es posible obtener los podcasts de Radiónica")
                    }
                } catch {
                    self.showAlert("Obtener podcasts", message: "No es posible obtener los podcasts de Radiónica")
                }
                self.tableView.reloadData()
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                self.showAlert("Obtener podcasts", message: error.description)
            }
        }
    }
}
