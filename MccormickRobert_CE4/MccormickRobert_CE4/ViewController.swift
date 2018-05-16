//
//  ViewController.swift
//  MccormickRobert_CE4
//
//  Created by Robert  McCormick on 15/01/2018.
//  Copyright © 2018 Robert  McCormick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    
    //store imageView in this list
    var imageViews : [UIImageView] = []
    
    //the queues
    var mySerialQueue : DispatchQueue!
    var myConcurrentQueue : DispatchQueue!
    
    //This is list of image links
    let listOfURL = ["http://hdwallpapersphotosimagespictures.samundri-industry.com/wp-content/uploads/2015/08/1920x1080-Wallpaper-128.jpg","https://i.ytimg.com/vi/3EexsZCaFNA/maxresdefault.jpg","http://hddesktopwallpapers.in/wp-content/uploads/2015/09/1080p-leaves-background.jpg","https://cdn.wallpapersafari.com/34/18/J9a5ME.jpg","http://mojmalnews.com/wp-content/uploads/2017/08/new-hd-wallpaper-1080p-nature-16-nature-wallpapers-hd-1080p-desktop-background-1920x1080.jpg","https://www.wallpapersbrowse.com/images/4k/4k1vpip.jpg","https://www.wallpapersbrowse.com/images/4k/4k1vpip.jpg","https://i.pinimg.com/originals/9b/4a/8c/9b4a8c81c21ce6a51613257b4dbe3e37.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Add each imageView to list imageViews
        imageViews += [imageView1];
        imageViews += [imageView2];
        imageViews += [imageView3];
        imageViews += [imageView4];
        imageViews += [imageView5];
        imageViews += [imageView6];
        imageViews += [imageView7];
        imageViews += [imageView8];
        
        //create queue
        mySerialQueue = DispatchQueue(label: "mySerialQueue")
        myConcurrentQueue = DispatchQueue(label: "myConcurrentQueue",attributes:[.concurrent])
        
    }
    
    //download Regular
    @IBAction func downloadRegularAction(_ sender: Any) {
        for idx in 0..<imageViews.count {
            let url = URL(string: listOfURL[idx])!
            let data = try! Data(contentsOf: url)
            imageViews[idx].image = UIImage(data: data)
        }
    }
    
    //clear
    @IBAction func clearAllViewsAction(_ sender: Any) {
        for imgv in imageViews {
            imgv.image = nil
        }
    }
    
    //download Serial
    @IBAction func downloadSerialAction(_ sender: Any) {
        for idx in 0..<imageViews.count {
            mySerialQueue.async {
                let url = URL(string: self.listOfURL[idx])!
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.imageViews[idx].image = UIImage(data: data)
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //download Concurrent
    @IBAction func downloadConcurrentAction(_ sender: Any) {
        for idx in 0..<imageViews.count {
            myConcurrentQueue.async {
                let url = URL(string: self.listOfURL[idx])!
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.imageViews[idx].image = UIImage(data: data)
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

