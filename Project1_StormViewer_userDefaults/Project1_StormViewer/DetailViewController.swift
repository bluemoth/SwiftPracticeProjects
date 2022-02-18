//
//  DetailViewController.swift
//  Project1_StormViewer
//
//  Created by Jacob Case on 1/15/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var pictureNumber: Int?
    var numPictures: Int?
    var timesClicked: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(pictureNumber!) of \(numPictures!) & tapped \(timesClicked!)"
        navigationItem.largeTitleDisplayMode = .never

        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
