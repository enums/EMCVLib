//
//  ImageViewController.swift
//  EMCVLibDemo-iOS
//
//  Created by 郑宇琦 on 2017/4/14.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import UIKit
import EMCVLibiOS

class ImageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var curImage: EMCVImage! {
        didSet {
            redrawImage()
        }
    }
    
    var curFilter: EMCVFilter!
    
    var actions: [(String, EMCVFilterOperation)] = [
        ("Flip X", EMCVFilterOperation.init(block: { img in
            img?.flipWithXAxis()
        })),
        ("Flip Y", EMCVFilterOperation.init(block: { img in
            img?.flipWithYAxis()
        })),
        ("Brightness", EMCVFilterOperation.init(block: { img in
            img?.setBrightness(20)
        })),
        ("GaussianBlur", EMCVFilterOperation.init(block: { img in
            img?.gaussianBlur(with: CGSize.init(width: 7, height: 7))
        })),
        ("Edge Detection", EMCVFilterOperation.init(block: { img in
            let ret = img?.newCanny(withThresh1: 80, andThresh2: 160)
            EMCVFactory.copy(ret, to: img)
        })),
        ("Threshold", EMCVFilterOperation.init(block: { img in
            let splitedImg = img!.splitImage()!;
            splitedImg.threshold(25, atChannal: 0)
            EMCVFactory.copy(splitedImg.image(withChannal: 0), to: img)
        }))
        
    ]
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cvImg = EMCVImage.init(image: img)
        curImage = cvImg
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        curFilter = EMCVFilter.init()
        let img = EMCVImage.init(path: Bundle.main.path(forResource: "test_img", ofType: "jpg"))
        img?.cvtColor(Int32(CV_BGR2RGB))
        curImage = img
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func menu(_ sender: Any) {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction.init(title: "Open image", style: .default, handler: { _ in
            let pick = UIImagePickerController.init()
            pick.delegate = self
            self.present(pick, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction.init(title: "Rest filter", style: .default, handler: { _ in
            self.curFilter.popAll()
            self.redrawImage()
        }))
        alert.addAction(UIAlertAction.init(title: "Calcel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func redrawImage() {
        let displayImg = curImage.makeACopy()!
        curFilter.run(with: displayImg)
        let splitedImg = displayImg.splitImage()!
        var rPoint = CGPoint.init()
        var gPoint = CGPoint.init()
        var bPoint = CGPoint.init()
        splitedImg.findMaxValue(nil, outPoint: &rPoint, inChannal: 0)
        displayImg.drawARect(withCenter: rPoint, size: CGSize.init(width: 20, height: 20), rgbColor: &kEMCVLibColorRed.0, thickness: 2)
        if splitedImg.channalCount == 3 {
            splitedImg.findMaxValue(nil, outPoint: &gPoint, inChannal: 1)
            displayImg.drawARect(withCenter: gPoint, size: CGSize.init(width: 20, height: 20), rgbColor: &kEMCVLibColorGreen.0, thickness: 2)
            splitedImg.findMaxValue(nil, outPoint: &bPoint, inChannal: 2)
            displayImg.drawARect(withCenter: bPoint, size: CGSize.init(width: 20, height: 20), rgbColor: &kEMCVLibColorBlue.0, thickness: 2)
        }

        imageView.draw(displayImg)
    }
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = actions[indexPath.row].0

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let op = actions[indexPath.row].1
        curFilter.pushOperation(op)
        redrawImage()
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
