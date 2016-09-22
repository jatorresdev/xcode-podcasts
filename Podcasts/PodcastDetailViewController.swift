//
//  PodcastDetailViewController.swift
//  Podcasts
//
//  Created by Angel Torres on 21/09/16.
//  Copyright © 2016 Angel Torres. All rights reserved.
//

import UIKit
import MediaPlayer
import Moya

class PodcastDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var mediaPlayer: MPMoviePlayerController = MPMoviePlayerController()
    
    var podcast: NSDictionary!
    var episodesPodcast = NSArray()
    
    @IBOutlet weak var imagePodcastDetail: UIImageView!
    @IBOutlet weak var descriptionPodcastDetail: UITextView!
    @IBOutlet weak var episodesPodcastTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodesPodcastTableView.delegate = self
        episodesPodcastTableView.dataSource = self
        
        self.title = podcast.value(forKey: "serie") as? String
        
        // Carga Image
        let image = podcast.value(forKey: "imagen") as? NSDictionary
        let url = NSURL(string: image?["src"] as! String)
        let data = NSData(contentsOf: url as! URL)
        imagePodcastDetail.image = UIImage(data: data as! Data)
        
        descriptionPodcastDetail.text = (podcast.value(forKey: "descripcion") as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Carga episodios
        let podcastId = Int((podcast.value(forKey: "id") as? String)!)
        downloadEpisodePodcast(podcastId: podcastId!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return episodesPodcast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodesPodcastTableCell") as! EpisodeTableViewCell
        let episode = episodesPodcast[(indexPath as NSIndexPath).row] as? NSDictionary
        cell.titleEpisode.text = episode?["episodio"] as? String
        cell.playEpisode.text = "▶️"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodesPodcast[(indexPath as NSIndexPath).row] as? NSDictionary
        mediaPlayer.stop()
        mediaPlayer.contentURL = NSURL(string: episode?.value(forKey: "audio") as! String) as URL!
        mediaPlayer.play()
        if let cell = tableView.cellForRow(at: indexPath) as? EpisodeTableViewCell {
            cell.playEpisode.text = "◾️"
        }
    }
    
    
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    func downloadEpisodePodcast(podcastId: Int) {
        _ = PodcastsRadionicaProvider.request(.episodesPodcast(podcastId)) { result in
            switch result {
            case let .success(response):
                do {
                    if let json = try response.mapJSON() as? NSDictionary {
                        self.episodesPodcast = (json.value(forKey: "episodiosPodcast") as? NSArray)!
                    } else {
                        self.showAlert("Obtener episodios", message: "No es posible obtener los episodios de \(self.podcast.value(forKey: "serie")) en Radiónica")
                    }
                } catch {
                    self.showAlert("Obtener episodios", message: "No es posible obtener los episodios de \(self.podcast.value(forKey: "serie")) en Radiónica")
                }
                self.episodesPodcastTableView.reloadData()
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                self.showAlert("Obtener episodios \(self.podcast.value(forKey: "serie"))", message: error.description)
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
